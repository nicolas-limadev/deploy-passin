FROM node:20 AS base

FROM base AS dependencies

WORKDIR /usr/src/app

COPY package.json package-lock.json ./

RUN npm install

FROM base AS build

WORKDIR /usr/src/app

COPY . .

COPY --from=dependencies /usr/src/app/node_modules ./node_modules

RUN npm run build
RUN npm prune --production

FROM node:20-alpine3.19 AS deploy

WORKDIR /usr/src/app

RUN npm install -g prisma

COPY --from=build /usr/src/app/dist ./dist
COPY --from=build /usr/src/app/node_modules ./node_modules
COPY --from=build /usr/src/app/package.json ./package.json
COPY --from=build /usr/src/app/prisma ./prisma

RUN prisma generate

EXPOSE 3333

CMD [ "npm", "start" ]