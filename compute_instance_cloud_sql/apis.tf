#----------------------------------------------------------------------------
# Google Cloud APIS
#----------------------------------------------------------------------------

# Enable Google Cloud APIs
resource "google_project_service" "apis" {
  for_each = toset(var.enable_apis)
  service  = each.key
  project = var.project
}