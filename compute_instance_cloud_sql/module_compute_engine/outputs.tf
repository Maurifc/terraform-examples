output "instance_name" {
  description = "Instance name"
  value       = google_compute_instance.this.name
}

output "public_ip" {
  description = "Instance public ip"
  value       = google_compute_instance.this.network_interface.0.access_config.0.nat_ip
}

output "private_ip" {
  description = "Instance private ip"
  value       = google_compute_instance.this.network_interface.0.network_ip
}

output "vpc" {
  description = "Instance vpc"
  value       = google_compute_network.vpc
}

output "ssh_command" {
  description = "Instance ssh connect"
  value       = "gcloud compute ssh --zone ${google_compute_instance.this.zone} ${google_compute_instance.this.name} --project ${var.project}"
}

output "zone" {
  description = "Zone of the instance"
  value       = google_compute_instance.this.zone
}