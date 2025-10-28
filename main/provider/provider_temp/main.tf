terraform {
  required_providers {
    scalr = {
      source  = "registry.main.scalr.dev/scalr/scalr"
      version= "1.0.0-rc-master"
      # version = "3.7.0"
    }
  }
}

data "scalr_current_account" "aleatoric" {}

data "scalr_current_run" "this" {}

# resource "scalr_role" "random_list_of_permissions" {
#   name        = "random_list_of_permissions"
#   description = "Random list of permissions"

#   account_id  = data.scalr_current_account.aleatoric.id

#   permissions = [
#     "*:read",
#     "environments:*"
#     # "*:read"
#   ]
# }

resource "scalr_webhook" "example1" {
  name         = "my-webhook-1"
  enabled      = true
  url          = "https://my-endpoint.url"
  secret_key   = "my-secret-key3427895439fGHSDH_"
  timeout      = 15
  max_attempts = 3
  events       = ["run:errored", "run:completed", "run:errored", "run:completed"]
  environments = ["env-v0oqnl6qi3ue7c0lg", "env-v0ohtvdn9bjltg2fb", "env-v0oqnl6qi3ue7c0lg"]
  header {
    name  = "header1"
    value = "value1"
  }
  header {
    name  = "header2"
    value = "value2"
  }
}

resource "scalr_agent_pool" "default" {
  name       = "some-pool"
  environments    = ["env-v0oqnl6qi3ue7c0lg", "env-v0ohtvdn9bjltg2fb", "env-v0oqnl6qi3ue7c0lg"]
}

resource "scalr_tag" "example1" {
  name       = "tag-name1"
}

resource "scalr_tag" "example2" {
  name       = "tag-name2"
}


resource "scalr_environment" "test" {
  name                            = "test-env"
  default_provider_configurations = ["pcfg-v0ob60mb1khb198qg", "pcfg-v0okd9va67cccbv11"]
  federated_environments          = ["env-v0ohtvdn9bjltg2fb", "env-v0oqnl6qi3ue7c0lg"]
  tag_ids                         = [scalr_tag.example2.id, scalr_tag.example1.id]
}

resource "scalr_service_account" "example" {
  name        = "sa-name-sdkfjlsd"
  description = "Lorem ipsum"
  status      = "Active"
  owners = ["team-v0ns6n9lp1e87g7ri","team-v0ns6n9ku96ru35uj", "team-v0ns6n9lp1e87g7ri"]
}

resource "scalr_slack_integration" "test" {
  name         = "my-channel"
  events       = ["run_approval_required", "run_success", "run_errored"]
  run_mode     = "apply"
  channel_id   = "C04US2BVBLP" 
  environments = ["env-v0ohtvdn9bjltg2fb"] #"env-v0oqnl6qi3ue7c0lg"
  workspaces   = ["ws-v0p0pv1c5hg0or2hv", "ws-v0ooq3det41vc1oap"]
}