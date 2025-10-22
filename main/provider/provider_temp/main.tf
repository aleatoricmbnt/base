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

resource "scalr_iam_team" "dev" {
  name        = "dev"
  description = "Developers"

  users = ["user-ucbke9vugfu1sko", "user-v0o5ai48me2l6658l"]
}