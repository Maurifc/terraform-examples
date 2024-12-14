terraform {
  required_version = "1.10.2"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.13.0"
    }
  }

  # GCS Bucket as backend
  backend "gcs" {
    bucket = "tf-backend-f234e66ff568087c"
    prefix = "my-project/state/"
  }
}

provider "google" {
  project = var.project
  region  = var.region
  zone    = var.zone
}
