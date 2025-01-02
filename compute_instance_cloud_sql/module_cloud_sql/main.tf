#----------------------------------------------------------------------------
# INSTANCES
#----------------------------------------------------------------------------

resource "google_sql_database_instance" "this" {
  name             = var.instance_name
  database_version = var.database_version
  region           = var.region

  settings {
    tier = var.tier

    ip_configuration {
      dynamic "authorized_networks" {
        for_each = var.authorized_networks
        iterator = static_ip

        content {
          name  = static_ip.key
          value = static_ip.value
        }
      }

      # VPC Peering (private connectivity)
      private_network                               = var.enable_private_network ? var.vpc.self_link : null
      enable_private_path_for_google_cloud_services = var.enable_private_network
    }

    availability_type = var.enable_ha ? "REGIONAL" : "ZONAL"

    backup_configuration {
      enabled                        = true
      point_in_time_recovery_enabled = true
    }

    maintenance_window {
      day          = 6
      hour         = 2
      update_track = "week5"
    }

    insights_config {
      query_insights_enabled = true
      record_client_address  = true
    }

    password_validation_policy {
      min_length             = 16
      complexity             = "COMPLEXITY_DEFAULT"
      enable_password_policy = var.enforce_complex_password
    }
  }
}

#----------------------------------------------------------------------------
# PEERING CLOUD SQL <-> VPC
#----------------------------------------------------------------------------

resource "google_compute_global_address" "cloudsql_peering_ip" {
  count = var.enable_private_network ? 1 : 0
  name          = "cloudsql-peering-ip"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = var.vpc.id
}

resource "google_service_networking_connection" "private_vpc_connection" {
  count = var.enable_private_network ? 1 : 0

  network                 = var.vpc.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.cloudsql_peering_ip[0].name]
}