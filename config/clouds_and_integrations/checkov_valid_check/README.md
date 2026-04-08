# Checkov-friendly IAM policy (AWS)

Minimal AWS IAM policy resource intended to **pass Checkov** when policy-as-code scanning is enabled.

## Provider configuration required

- **AWS (`hashicorp/aws`, version pinned in `terraform` block):** Valid credentials and a working AWS API endpoint. Typical options are environment variables (`AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, optional `AWS_SESSION_TOKEN`), a shared credentials file, or an IAM role on the runner.
- **Permissions:** The principal must be allowed to **create and manage IAM customer-managed policies** (for example `iam:CreatePolicy`, `iam:GetPolicy`, `iam:DeletePolicy`, and related actions your workflow uses).
- **Region:** This module sets **`us-east-1`** in `provider "aws"`. Change it if your organization requires another region.

No other providers are declared in this module.
