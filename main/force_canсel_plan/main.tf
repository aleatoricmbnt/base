data "external" "example" {
  program = ["bash", "./script.sh"]
}

resource "null_resource" "name" {
  triggers = {
    time = timestamp()
  }
}