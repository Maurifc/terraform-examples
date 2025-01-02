#----------------------------------------------------------------------------
# OUTPUTS
#----------------------------------------------------------------------------

output "source_code_bucket" {
  description = "The source code bucket for the functions"
  value       = module.demo_function.source_code_bucket
}

output "event_bucket" {
  description = "The event bucket for the function"
  value       = module.demo_function.event_bucket
}

output "cloud_function" {
  value = {
    "name"        = module.demo_function.cloud_function.name
    "region"      = module.demo_function.cloud_function.region
    "runtime"     = module.demo_function.cloud_function.runtime
    "entry_point" = module.demo_function.cloud_function.entry_point
  }
}
