output "instance_name" {
  description = "Instance name"
  value       = google_sql_database_instance.this.name
}

output "public_ip" {
  description = "Instance public ip"
  value       = google_sql_database_instance.this.public_ip_address
}

output "private_ip" {
  description = "Instance private ip"
  value       = google_sql_database_instance.this.private_ip_address
}

output "connection_name" {
  description = "Instance connection name"
  value       = google_sql_database_instance.this.connection_name
}