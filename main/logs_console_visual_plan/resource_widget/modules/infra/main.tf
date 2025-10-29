variable "project_name" {
  description = "Name of the project"
  type        = string
}

# Infrastructure resources
resource "terraform_data" "project_config" {
  input = var.project_name
}

resource "null_resource" "setup" {
  for_each = {
    "network.vpc"     = "vpc-setup"
    "security.groups" = "sg-setup"
    "compute.instances" = "instance-setup"
  }
  
  provisioner "local-exec" {
    command = "echo 'Setting up ${each.key} for ${var.project_name}'"
  }
}

resource "random_password" "infra_secrets" {
  count   = 3
  length  = 16
  special = true
}
