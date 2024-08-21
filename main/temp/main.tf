module "modules_terraform-null-module" {
	source  = "aleatoric.main.scalr.dev/acc-ttf6li416m4sbi0/modules/test//modules/terraform-null-module"
	version = "0.0.8"

	# Set 1 required variable below.

	# Number of resources to be created
 	quantity = 1
}