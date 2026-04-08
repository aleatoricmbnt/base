# Google provider-defined function

Creates a Google **service account** and demonstrates a **provider-defined function** in an output: `provider::google::name_from_id(...)`.

## Provider configuration required

- **Google (`hashicorp/google`):** A **project** and **credentials** must be available to Terraform.
  - **Project:** Set on `provider "google"` (often supplied by your platform via generated config), or via environment variables such as **`GOOGLE_PROJECT`** / **`GOOGLE_CLOUD_PROJECT`** / **`GCLOUD_PROJECT`**, depending on how you run Terraform.
  - **Credentials:** Service account JSON (**`GOOGLE_CREDENTIALS`** or **`GOOGLE_APPLICATION_CREDENTIALS`**) or **Application Default Credentials** from the environment where Terraform runs.
- **Random (`hashicorp/random`):** The `random_pet` resource needs the Random provider. If your stack does not inject it, add a `required_providers` entry and run `terraform init` so the provider is installed.

## Terraform version

**Provider-defined functions** (`provider::<type>::...`) require a **Terraform CLI version that supports them** (1.8 and newer). Use a compatible Terraform release with a Google provider version that exposes `name_from_id`.
