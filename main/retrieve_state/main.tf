resource "null_resource" "time_trigger" {
    triggers = {
        "time" = timestamp()
    }
}

data "terraform_remote_state" "remote_ws" {
    backend = var.backend

    config = {
        hostname = var.hostname
        organization = var.organization
        workspaces = {
            name = var.workspace
        }
    }
}

variable "backend" {
    type = string
    description = "Backend type to use"
    default = "remote"
}

variable "hostname" {
    type = string
    description = "Scalr hostname (i.e. 'acc-name.main.scalr.dev')"
}

variable "organization" {
    type = string
    description = "Environment id"
}

variable "workspace" {
    type = string
    description = "Workspace name"
}

output "remote_outputs_yaml" {
    value = yamlencode(data.terraform_remote_state.remote_ws.outputs)
}
