# Non-sensitive: one resource for all simple types
resource "terraform_data" "non_sensitive_simple" {
  input = {
    string         = var.string
    string_untyped = var.string_untyped
    number         = var.number
    number_untyped = var.number_untyped
    bool           = var.bool
    bool_untyped   = var.bool_untyped
  }
}

# Non-sensitive: one resource per complex type
resource "terraform_data" "non_sensitive_list" {
  input = var.list
}

resource "terraform_data" "non_sensitive_list_untyped" {
  input = var.list_untyped
}

resource "terraform_data" "non_sensitive_set" {
  input = var.set
}

resource "terraform_data" "non_sensitive_set_untyped" {
  input = var.set_untyped
}

resource "terraform_data" "non_sensitive_map" {
  input = var.map
}

resource "terraform_data" "non_sensitive_map_untyped" {
  input = var.map_untyped
}

resource "terraform_data" "non_sensitive_object" {
  input = var.object
}

resource "terraform_data" "non_sensitive_object_untyped" {
  input = var.object_untyped
}

resource "terraform_data" "non_sensitive_tuple" {
  input = var.tuple
}

resource "terraform_data" "non_sensitive_tuple_untyped" {
  input = var.tuple_untyped
}

# Sensitive: one resource for all sensitive vars
resource "terraform_data" "sensitive" {
  input = {
    string = var.string_sensitive
    number = var.number_sensitive
    bool   = var.bool_sensitive
    list   = var.list_sensitive
    map    = var.map_sensitive
    object = var.object_sensitive
    tuple  = var.tuple_sensitive
    set    = var.set_sensitive
  }
}

variable "string" {
  type        = string
  description = "A variable with an explicitly set string type"
  default     = "hello"
}

variable "string_untyped" {
  description = "A variable without an explicitly set type"
  default     = "world"
}

variable "number" {
  type        = number
  description = "A variable with an explicitly set number type"
  default     = 42
}

variable "number_untyped" {
  description = "A variable without an explicitly set type"
  default     = 3.14
}

variable "bool" {
  type        = bool
  description = "A variable with an explicitly set bool type"
  default     = true
}

variable "bool_untyped" {
  description = "A variable without an explicitly set type"
  default     = false
}

variable "list" {
  type        = list(string)
  description = "A variable with an explicitly set list of strings type"
  default     = ["foo", "bar"]
}

variable "list_untyped" {
  description = "A variable without an explicitly set type"
  default     = [1, "two"]
}

variable "set" {
  type        = set(string)
  description = "A variable with an explicitly set set of strings type"
  default     = ["baz", "qux"]
}

variable "set_untyped" {
  description = "A variable without an explicitly set type"
  default     = [true, false]
}

variable "map" {
  type        = map(string)
  description = "A variable with an explicitly set map of strings type"
  default     = { "key1" = "value1", "key2" = "value2" }
}

variable "map_untyped" {
  description = "A variable without an explicitly set type"
  default     = { "foo" = "bar", "baz" = 42, "qux" = [1, 2, 3] }
}

variable "object" {
  type = object({
    name  = string
    value = number
    list  = list(string)
  })
  description = "A variable with an explicitly set object type"
  default = {
    name  = "my_object"
    value = 3.14
    list  = ["one", "two", "three"]
  }
}

variable "object_untyped" {
  description = "A variable without an explicitly set type"
  default = {
    name  = "another_object"
    value = "42"
    list  = [1, 2, 3]
  }
}

variable "tuple" {
  type = tuple([
    string,
    number,
    list(string)
  ])

  default = [
    "hello",
    42,
    ["one", "two", "three"]
  ]
}

variable "tuple_untyped" {
  default = [
    "world",
    123,
    ["four", "five", "six"]
  ]
}

# Sensitive variants (all types)
variable "string_sensitive" {
  type        = string
  sensitive   = true
  description = "Sensitive string"
  default     = "secret_string"
}

variable "number_sensitive" {
  type        = number
  sensitive   = true
  description = "Sensitive number"
  default     = 9999
}

variable "bool_sensitive" {
  type        = bool
  sensitive   = true
  description = "Sensitive bool"
  default     = true
}

variable "list_sensitive" {
  type        = list(string)
  sensitive   = true
  description = "Sensitive list"
  default     = ["secret_a", "secret_b"]
}

variable "map_sensitive" {
  type        = map(string)
  sensitive   = true
  description = "Sensitive map"
  default     = { "key1" = "secret1", "key2" = "secret2" }
}

variable "object_sensitive" {
  type = object({
    name  = string
    value = number
    list  = list(string)
  })
  sensitive   = true
  description = "Sensitive object"
  default = {
    name  = "secret_object"
    value = 42
    list  = ["s1", "s2"]
  }
}

variable "tuple_sensitive" {
  type      = tuple([string, number])
  sensitive = true
  default   = ["secret_tuple", 123]
}

variable "set_sensitive" {
  type        = set(string)
  sensitive   = true
  description = "Sensitive set"
  default     = ["secret_x", "secret_y"]
}

# Non-sensitive outputs (from terraform_data resources)
output "non_sensitive_simple_output" {
  value = terraform_data.non_sensitive_simple.output
}

output "non_sensitive_list_output" {
  value = terraform_data.non_sensitive_list.output
}

output "non_sensitive_list_untyped_output" {
  value = terraform_data.non_sensitive_list_untyped.output
}

output "non_sensitive_set_output" {
  value = terraform_data.non_sensitive_set.output
}

output "non_sensitive_set_untyped_output" {
  value = terraform_data.non_sensitive_set_untyped.output
}

output "non_sensitive_map_output" {
  value = terraform_data.non_sensitive_map.output
}

output "non_sensitive_map_untyped_output" {
  value = terraform_data.non_sensitive_map_untyped.output
}

output "non_sensitive_object_output" {
  value = terraform_data.non_sensitive_object.output
}

output "non_sensitive_object_untyped_output" {
  value = terraform_data.non_sensitive_object_untyped.output
}

output "non_sensitive_tuple_output" {
  value = terraform_data.non_sensitive_tuple.output
}

output "non_sensitive_tuple_untyped_output" {
  value = terraform_data.non_sensitive_tuple_untyped.output
}

# Sensitive output (from sensitive terraform_data resource)
output "sensitive_output" {
  value     = terraform_data.sensitive.output
  sensitive = true
}
