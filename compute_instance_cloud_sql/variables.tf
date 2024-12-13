variable "compute_instances" {
  description = "Compute instances to create"
  default     = {}
}

variable "cloud_sql_instances" {
  description = "Cloud SQL instances to create"
  default     = {}
}

variable "enable_apis" {
  default = [
    "compute.googleapis.com",          # Compute Engine
    "servicenetworking.googleapis.com" # Network
  ]
}