#----------------------------------------------------------------------------
# COMPUTE
#----------------------------------------------------------------------------

variable "instance_name" {
  description = "Compute instances to create"
  default     = {}
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

#----------------------------------------------------------------------------
# NETWORK
#----------------------------------------------------------------------------
variable "firewall_allow_tcp_ports" {
  description = "List of allowed ports to be reached from the internet. TAKE CARE!"
  default     = []
}

variable "vpc_name" {
  description = "Name of the VPC"
}


#----------------------------------------------------------------------------
# OTHER
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