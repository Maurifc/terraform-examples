#----------------------------------------------------------------------------
# COMPUTE ENGINE
#----------------------------------------------------------------------------
output "compute_engine_instances" {
  value = {
    for instance in google_compute_instance.this :
    instance.name => {
      public_ip  = instance.network_interface.0.access_config.0.nat_ip
      private_ip = instance.network_interface.0.network_ip
      ssh_connect = "gcloud compute ssh --zone ${instance.zone} ${instance.name} --project ${var.project}"
    }
  }
}

#----------------------------------------------------------------------------
# CLOUD SQL
#----------------------------------------------------------------------------
output "cloud_sql_instances" {
  value = {
    for instance in google_sql_database_instance.this :
    instance.name => {
      public_ip_address      = instance.public_ip_address
      private_ip_address     = instance.private_ip_address
      connection_name = instance.connection_name
    }
  }
}