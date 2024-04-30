resource "null_resource" "string_trigger" {
  triggers = {
    sens = var.string
  }
}

variable "string" {
  
}

resource "null_resource" "char5" {
  
}

resource "null_resource" "some-long-string" {
  
}

output "token-sens" {
  value = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzY2Fscjp1c2VyIiwianRpIjoiYXQtdjBvYmt0YmNrbnRpNTZhbjgifQ.FnV6jPZOXcegLuNvePMT6JnJTegXpgJCB2Cc7j60sGA"
}

