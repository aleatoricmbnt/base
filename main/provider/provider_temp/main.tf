terraform {
  required_providers {
    scalr = {
      source  = "registry.main.scalr.dev/scalr/scalr"
      version = "1.0.0-rc-SCALRCORE-36057"
      # version = "3.7.0"
    }
  }
}

data "scalr_current_account" "aleatoric" {}

data "scalr_current_run" "this" {}

resource "scalr_role" "random_list_of_permissions" {
  name        = "random_list_of_permissions"
  description = "Random list of permissions"

  account_id  = data.scalr_current_account.aleatoric.id

  permissions = [
    # "*:read",
    "environments:*",
    "*:read"
  ]
}