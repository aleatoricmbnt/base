module "modules_terraform-empty-readme" {
	source  = "aleatoric.main.scalr.dev/my_very_first_namespace/modules/test//modules/terraform-empty-readme"
	version = "1.0.2"

	# Set 1 required variable below.

	# Number of resources to be created
 	quantity = 1
}