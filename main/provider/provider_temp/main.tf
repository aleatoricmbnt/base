terraform {
  required_providers {
    scalr = {
      source  = "scalr/scalr"
    }
  }
}

data "scalr_vcs_provider" "vcs_github" {
  name = "test"
}

resource "scalr_workspace" "vcs-driven" {
  name            = "provider_temp_${formatdate("DD-MMM-YYYY_hh-mm", timestamp())}"
  environment_id  = data.scalr_current_run.run.environment_id
  vcs_provider_id = data.scalr_vcs_provider.vcs_github.id

  working_directory = "main/local_wait"

  vcs_repo {
    identifier = "aleatoricmbnt/base"
    branch     = "master"
  }
}

data "scalr_current_account" "acc" {

}

data "scalr_current_run" "run" {

}

output "acc" {
  value = yamlencode(data.scalr_current_account.acc)
}

output "run" {
  value = yamlencode(data.scalr_current_run.run)
}