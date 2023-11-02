module "integer" {
	source  = "aleatoric.main.scalr.dev/acc-ttf6li416m4sbi0/integer/random"
	version = "0.0.1"
}

module "role" {
	source  = "aleatoric.main.scalr.dev/env-v0ns0m539r05815rg/role/azurerm"
	version = "0.0.4"
}