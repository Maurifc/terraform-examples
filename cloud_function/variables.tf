#----------------------------------------------------------------------------
# CLOUD FUNCTION
#----------------------------------------------------------------------------
variable "function_name" {
  description = "A unique name for the function"
  default     = "demo-function"
}


#----------------------------------------------------------------------------
# GENERAL
#----------------------------------------------------------------------------

variable "project" {
  description = "Default ProjectID"
}

variable "region" {
  description = "Default region"
  default     = "us-east1"
}

variable "zone" {
  description = "Default zone"
  default     = "us-east1-c"
}