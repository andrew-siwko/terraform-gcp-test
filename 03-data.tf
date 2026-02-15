data "google_compute_machine_types" "available" {
  zone = var.zone
}

locals {
  free_tier_machines = [
    for machine in data.google_compute_machine_types.lab_discovery.machine_types : machine.name
    if machine.name == "e2-micro"
  ]
  gcp_instance_type = try(local.free_tier_machines[0], "e2-micro")
}

data "google_compute_image" "rhel_9" {
  # The family for the standard RHEL 9 image
  family  = "rhel-9"
  project = "rhel-cloud"
}

output "rhel_9_images" {
  value = datas.google_compute_image.rhel_9
}

