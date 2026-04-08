# Private registry provider (`mything`)

Pulls provider **`app.terraform.io/aleatoric/mything`** and applies a trivial `terraform_data` resource.

## Auth for `init` / provider download

Use a **Terraform Cloud / HCP Terraform** API token with access to the **aleatoric** organization (or whatever org hosts the provider).

**Environment variable (typical on CI):**

```text
TF_TOKEN_app_terraform_io=<your token>
```

Hostname dots become underscores after `TF_TOKEN_` (see [CLI config: credentials](https://developer.hashicorp.com/terraform/cli/config/config-file#credentials)).

Alternatively: `terraform login` (writes `~/.terraform.d/credentials.tfrc.json`) or a `credentials "app.terraform.io"` block in the CLI config file.

## Requirements

Terraform **>= 1.5** (see `required_version`).
