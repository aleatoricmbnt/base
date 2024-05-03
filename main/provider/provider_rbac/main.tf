terraform {
  required_providers {
    scalr = {
      source = "Scalr/scalr"
    }
  }
}


variable "acc_id" {
  
}

variable "user_id" {
  
}

variable "admin_role_id" {

}

variable "read_role_id" {
  
}

variable "number_of_entities" {
  default = 50
}

resource "scalr_environment" "read_env" {
  count = var.number_of_entities
  name       = "read_only_role_all_permissions_${count.index}"
  account_id = var.acc_id
}

resource "scalr_environment" "admin_env" {
  count = var.number_of_entities
  name       = "admin_role_all_permissions_${count.index}"
  account_id = var.acc_id
}

resource "scalr_environment" "custom_env" {
  count = var.number_of_entities
  name       = "custom_role_no_permissions_${count.index}"
  account_id = var.acc_id
}



resource "scalr_workspace" "admin_ws" {
  count = var.number_of_entities
  name              = "admin_role_ws_${count.index}"
  environment_id    = scalr_environment.read_env[count.index].id
}

resource "scalr_workspace" "custom_ws" {
  count = var.number_of_entities
  name              = "custom_role_inherited_permissions_ws_${count.index}"
  environment_id    = scalr_environment.admin_env[count.index].id
}

resource "scalr_workspace" "admin_ws_custom_env" {
  count = var.number_of_entities
  name              = "admin_role_still_no_access_ws_${count.index}"
  environment_id    = scalr_environment.custom_env[count.index].id
}

resource "scalr_role" "custom" {
  name        = "custom"
  account_id  = var.acc_id
  description = "No access, blank role"

  permissions = [
    "accounts:read"
  ]
}


resource "scalr_access_policy" "read_env_ap" {
  count = var.number_of_entities
  subject {
    type = "user"
    id   = var.user_id
  }
  scope {
    type = "environment"
    id   = scalr_environment.read_env[count.index].id
  }

  role_ids = [
    var.read_role_id
  ]
}


resource "scalr_access_policy" "admin_env_ap" {
  count = var.number_of_entities
  subject {
    type = "user"
    id   = var.user_id
  }
  scope {
    type = "environment"
    id   = scalr_environment.admin_env[count.index].id
  }

  role_ids = [
    var.admin_role_id
  ]
}

resource "scalr_access_policy" "custom_env_ap" {
  count = var.number_of_entities
  subject {
    type = "user"
    id   = var.user_id
  }
  scope {
    type = "environment"
    id   = scalr_environment.custom_env[count.index].id
  }

  role_ids = [
    scalr_role.custom.id
  ]
}

resource "scalr_access_policy" "admin_ws_ap" {
  count = var.number_of_entities
  subject {
    type = "user"
    id   = var.user_id
  }
  scope {
    type = "workspace"
    id   = scalr_workspace.admin_ws[count.index].id
  }

  role_ids = [
    var.admin_role_id
  ]
}

resource "scalr_access_policy" "admin_ws_custom_env_ap" {
  count = var.number_of_entities
  subject {
    type = "user"
    id   = var.user_id
  }
  scope {
    type = "workspace"
    id   = scalr_workspace.admin_ws_custom_env[count.index].id
  }

  role_ids = [
    var.admin_role_id
  ]
}

resource "scalr_access_policy" "custom_ws_ap" {
  count = var.number_of_entities
  subject {
    type = "user"
    id   = var.user_id
  }
  scope {
    type = "workspace"
    id   = scalr_workspace.custom_ws[count.index].id
  }

  role_ids = [
    var.admin_role_id
  ]
}