resource "google_compute_network" "vpc_network" {
  name                    = "asiwko-network"
  auto_create_subnetworks = true
}