#----------------------------------------------------------------------------
# STORAGE
#----------------------------------------------------------------------------
output "tf_backend_bucket" {
  value = google_storage_bucket.tf_backend_bucket.name
}

#----------------------------------------------------------------------------
# COMPUTE ENGINE
#----------------------------------------------------------------------------
output "compute_engine_instances" {
  value = {
    for instance in google_compute_instance.this :
    instance.name => {
      public_ip  = instance.network_interface.0.access_config.0.nat_ip
      private_ip = instance.network_interface.0.network_ip
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