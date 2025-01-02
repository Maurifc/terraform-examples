#----------------------------------------------------------------------------
# SERVICE ACCOUNTS
#----------------------------------------------------------------------------

resource "google_service_account" "cloud_function_sa" {
  account_id = "${var.function_name}-sa"
  project    = var.project
  display_name = "Service Account for ${var.function_name} function"
}
