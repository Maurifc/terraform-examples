#----------------------------------------------------------------------------
# COMPUTE INSTANCES
#----------------------------------------------------------------------------
resource "google_compute_instance" "this" {
  name         = var.instance_name
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts" # Tip: use the command 'gcloud compute images list' to obtain a list of available images
      size  = var.disk_size_gb
    }
  }

  tags = var.network_tags

  network_interface {
    network = google_compute_network.vpc.self_link
    subnetwork = google_compute_network.vpc.name

    access_config {
      nat_ip = google_compute_address.public_static_ip.address
    }
  }

  metadata_startup_script = var.startup_script

  service_account {
    email  = google_service_account.instance_service_account.email
    scopes = ["cloud-platform"]
  }
}

#----------------------------------------------------------------------------
# INSTANCES SERVICE ACCOUNTS
#----------------------------------------------------------------------------

resource "google_service_account" "instance_service_account" {
  account_id   = "${var.instance_name}-sa"
  display_name = "Service Account for ${var.instance_name} compute instance"
}

#----------------------------------------------------------------------------
# PUBLIC STATIC IPS
#----------------------------------------------------------------------------
resource "google_compute_address" "public_static_ip" {
  name     = var.instance_name
}


#----------------------------------------------------------------------------
# FIREWALL
#----------------------------------------------------------------------------

# Allow SSH access through IAP to instances in the main VPC
resource "google_compute_firewall" "allow_iap_ssh" {
  name    = "allow-iap-ssh"
  network = google_compute_network.vpc.self_link

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges              = ["35.235.240.0/20"]
}

resource "google_compute_firewall" "allow_tcp_ports" {
  name    = "allow-tcp-ports-${var.instance_name}"
  network = google_compute_network.vpc.self_link

  allow {
    protocol = "tcp"
    ports    = var.firewall_allow_tcp_ports
  }

  source_ranges              = ["0.0.0.0/0"]
}
