#----------------------------------------------------------------------------
# DNS
#----------------------------------------------------------------------------
dns_zones = {
  "example-domain-com" = {
    dns_name = "example.domain.com."
    record_sets = [
      {
        name    = "@"
        type    = "A"
        rrdatas = ["192.168.0.1"]
      },
      {
        name    = "app"
        type    = "A"
        rrdatas = ["192.168.0.1"]
      },
      {
        name    = "site"
        type    = "CNAME"
        rrdatas = ["app.example.domain.com."]
      },
    ]
  },
}
