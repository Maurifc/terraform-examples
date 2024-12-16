#----------------------------------------------------------------------------
# LOCALS
#----------------------------------------------------------------------------
locals {
    bucket_name_suffix = random_id.bucket_random_prefix.hex
}


#----------------------------------------------------------------------------
# SOURCE CODE .ZIP
#----------------------------------------------------------------------------
data "archive_file" "source_zip" {
  type        = "zip"
  source_dir = "${path.module}/source-code/"
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
# Cloud Function
#----------------------------------------------------------------------------
resource "google_cloudfunctions_function" "function" {
  name        = "function-test"
  description = "Demo function"
  runtime     = "python312"

  available_memory_mb   = 128
  source_archive_bucket = google_storage_bucket.functions_source_code_bucket.name
  source_archive_object = google_storage_bucket_object.source_code.name
  trigger_http          = true
  entry_point           = "main"
}


#----------------------------------------------------------------------------
# RANDOM
#----------------------------------------------------------------------------
resource "random_id" "bucket_random_prefix" {
  byte_length = 8
}