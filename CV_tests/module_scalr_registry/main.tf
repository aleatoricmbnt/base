module "smth_from_scalr" {
  source = var.source
  version = var.version
}

variable "version" {
  default = "0.0.1"
}

variable "source" {
  default = "my-account.scalr.io/account_name/scalr_dynamic_vpc_dns/aws"
}
