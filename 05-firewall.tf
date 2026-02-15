resource "google_compute_firewall" "allow-web-and-ssh" {
  name    = "allow-web-and-ssh"
  network = google_compute_network.vpc_network.id

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "443"]
  }
  allow {
    protocol = "icmp"
  }
  # This allows traffic from any IP address. 
  # For production, consider restricting "22" to your specific IP.
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["asiwko-vms"]
}