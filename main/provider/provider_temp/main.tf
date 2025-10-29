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


  # environments = ["env-v0od131sj50cpus77", "env-v0oti3rh5fva3mq1r"]


resource "scalr_tag" "example" {
  name       = "tag-name234"
}

resource "scalr_tag" "example23" {
  name       = "tag-name34"
}

resource "scalr_workspace" "example" {
  name              = "my-workspace-name2345"
  environment_id    = data.scalr_current_run.this.environment_id
  remote_state_consumers = ["ws-v0o1oashjvv3t04a3", "ws-v0o2200vvjlj3qna7", "ws-v0o1oashjvv3t04a3"]
  tag_ids = [scalr_tag.example23.id, scalr_tag.example.id, scalr_tag.example23.id]
  var_files = ["test_source/var-precedence/test.tfvars", "test_source/var-precedence/test2.tfvars"]
  vcs_repo {
    identifier = "aleatoricmbnt/base"
    branch     = "master"
    trigger_prefixes = ["stage", "prod"]
  }
  working_directory = "main/local_wait"
}
