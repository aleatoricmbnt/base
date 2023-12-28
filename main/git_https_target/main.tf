resource "null_resource" "referenced" {
  triggers = {
    trigger = timestamp()
  }
}

module "modules_terraform-null-module" {
	source  = "aleatoric.main.scalr.dev/env-v0ns0m539r05815rg/modules/test//modules/terraform-null-module"
	version = "0.0.7"

	# Set 1 required variable below.

	# Number of resources to be created
 	quantity = 1
}


output "null_resource_id" {
  description = "The `id` of the `null_resource.refrenced` resource in this module."
  value       = null_resource.referenced.id
}
