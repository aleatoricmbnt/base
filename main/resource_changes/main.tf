terraform {
    required_providers {
        scalr = {
            source = "registry.scalr.io/scalr/scalr"
        }
    }
}

resource "scalr_workspace" "cli-driven" {
    count = 15
    name            = "new_${count.index}"
    environment_id  = "env-v0o2dm5uk9c5qum71"
}

# resource "null_resource" "name" {
#   count = 200
# }

resource "scalr_environment" "test" {
    count = 9
    name       = "renamed-env_${count.index}"
}

resource "null_resource" "name" {
  
}