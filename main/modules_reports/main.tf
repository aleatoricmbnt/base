terraform {
  required_providers {
    scalr = {
      source = "Scalr/scalr"
    }
  }
}

provider "scalr" {
    hostname = var.hostname
    token = var.token
}

resource "scalr_environment" "test" {
  count = 50
  name                            = "namespace_${count.index}"
  account_id                      = "acc-ttf6li416m4sbi0"
  cost_estimation_enabled         = false
}

resource "scalr_module" "example" {
  count = 50
  account_id      = "acc-ttf6li416m4sbi0"
  environment_id  = scalr_environment.test[count.index].id
  vcs_provider_id = "vcs-u7btqoq3uofo540"
  vcs_repo {
    identifier = "aleatoricmbnt/base"
    path       = "modules/terraform-null-module"
    tag_prefix = "null/"
  }
}

data "scalr_module_version" "example" {
  count   = 50
  source  = "${scalr_environment.test[count.index].id}/module/null"
  version = "0.0.2"
}

resource "scalr_workspace" "example" {
  count = 50
  environment_id = scalr_environment.test[count.index].id

  name              = "ws_${count.index}"
  module_version_id = data.scalr_module_version.example[count.index].id
}

variable "hostname" {
  default = "acc.scalr.io"
  sensitive = false
}

variable "token" {
  default = "eyXXXX"
  sensitive = true
}