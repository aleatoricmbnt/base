module "modules_terraform-null-module" {
	source  = "aleatoric.main.scalr.dev/env-v0ns0m539r05815rg/modules/test//modules/terraform-null-module"
	version = "0.0.9"
}

variable "quantity" {
  default = "2"
}