terraform {
  required_providers {
    scalr = {
      source  = "Scalr/scalr"
      version = "2.1.0"
    }
  }
}

provider "scalr" {}

module "my_module" {
  source           = "../temp"
  scalr_account_id = var.scalr_account_id

  scalr_variable = {
    aks_min_pool_size = {
      hcl          = false
      value        = "1"
      sensitive    = false
      description  = null
      workspace_id = var.scalr_workspace_id
    }
  }
}

variable "scalr_account_id" {

}

variable "scalr_workspace_id" {

}