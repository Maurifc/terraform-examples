#----------------------------------------------------------------------------
# INSTANCES
#----------------------------------------------------------------------------

# Create a Cloud SQL DB instance (Postgres 15)
resource "google_sql_database_instance" "this" {
  for_each         = var.cloud_sql_instances
  name             = each.value.name
  database_version = each.value.database_version
  region           = lookup(each.value, "region", null)

  settings {
    tier = each.value.tier

    # TODO: create sample database and users
    # TODO: Authorize traffic from vpc
    ip_configuration {
      dynamic "authorized_networks" {
        for_each = google_compute_address.public_static_ips
        iterator = static_ip

        content {
          name  = static_ip.key
          value = static_ip.value.address
        }
      }

      # VPC Peering (private connectivity)
      private_network                               = each.value.enable_private_network ? google_compute_network.vpc.self_link : null
      enable_private_path_for_google_cloud_services = each.value.enable_private_network
    }

    availability_type = each.value.high_available ? "REGIONAL" : "ZONAL"

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
      enable_password_policy = each.value.enforce_complex_password
    }
  }
}

#----------------------------------------------------------------------------
# PEERING CLOUD SQL <-> VPC
#----------------------------------------------------------------------------

resource "google_compute_global_address" "cloudsql_peering_ip" {
  name          = "cloudsql-peering-ip"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.vpc.id
}

resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = google_compute_network.vpc.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.cloudsql_peering_ip.name]
}