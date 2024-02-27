module "smth_from_scalr" {
  source = var.mod_source
  version = var.mod_version
}

variable "mod_version" {
  default = "0.0.1"
}

variable "mod_source" {
  default = "my-account.scalr.io/account_name/scalr_dynamic_vpc_dns/aws"
}
