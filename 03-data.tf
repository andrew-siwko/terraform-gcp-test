data "google_compute_machine_types" "available" {
  zone = var.zone
}
output "gcp_machine_types" {
  value = [
    for machine in data.google_compute_machine_types.available.machine_types :
    format("%s: CPU=%v, RAM=%vMB", machine.name, machine.guest_cpus, machine.memory_mb)
    if machine.memory_mb <= 1024 && machine.guest_cpus <= 2
  ]
}