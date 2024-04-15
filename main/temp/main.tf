terraform {
  required_providers {
    scalr = {
      source = "Scalr/scalr"
    }
  }
}


resource "scalr_environment" "test" {
  name                            = "5char"
  account_id                      = "acc-v0ob25tvb18lmtqbb"
}

variable "env-name" {
  default = "5char"
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
