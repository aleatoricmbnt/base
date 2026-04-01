resource "tls_private_key" "this" {
  algorithm = var.algorithm
  rsa_bits  = var.algorithm == "RSA" ? var.rsa_bits : null
}

output "algorithm" {
  value = tls_private_key.this.algorithm
}
