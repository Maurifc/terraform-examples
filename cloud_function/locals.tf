#----------------------------------------------------------------------------
# LOCALS
#----------------------------------------------------------------------------
locals {
    bucket_name_suffix = random_id.bucket_random_prefix.hex
}