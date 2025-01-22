module "registry" {
	source  = "aleatoric.main.scalr.dev/env-v0ns0m539r05815rg/registry/local"
	version = "0.0.1"
}

module "module" {
	source  = "aleatoric.main.scalr.dev/acc-ttf6li416m4sbi0/module/null"
	version = "1.0.0"

	# Set 1 required variable below.

	# Number of resources to be created
 	quantity = 1
}
