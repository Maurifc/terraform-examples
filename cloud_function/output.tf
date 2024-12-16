output "source_code_bucket" {
  description = "The source code bucket for the functions"
  value = google_storage_bucket.functions_source_code_bucket.name
}

output "cloud_function" {
  value = {
    "name" = google_cloudfunctions_function.function.name
    "region" = google_cloudfunctions_function.function.region
    "runtime" = google_cloudfunctions_function.function.runtime
    "entry_point" = google_cloudfunctions_function.function.entry_point
    "trigger_type" = google_cloudfunctions_function.function.trigger_http ? "HTTP Trigger" : "Event Trigger"
  }
}