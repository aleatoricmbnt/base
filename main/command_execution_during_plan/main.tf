resource "null_resource" "name" {
  triggers = {
    time = timestamp()
  }
}

data "external" "example" {
  program = ["bash", "./script.sh"]
  # depends_on = [ null_resource.name ]
}

output "yq_version" {
  value = data.external.example.result
}