terraform {
  required_providers {
    scalr = {
      source = "Scalr/scalr"
      version = "1.8.0"
    }
  }
}

data "scalr_current_account" "account" {}

resource "scalr_environment" "dev" {
  name                            = "Development"
  account_id                      = data.scalr_current_account.account.id
  cost_estimation_enabled         = true
  policy_groups                   = []
  default_provider_configurations = []
}

resource "scalr_agent_pool" "dev" {
  name           = "agent-dev"
  account_id     = data.scalr_current_account.account.id
  environment_id = scalr_environment.dev.id
}

resource "scalr_agent_pool_token" "dev" {
  agent_pool_id = scalr_agent_pool.dev.id
  description   = "Token"
}