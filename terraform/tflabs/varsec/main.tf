resource "random_string" "suffix" {
  length  = 6
  upper   = false
  special = false
}
locals {
  environment_prefix = "${var.application_name}-${var.environment_name}-${random_string.suffix.result}"
  min_nodes          = 5
  max_nodes          = 9
}
resource "random_string" "list" {
  count   = length(var.regions)
  length  = 6
  upper   = false
  special = false
}
resource "random_string" "map" {
  for_each = var.region_instance_count
  length   = 6
  upper    = false
  special  = false
}
resource "random_string" "iftest" {
  count   = var.enabled ? 1 : 0
  length  = 6
  upper   = false
  special = false
}
module "random_module" {
  source  = "hashicorp/module/random"
  version = "1.0.0"
}

module "local" {
  source = "./modules/rando"
  length = 5
}
