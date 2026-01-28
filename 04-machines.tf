resource "google_compute_instance" "vm_instance" {
  name         = "asiwko-vm-01"
  machine_type = "f1-micro"
  zone         = "us-central1-a"

  tags = ["tf-vms"]
  
  metadata = {
      # Replace 'your-username' with your local username
      # Replace the string below with the contents of your ~/.ssh/id_rsa.pub
      ssh-keys = "gcp-user:${file("/container_shared/ansible/ansible_rsa.pub")}"
    }
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

