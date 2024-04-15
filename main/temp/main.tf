terraform {
  required_providers {
    scalr = {
      source = "Scalr/scalr"
    }
  }
}


resource "scalr_environment" "test" {
  name                            = "provisioner1"
  account_id                      = "acc-v0ob25tvb18lmtqbb"
}

variable "env-name" {
  default = "provisioner1"
}

resource "null_resource" "name" {
  triggers = {
    var_value = var.env-name
  }
}

resource "random_password" "password" {
  length           = 16
  special          = false
}
