#----------------------------------------------------------------------------
# COMPUTE ENGINE
#----------------------------------------------------------------------------
output "compute_instance_name" {
  description = "Instance name"
  value       = module.compute_engine_instance.instance_name
}

output "compute_instance_public_ip" {
  description = "Instance public ip"
  value       = module.compute_engine_instance.public_ip
}

output "compute_instance_private_ip" {
  description = "Instance private ip"
  value       = module.compute_engine_instance.private_ip
}

output "compute_instance_vpc" {
  description = "Instance vpc"
  value       = module.compute_engine_instance.vpc.name
}

output "compute_instance_ssh_command" {
  description = "Instance ssh connect"
  value       = "gcloud compute ssh --zone ${module.compute_engine_instance.zone} ${module.compute_engine_instance.instance_name} --project ${var.project}"
}


#----------------------------------------------------------------------------
# CLOUD SQL
#----------------------------------------------------------------------------
output "cloud_sql_instance_name" {
  description = "Instance name"
  value       = module.cloud_sql.instance_name
}

output "cloud_sql_instance_public_ip" {
  description = "Instance public ip"
  value       = module.cloud_sql.public_ip
}

output "cloud_sql_instance_private_ip" {
  description = "Instance private ip"
  value       = module.cloud_sql.private_ip
}

output "cloud_sql_instance_connection_name" {
  description = "Instance connection name"
  value       = module.cloud_sql.connection_name
}

