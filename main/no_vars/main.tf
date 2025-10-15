resource "null_resource" "no_vars" {
  triggers = {
    "timestamp_2" = timestamp()
  }
}

resource "terraform_data" "new" {
  input = "static"
}

resource "terraform_data" "PR_check" {
  input = "PR_check"
  triggers_replace = timestamp()
}