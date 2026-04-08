variable "algorithm" {
  type        = string
  description = "tls_private_key algorithm."
  default     = "RSA"
}

variable "rsa_bits" {
  type        = number
  description = "RSA key size when algorithm is RSA."
  default     = 2048
}
