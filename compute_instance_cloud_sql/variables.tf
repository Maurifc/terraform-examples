variable "compute_instances" {
  description = "Compute instances to create"
  default     = {}
}

variable "cloud_sql_instances" {
  description = "Cloud SQL instances to create"
  default     = {}
}

variable "enable_apis" {
  description = "APIs to enable on the project"
  default = [
    "compute.googleapis.com",          # Compute Engine
    "servicenetworking.googleapis.com" # Network
  ]
}

variable "project" {
  description = "Default ProjectID"
  default = "alucard-419418"
}

variable "region" {
  description = "Default region"
  default = "us-east1"
}

variable "zone" {
  description = "Default zone"
  default = "us-east1-c"
}