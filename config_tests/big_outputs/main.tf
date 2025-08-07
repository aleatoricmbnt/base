resource "terraform_data" "recreate_trigger" {
  triggers_replace = {
    timestamp = timestamp()
  }
}
