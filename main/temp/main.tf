terraform {
  required_providers {
    scalr = {
      source = "Scalr/scalr"
    }
  }
}


resource "scalr_environment" "test" {
  name                            = "${var.env-name}"
  account_id                      = "acc-v0ob25tvb18lmtqbb"
}

variable "env-name" {
  
}