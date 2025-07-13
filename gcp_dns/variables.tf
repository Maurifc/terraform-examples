#----------------------------------------------------------------------------
# DNS
#----------------------------------------------------------------------------
variable "dns_zones" {
  type = map(object({
    dns_name      = string
    enable_dnssec = optional(bool, false)
    record_sets = list(object({
      name    = string
      type    = string
      rrdatas = list(string)
    }))
  }))
  default = {}
}