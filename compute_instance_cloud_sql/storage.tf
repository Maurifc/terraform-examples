locals {
  bucket_name_suffix = random_id.bucket_random_prefix.hex
}

resource "google_storage_bucket" "tf_backend_bucket" {
  name     = "tf-backend-${local.bucket_name_suffix}"
  location = "US"

  force_destroy               = false
  public_access_prevention    = "enforced"
  uniform_bucket_level_access = true
  soft_delete_policy {
    retention_duration_seconds = 0
  }
  versioning {
    enabled = true
  }
}

#----------------------------------------------------------------------------
# RANDOM
#----------------------------------------------------------------------------
resource "random_id" "bucket_random_prefix" {
  byte_length = 8
}