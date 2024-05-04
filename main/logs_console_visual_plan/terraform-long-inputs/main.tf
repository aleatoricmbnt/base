resource "null_resource" "some" {
  triggers = {
    long = var.long_var
  }
}