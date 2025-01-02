module "compute_engine_instance" {
  source = "./module_compute_engine"

  instance_name  = var.instance_name
  machine_type   = var.machine_type
  disk_size_gb   = var.disk_size_gb
  network_tags   = var.network_tags
  startup_script = var.startup_script

  vpc_name = var.vpc_name

  project = var.project
  region  = var.region
  zone    = var.zone
}