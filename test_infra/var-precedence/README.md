# Variable Precedence Test Infrastructure

## Variable Precedence Order

| Precedence | Source | Description | Created By |
|------------|--------|-------------|------------|
| **1** | var-file | Custom tfvars file specified in workspace settings | Workspace configuration |
| **2** | workspace terraform | Variables set at workspace level in Scalr UI | `scalr_variable` resource |
| **3** | *.auto.tfvars | Automatically loaded variable files | File system |
| **4** | terraform.tfvars.json | JSON format variables in working directory | File system |
| **5** | terraform.tfvars | HCL format variables (not processed in Scalr) | File system |
| **6** | workspace shell | TF_VAR_* environment variables at workspace level | `scalr_variable` resource |
| **7** | environment shell | TF_VAR_* environment variables at environment level | `scalr_variable` resource |
| **8** | account shell | TF_VAR_* environment variables at account level | `scalr_variable` resource |

> **Note**: Variables in higher precedence locations override those in lower precedence locations. 