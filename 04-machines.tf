resource "google_compute_instance" "vm_instance" {
  name         = "asiwko-vm-01"
  machine_type = "f1-micro"
  zone         = "us-east1-c"

  tags = ["tf-vms"]
  
  boot_disk {
    initialize_params {
      image = "rhel-cloud/rhel-9"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name

    # This empty block enables a Public/External IP
    access_config {
      // Ephemeral public IP
    }
  }
}

