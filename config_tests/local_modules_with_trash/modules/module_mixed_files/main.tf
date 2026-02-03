variable "instance_count" {
  type    = number
  default = 1
}

resource "random_integer" "priority" {
  min = 1
  max = 100
}

resource "terraform_data" "instances" {
  count = var.instance_count
  
  input = {
    index    = count.index
    priority = random_integer.priority.result
    config   = file("${path.module}/config.hcl")
  }
}

output "data_id" {
  value = terraform_data.instances[0].id
}
