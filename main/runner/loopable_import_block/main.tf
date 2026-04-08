terraform {
  required_providers {
    scalr = {
      source = "scalr/scalr"
    }
  }
}

resource "scalr_environment" "provider" {
  for_each = toset(["uat", "staging", "prod"])
  name = each.key
  account_id = var.acc_id
}

import {
  for_each = {
    "staging" = var.staging_id
    "uat"     = var.uat_id
    "prod"    = var.prod_id
  }
  to = scalr_environment.provider[each.key]
  id = each.value
}

variable "acc_id" {
  
}

variable "uat_id" {
  
}

variable "staging_id" {
  
}

variable "prod_id" {
  
}