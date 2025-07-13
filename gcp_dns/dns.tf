#----------------------------------------------------------------------------
# LOCALS
#----------------------------------------------------------------------------

locals {
  dns_record_sets = {
    for entry in flatten([
      for zone, records in var.dns_zones : [
        for r in records.record_sets : {
          key     = "${zone}-${r.name}-${r.type}" # Unique key
          id      = zone
          name    = r.name
          type    = r.type
          rrdatas = r.rrdatas
        }
      ]
    ]) : entry.key => entry
  }
}

#----------------------------------------------------------------------------
# ZONE
#----------------------------------------------------------------------------

resource "google_dns_managed_zone" "this" {
  for_each = var.dns_zones

  name        = each.key
  dns_name    = each.value.dns_name
  description = "DNS zone - ${each.value.dns_name}"

  dynamic "dnssec_config" {
    for_each = each.value.enable_dnssec ? [1] : []

    content {
      kind          = "dns#managedZoneDnsSecConfig"
      non_existence = "nsec3"
      state         = "on"

      default_key_specs {
        algorithm  = "rsasha256"
        key_length = 2048
        key_type   = "keySigning"
        kind       = "dns#dnsKeySpec"
      }
      default_key_specs {
        algorithm  = "rsasha256"
        key_length = 1024
        key_type   = "zoneSigning"
        kind       = "dns#dnsKeySpec"
      }
    }
  }

}

resource "google_dns_record_set" "this" {
  for_each = local.dns_record_sets

  // use only dns_name if '@' is provided
  name         = each.value.name == "@" ? google_dns_managed_zone.this[each.value.id].dns_name : "${each.value.name}.${google_dns_managed_zone.this[each.value.id].dns_name}"
  managed_zone = google_dns_managed_zone.this[each.value.id].name
  type         = each.value.type
  ttl          = 300
  rrdatas      = each.value.rrdatas
}