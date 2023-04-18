resource "null_resource" "referenced" {
  triggers = {
    trigger = timestamp()
  }
}

output "null_resource_id" {
  description = "The `id` of the `null_resource.refrenced` resource in this module."
  value       = "${null_resource.referenced.id}"
}