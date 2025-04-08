terraform {
  required_providers {
    scalr = {
      source  = "registry.scalr.io/scalr/scalr"
    }
  }
}

module "scalr_prod_module_2_5_0" {
  source = "../../modules/cloud_providers/terraform-scalr-cli"
}