terraform {
  required_providers {
    scalr = {
      source = "registry.scalr.io/scalr/scalr"
      version= "1.0.0-rc36"
    }
  }
}

# -------------------------------------------------------------------------------------------
# ----------------------------------- CONFIGURE PROVIDERS -----------------------------------
# -------------------------------------------------------------------------------------------

provider "scalr" {}

# -------------------------------------------------------------------------------------------
# ------------------------------------------ SCALR ------------------------------------------
# -------------------------------------------------------------------------------------------

resource "scalr_workspace" "cli-driven" {
  name            = var.ws_name
  environment_id  = var.env_id
}

variable "ws_name" {
  type = string
  default = "pcfg-cli-test"
}

variable "env_id" {
  type = string
  default = "env-svrcnchebt61e30"
}