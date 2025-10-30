terraform {
  required_providers {
    scalr = {
      source  = "registry.main.scalr.dev/scalr/scalr"
      version= "1.0.0-rc-master"
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
    "*:read",
    "environments:*"
  ]
}

resource "scalr_workspace" "example" {
  name              = "check_plan_diff"
  environment_id    = data.scalr_current_run.this.environment_id
  vcs_repo {
    identifier = "aleatoricmbnt/base"
    branch     = "master"
    trigger_prefixes = ["stage", "prod", "main/local_wait"]
  }
  vcs_provider_id = "vcs-u7btqoq3uofo540"
  working_directory = "main/local_wait"
}

resource "scalr_account_allowed_ips" "default" {
  allowed_ips = ["127.0.0.1", "192.168.0.0/24", "77.83.191.29", "34.56.55.49"]
}