terraform {
    required_providers {
        scalr = {
            source = "registry.scalr.io/scalr/scalr"
        }
    }
}

resource "scalr_workspace" "cli-driven" {
    count = 15
    name            = "my-workspace-name_${count.index}"
    environment_id  = "env-v0o2dm5uk9c5qum71"
}

resource "null_resource" "name" {
  count = 200
}

resource "scalr_environment" "test" {
    count = 10
    name       = "test-env_${count.index}"
}