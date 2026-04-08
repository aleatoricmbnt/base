resource "time_rotating" "this" {
  rotation_days = var.rotation_days
}

output "rotation_id" {
  value = time_rotating.this.id
}
