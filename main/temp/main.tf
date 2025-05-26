# locals {
#   config  = yamldecode(file("${path.module}/${var.environment}.yaml"))
#   regions = local.config.regions
# }

# provider "aws" {
#   for_each = local.regions
#   region   = each.key
#   alias    = "by_region"
# }

# resource "aws_s3_bucket" "alfiias_bucket" {
#   for_each = local.regions
#   provider = aws.regions[each.key]
#   bucket = "alfiia-test-s3-${var.environment}-${each.key}" # 
#   tags = {
#     Environment = var.environment
#     Region      = each.key
#   }
# }

terraform {
  required_providers {
    scalr = {
      source = "Scalr/scalr"
    }
  }
}

resource "scalr_workspace" "vcs-driven" {
  name            = replace(var.workdir, "/", "_")
  environment_id  = var.env_id

  auto_apply  = var.auto_apply
  auto_queue_runs = var.auto_queue_runs

  vcs_provider_id = var.vcs_id
  working_directory = var.workdir

  vcs_repo {
    identifier       = var.vcs_identifier
    branch           = "master"
  }
}

variable "env_id" {
  description = "ID  opf the env to create workspace in"
}

variable "vcs_id" {
  description = "ID of the VCS provider to create workspace from"
}

variable "workdir" {
  description = "Working directory of the workspace"
}

variable "vcs_identifier" {
  description = "`org/repo` used as a source for workspace"
}

variable "auto_apply" {
  description = "Boolean value for the Auto-apply setting of the workspace"
}

variable "auto_queue_runs" {
  description = "Vvalue for the Auto-queue runs setting of the workspace"
}