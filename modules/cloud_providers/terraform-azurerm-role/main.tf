terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.22.0"
    }
  }
}

# -------------------------------------------------------------------------------------------
# ----------------------------------- CONFIGURE PROVIDERS -----------------------------------
# -------------------------------------------------------------------------------------------

provider "azurerm" {
  features {}
}


# -------------------------------------------------------------------------------------------
# ----------------------------------------- AZURERM -----------------------------------------
# -------------------------------------------------------------------------------------------

resource "azurerm_role_definition" "azure_role" {
  name        = "pcfg-test-role"
  scope       = var.scope_subscription-id
  description = "PCFG-TEST This is a custom role created via Terraform"

  permissions {
    actions     = ["*"]
    not_actions = []
  }
}

variable "scope_subscription-id" {
  type = string
  default = "/subscriptions/957ab5e0-6cf3-4167-89ce-119e4977bf12"
}