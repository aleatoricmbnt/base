resource "null_resource" "no_vars" {
  triggers = {
    "timestamp_2" = timestamp()
  }
}

resource "terraform_data" "new" {
  count = 2
  input = "static"
}