#----------------------------------------------------------------------------
# CLOUD SQL
#----------------------------------------------------------------------------

variable "instance_name" {
  description = "Name of the instance"
}

variable "database_version" {
  description = "Database version"
}

variable "tier" {
  description = "Tier (size) of the instance"
}

variable "enable_private_network" {
  description = "Whether to enable private network or not"
  default     = false
}

variable "enable_ha" {
  description = "Enable high availability for the instance"
  default     = false
}

variable "enforce_complex_password" {
  description = "Whether to enforce the complexity of the password"
  default     = false
}

#----------------------------------------------------------------------------
# NETWORK
#----------------------------------------------------------------------------

variable "authorized_networks" {
  description = "Networkws that are allowed to reach the instances"
}

variable "vpc" {
  description = "VPC where the Cloud SQL Instances will be attached (Only if private network is enabled)"
}


#----------------------------------------------------------------------------
# OTHER
#----------------------------------------------------------------------------

variable "project" {
  description = "Default ProjectID"
}

variable "region" {
  description = "Default region"
}

variable "zone" {
  description = "Default zone"
}