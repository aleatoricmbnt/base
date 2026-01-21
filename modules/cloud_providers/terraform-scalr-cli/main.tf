terraform {
  required_providers {
    scalr = {
      source  = "registry.scalr.io/scalr/scalr"
      version = "2.5.0"
    }
  }
}

provider "scalr" {}


resource "scalr_workspace" "cli-driven" {
  name           = "default_name_ws"
  environment_id = var.env_id
}


variable "env_id" {
  type    = string
  default = "env-svrcnchebt61e30"
}
