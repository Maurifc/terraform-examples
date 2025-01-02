module "demo_function" {
  source               = "./cloud_function_module"
  function_name        = "demo-function"
  function_description = "Demo function"
  source_dir           = "${path.module}/source-code/"

  project = var.project
  region  = var.region
  zone    = var.zone
}