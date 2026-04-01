resource "terraform_data" "this" {
  input = {
    label = var.input_label
  }
}

output "output" {
  value = terraform_data.this.output
}
