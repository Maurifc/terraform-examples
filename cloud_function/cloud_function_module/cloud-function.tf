#----------------------------------------------------------------------------
# SOURCE CODE .ZIP
#----------------------------------------------------------------------------
data "archive_file" "source_zip" {
  type        = "zip"
  source_dir = var.source_dir
  output_path = "/tmp/function-source-code.zip"

  excludes = [
    ".env",
    "__pycache__",
    "venv",
  ]
}

# create a bucket to hold the functions' source codes
resource "google_storage_bucket" "functions_source_code_bucket" {
  name     = "functions-source-code-bucket-${local.bucket_name_suffix}"
  location = "US"
  uniform_bucket_level_access = true
}

# upload the zip file to Source Code bucket
resource "google_storage_bucket_object" "source_code" {
  name   = "function-source-code.zip"
  bucket = google_storage_bucket.functions_source_code_bucket.name
  source = data.archive_file.source_zip.output_path
}


#----------------------------------------------------------------------------
# CLOUD FUNCTION
#----------------------------------------------------------------------------
resource "google_cloudfunctions_function" "function" {
  name        = var.function_name
  description = var.function_description
  runtime     = "python312"

  available_memory_mb   = 128
  source_archive_bucket = google_storage_bucket.functions_source_code_bucket.name
  source_archive_object = google_storage_bucket_object.source_code.name
  entry_point           = "main"

  # event trigger = GCS Bucket
  event_trigger {
    event_type = "google.storage.object.finalize"
    resource   = google_storage_bucket.function_demo.name
  }

  environment_variables = {
    "source-md5": "${google_storage_bucket_object.source_code.md5hash}"    
  }

  service_account_email = google_service_account.cloud_function_sa.email
}


#----------------------------------------------------------------------------
# RANDOM
#----------------------------------------------------------------------------
resource "random_id" "bucket_random_prefix" {
  byte_length = 8
}