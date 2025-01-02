#----------------------------------------------------------------------------
# CLOUD FUNCTION
#----------------------------------------------------------------------------
variable "function_name" {
  description = "A unique name for the function"
}

variable "function_description" {
  description = "A description for the function"
}

variable "source_dir" {
  description = "Directory containing the function's source code"
}

#----------------------------------------------------------------------------
# GENERAL
#----------------------------------------------------------------------------

variable "project" {
  description = "GCP ProjectID"
}

variable "region" {
  description = "GCP Region"
}

variable "zone" {
  description = "GCP Zone"
}