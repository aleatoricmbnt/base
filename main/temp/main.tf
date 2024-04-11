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

resource "random_pet" "name" {
  
}

resource "scalr_environment" "test" {
  name                            = random_pet.name.id
  account_id                      = "acc-v0oarthieg22m0a5e"
}