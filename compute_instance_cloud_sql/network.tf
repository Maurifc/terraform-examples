#----------------------------------------------------------------------------
# VPCs
#----------------------------------------------------------------------------

resource "google_compute_network" "vpc" {
  name                    = "my-custom-vpc"
  auto_create_subnetworks = true
}