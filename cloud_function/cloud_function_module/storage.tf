#----------------------------------------------------------------------------
# BUCKETS
#----------------------------------------------------------------------------

# holds files sent by user and trigger the function on files upload
resource "google_storage_bucket" "function_demo" {
  name                        = "function-demo-bucket-${local.bucket_name_suffix}"
  location                    = "US"
  uniform_bucket_level_access = true
}

#----------------------------------------------------------------------------
# IAM POLICY BINDING
#----------------------------------------------------------------------------
resource "google_storage_bucket_iam_member" "function_bucket_viewer" {
  bucket = google_storage_bucket.function_demo.name
  role   = "roles/storage.objectViewer"
  member = "serviceAccount:${google_service_account.cloud_function_sa.email}"
}
