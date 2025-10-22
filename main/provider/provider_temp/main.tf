terraform {
  required_providers {
    scalr = {
      source  = "registry.scalr.dev/scalr/scalr"
      version = "3.7.0"
    }
  }
}

data "scalr_current_account" "aleatoric" {}

data "scalr_current_run" "this" {}

resource "scalr_role" "random_list_of_permissions" {
  name        = "random_list_of_permissions_${formatdate("DDMMYYYY", timestamp())}"
  description = "Random list of permissions"

  account_id  = data.scalr_current_account.aleatoric.id

  permissions = [
    "environments:*",
    "*:read"
  ]
}