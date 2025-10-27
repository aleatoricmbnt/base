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
