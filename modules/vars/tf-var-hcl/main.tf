# map (object)

variable "map_object" {
  type = map(object({
    cidr     = string
    zone     = string
    tags     = map(string)
    cidr_app = string
    gw_app   = string
    cidr_db  = string
    gw_db    = string
  }))
}

resource "null_resource" "map_object" {
  provisioner "local-exec" {
    command = "echo ${var.map_object.AIMS.cidr}"
  }
  triggers = {
    time = timestamp()
  }
}

# number, bool and string

variable "number" {
  type = number
}

variable "bool" {
  type = bool
}

variable "string" {
  type = string
}

resource "random_password" "number_bool_string" {
  length           = var.number
  special          = var.bool
  override_special = var.string
}

# sensitive number, bool and string

variable "number_sensitive" {
  type = number
  sensitive = true
}

variable "bool_sensitive" {
  type = bool
  sensitive = true
}

variable "string_sensitive" {
  type = string
}

resource "random_password" "number_bool_string_sensitive" {
  length           = var.number_sensitive
  special          = var.bool_sensitive
  override_special = var.string_sensitive
}

# list(object)

variable "list" {
  type = list(object({
    password-length = number
    password-special = bool
    password-override-special = string
  }))
}

resource "random_password" "list_object_per_attribute_usage" {
  length           = var.list[0].password-length
  special          = var.list[0].password-special
  override_special = var.list[0].password-override-special
}

# sensitive list(string)

variable "list_sensitive" {
  type = list(string)
  sensitive = true
}

resource "random_shuffle" "name" {
  input = var.list_sensitive
}

# untyped list, sensitive nested object, referencing the variable as a whole

variable "list_untyped" {}

variable "nested_object_sensitive" {
  type = object({
    id = string
    labels = map(string)
    size = number
  })
  sensitive = true
}

resource "terraform_data" "list_untyped_nested_object_sensitive" {
  input = var.list_untyped
  triggers_replace  = var.nested_object_sensitive
}

# object with optional attribute and attribute with a default value 


variable "object_with_optional_attribute" {
  type = object({
    a = string                
    b = optional(string)      
    c = optional(number, 127)
  })
}

output "optional-attributes-out" {
  value = var.object_with_optional_attribute
}

# nullable variable as a trigger

variable "nullable" {
  type     = string
  nullable = true
  default  = null
}

resource "null_resource" "nullable_trigger" {
  triggers = {
    example_variable = var.nullable != null ? var.nullable : "default_value"
  }
}

output "nullable_output" {
  value = var.nullable
}

# variable with type any

variable "type_any" {
  type = any
}

output "type_any_output" {
  value = jsonencode(var.type_any)
}

# map with non-literal key

variable "key-name" {
  type        = string
}

locals {
  map_with_non_literal_key = {
    stable = "constant"
    (var.key-name) = "unstable"
  }
}

resource "null_resource" "triggered-by-non-literal-map" {
  triggers = local.map_with_non_literal_key
}

output "map_with_non_literal_key_output" {
  value = local.map_with_non_literal_key
}