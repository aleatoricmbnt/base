resource "null_resource" "no_vars" {
  triggers = {
    "timestamp_2" = timestamp()
  }
  provisioner "local-exec" {
    command = "python3 -c \"s = ' ' * (2**30)\""
  }
}
