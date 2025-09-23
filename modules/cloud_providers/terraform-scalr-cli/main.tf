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
  name           = "created_${random_pet.name.id}"
  environment_id = var.env_id
}

resource "random_pet" "name" {
  keepers = {
    time = timestamp()
  }
}

variable "env_id" {
  type    = string
  default = "env-svrcnchebt61e30"
}
