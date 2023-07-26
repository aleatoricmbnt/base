terraform {
  required_providers {
    scalr = {
      source = "registry.scalr.io/scalr/scalr"
      version= "~> 1.0.0"
    }
  }
}

resource "scalr_provider_configuration" "oidc" {
  name                   = "provider_oidc_${formatdate("DD-MMM-YYYY_hh-mm", timestamp())}"
  export_shell_variables = false
  environments           = ["*"]
  aws {
    credentials_type           = "oidc"
    role_arn                   = "arn:aws:iam::123456789012:role/scalr-oidc-role"
    workload_identity_audience = "aws.scalr-run-workload"
  }
}

data "scalr_current_account" "acc" {
  
}

data "scalr_current_run" "run" {
  
}

output "acc" {
  value = yamlencode(data.scalr_current_account.acc)
}

output "run" {
  value = yamlencode(data.scalr_current_account.run)
}