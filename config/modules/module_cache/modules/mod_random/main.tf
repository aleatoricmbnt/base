resource "random_string" "this" {
  length  = var.string_length
  special = var.special
}

output "result" {
  value = random_string.this.result
}
