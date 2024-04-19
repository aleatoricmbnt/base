terraform {
  required_providers {
    scalr = {
      source = "Scalr/scalr"
    }
  }
}


resource "scalr_environment" "test" {
  name                            = "something"
  account_id                      = "acc-v0ob72lqf5c990dek"
}

resource "random_password" "password" {
  length           = 16
  special          = false
}
