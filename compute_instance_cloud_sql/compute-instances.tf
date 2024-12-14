#----------------------------------------------------------------------------
# LOCALS
#----------------------------------------------------------------------------
locals {
  compute_instances_name = toset(
    [
      for instance in var.compute_instances : instance.instance_name
    ]
  )
}


#----------------------------------------------------------------------------
# COMPUTE INSTANCES
#----------------------------------------------------------------------------
resource "google_compute_instance" "this" {
  for_each     = var.compute_instances
  name         = each.value.instance_name
  machine_type = each.value.machine_type
  zone         = lookup(each.value, "zone", null) # Use default zone if not set

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts" # Tip: use the command 'gcloud compute images list' to obtain a list of available images
      size  = each.value.disk_size_gb
    }
  }

  tags = each.value.network_tags

  network_interface {
    network = google_compute_network.vpc.self_link
    subnetwork = google_compute_network.vpc.name

    access_config {
      nat_ip = google_compute_address.public_static_ips[each.value.instance_name].address
    }
  }

  metadata_startup_script = each.value.startup_script

  service_account {
    email  = google_service_account.instance_service_accounts[each.value.instance_name].email
    scopes = ["cloud-platform"]
  }
}

#----------------------------------------------------------------------------
# INSTANCES SERVICE ACCOUNTS
#----------------------------------------------------------------------------

resource "google_service_account" "instance_service_accounts" {
  for_each = local.compute_instances_name

  account_id   = "${each.key}-sa"
  display_name = "Service Account for ${each.key} compute instance"
}

#----------------------------------------------------------------------------
# PUBLIC STATIC IPS
#----------------------------------------------------------------------------
resource "google_compute_address" "public_static_ips" {
  for_each = local.compute_instances_name
  name     = each.key
}