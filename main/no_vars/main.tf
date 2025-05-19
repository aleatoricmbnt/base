resource "null_resource" "no_vars" {
  triggers = {
    "timestamp" = timestamp()
  }
}

resource "terraform_data" "this" {
  input = null_resource.no_vars.id
}
