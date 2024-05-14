resource "digitalocean_database_db" "passin-db" {
  cluster_id = digitalocean_database_cluster.passin-cluster.id
  name       = "passin-db"
}

resource "digitalocean_database_cluster" "passin-cluster" {
  name       = "passin-cluster"
  engine     = "pg"
  version    = "16"
  size       = "db-s-1vcpu-1gb"
  region     = "nyc1"
  node_count = 1
}