#----------------------------------------------------------------------------
# COMPUTE
#----------------------------------------------------------------------------
variable "instance_name" {
  description = "Name for the compute instance"
  default     = "demo-instance"
}

variable "machine_type" {
  description = "Machine size for the instance"
}

variable "disk_size_gb" {
  description = "Root disk size in GB"
}

variable "network_tags" {
  description = "Network tag to be added. Optional."
}

variable "startup_script" {
  description = "Bootstrap script"
}

variable "firewall_allow_tcp_ports" {
  description = "List of allowed ports to be reached from the internet. TAKE CARE!"
}

#----------------------------------------------------------------------------
# NETWORK
#----------------------------------------------------------------------------
variable "vpc_name" {
  description = "Name of the VPC"
  default     = "my-custom-vpc"
}


#----------------------------------------------------------------------------
# CLOUD SQL
#----------------------------------------------------------------------------

variable "cloud_sql_instance_name" {
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
# OTHER
#----------------------------------------------------------------------------

variable "enable_apis" {
  description = "APIs to enable on the project"
  default = [
    "compute.googleapis.com",          # Compute Engine
    "servicenetworking.googleapis.com" # Network
  ]
}

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