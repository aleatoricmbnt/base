variable "resource_count" {
  default = 5000
}

resource "terraform_data" "test" {
  count = var.resource_count
  
  input = {
    index = count.index
    timestamp = timestamp()
    random = uuid()
    description = "Test resource ${count.index} for blob writer testing"
  }
  
  # Force recreation on each apply to generate maximum output
  triggers_replace = [
    timestamp()
  ]
}

output "resource_summary" {
  value = {
    total_resources = length(resource.terraform_data.test)
    sample_outputs = slice([
      for r in resource.terraform_data.test : r.input
    ], 0, 10)
  }
}