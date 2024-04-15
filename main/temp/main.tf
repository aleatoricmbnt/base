terraform {
  required_providers {
    scalr = {
      source = "Scalr/scalr"
    }
  }
}


resource "scalr_environment" "test" {
  name                            = "account"
  account_id                      = "acc-v0ob25tvb18lmtqbb"
}

variable "env-name" {
  sensitive = true
  default = "account"
}

resource "null_resource" "name" {
  triggers = {
    sens_value = var.env-name
  }
}

resource "random_password" "password" {
  length           = 16
  special          = false
}

resource "random_password" "password2" {
  length           = 16
  special          = var.my-var
}

variable "my-var" {
  type = bool
  default = false
  sensitive = true
}

