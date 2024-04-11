# resource "random_password" "password" {
#   length           = 16
#   special          = var.special_s
#   lower = var.lower_s
# }

# variable "special_s" {
#   type = bool
#   default = false
# }

# variable "lower_s" {
#   default = false
# }

terraform {
  required_providers {
    scalr = {
      source = "Scalr/scalr"
    }
  }
}


resource "scalr_environment" "test" {
  name                            = "test-env"
  account_id                      = "acc-v0oarthieg22m0a5e"
}