# Variable Precedence Test Source

Test configuration to run in the target workspace to verify variable precedence.

## Files

- `main.tf` - Test configuration with null_resource
- `test.tfvars` - Custom var-file (highest precedence)
- `test.auto.tfvars` - Auto-loaded variables
- `terraform.tfvars.json` - Standard JSON variables

## Expected Result

The `test_var` should resolve to `"var-file-value"` from `test.tfvars` (highest precedence).

## Usage

Deploy this configuration to the workspace created by the test infrastructure. 