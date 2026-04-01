resource "null_resource" "this" {
  triggers = {
    seed = var.trigger_seed
  }
}

output "id" {
  value = null_resource.this.id
}
