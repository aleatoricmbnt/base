# Read remote state (tf-var-types outputs)

This workspace uses **`data.terraform_remote_state`** to read another workspace’s state and re-expose its outputs (lists, maps, objects, sensitive values, etc.).

## Remote workspace source

The **publisher** workspace must use the Terraform root **`base/modules/vars/tf-var-types`** (if your VCS root is **`base/`**, that is **`modules/vars/tf-var-types`**). That module defines the outputs this config expects (`non_sensitive_list_output`, `sensitive_output`, and the rest).

Create or point your remote workspace at that directory, apply it so state contains those outputs, then run this workspace with **`remote_state_*`** variables aimed at that backend.

## Variables

| Variable | Role |
|----------|------|
| **`remote_state_hostname`** | Hostname for the remote backend (Terraform Cloud / Enterprise / Scalr). |
| **`remote_state_organization`** | Organization / environment identifier on that host. |
| **`remote_state_workspace_name`** | Name of the workspace whose state is read (typically **`tf-var-types`**). |

Defaults match the previous inline values; override them in the Scalr UI or tfvars for your environment.

## Auth

Use the normal remote backend credentials for your platform (`terraform login`, env vars, or injected CLI config). This README does not duplicate provider-specific auth steps.
