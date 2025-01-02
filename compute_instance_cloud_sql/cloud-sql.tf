#----------------------------------------------------------------------------
# MODULE CLOUD SQL
#----------------------------------------------------------------------------
module "cloud_sql" {
  source = "./module_cloud_sql"

  instance_name            = var.cloud_sql_instance_name
  database_version         = var.database_version
  tier                     = var.tier
  enable_private_network   = var.enable_private_network
  enable_ha                = var.enable_ha
  enforce_complex_password = var.enforce_complex_password

  authorized_networks = {
    "all": "0.0.0.0/0"
  }
  vpc                 = module.compute_engine_instance.vpc

  project = var.project
  region  = var.region
  zone    = var.zone
}
