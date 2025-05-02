terraform {
  required_providers {
    scalr = {
      source  = "registry.scalr.io/scalr/scalr"
      version = "~> 2.0"
    }
  }
}

resource "scalr_provider_configuration" "custom" {
  environments = ["*"]
  name         = "k8s-smth"
  account_id   = var.account_id
  custom {
    provider_name = "kubernetes"
    argument {
      name        = "host"
      value       = "my-host"
      description = "The hostname (in form of URI) of the Kubernetes API."
    }
    argument {
      name  = "username"
      value = "my-username"
    }
    argument {
      name      = "password"
      value     = "my-password"
      sensitive = true
    }
  }
}

resource "scalr_environment" "test" {
  name                    = "Env with whitespaces"
  account_id              = scalr_provider_configuration.custom.account_id
}

data "scalr_environments" "all" {
  account_id = scalr_environment.test.account_id
}

variable "account_id" {
  default = "acc-v0oq24ragovfniaic"
}