# Defaults are set here and passed into child modules (each child also has its own defaults).

variable "random_string_length" {
  type        = number
  description = "Length of the random string in the random provider module."
  default     = 6
}

variable "random_special" {
  type        = bool
  description = "Whether to allow special characters in random_string."
  default     = false
}

variable "null_trigger_seed" {
  type        = string
  description = "Trigger value for the null_resource module."
  default     = "module-cache"
}

variable "terraform_data_label" {
  type        = string
  description = "Input label stored in terraform_data."
  default     = "root-default"
}

variable "time_rotation_days" {
  type        = number
  description = "Rotation interval for time_rotating (no cloud resources)."
  default     = 1
}

variable "tls_rsa_bits" {
  type        = number
  description = "RSA key size for tls_private_key."
  default     = 2048
}
