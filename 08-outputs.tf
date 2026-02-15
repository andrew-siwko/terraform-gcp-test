output "google_instance_public_ip" {
  value = google_compute_instance.vm_instance.network_interface.0.access_config.0.nat_ip
}

output "gcp_machine_types" {
  value = [
    for machine in data.google_compute_machine_types.available.machine_types :
    format("%s: CPU=%v, RAM=%vMB, Description=%s", machine.name, machine.guest_cpus, machine.memory_mb,machine.description)
    if machine.memory_mb <= 1024 && machine.guest_cpus <= 2
  ]
}

output "free_tier_machine" {
  value = local.gcp_instance_type
}
