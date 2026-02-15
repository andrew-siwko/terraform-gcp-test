resource "google_compute_instance" "vm_instance" {
  name         = "vm-01"
  machine_type = local.gcp_instance_type
  zone         = var.zone

  tags = ["vms"]
  
  metadata = {
    ssh-keys = "${var.admin_username}:${file("/container_shared/ansible/ansible_rsa.pub")}"
    }    
    allow_stopping_for_update = true
    boot_disk {
    initialize_params {
      image = var.image
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

