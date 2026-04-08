resource "terraform_data" "this" {
  count = 144
  provisioner "local-exec" {
    command = "sleep 5" # if resources are created one by one - the plan itself will take 12 mins
  }
}