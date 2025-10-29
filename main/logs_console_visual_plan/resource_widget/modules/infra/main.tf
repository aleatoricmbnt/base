resource "null_resource" "setup" {
  for_each = {
    "network.vpc"     = "vpc-setup"
    "security.groups" = "sg-setup"
    "compute.instances" = "instance-setup"
  }
}

# resource "random_password" "infra_secrets" {
#   count   = 3
#   length  = 16
#   special = true
# }
