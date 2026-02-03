# Local Modules with Non-Terraform Files Test

This test verifies that all files (including non-Terraform files) persist between plan and apply operations when using local modules.

## Structure

```
local_modules_with_trash/
├── main.tf                          # Root module referencing local modules
├── modules/
│   ├── module_with_scripts/         # Module with shell and Python scripts
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── terraform.tfvars
│   │   ├── scripts/
│   │   │   ├── setup.sh             # Bash script (non-TF)
│   │   │   └── cleanup.py           # Python script (non-TF)
│   │   └── data/
│   │       └── config.txt           # Text data file (non-TF)
│   │
│   ├── module_with_data/            # Module with various data files
│   │   ├── main.tf
│   │   ├── dev.auto.tfvars
│   │   ├── README.md                # Documentation (non-TF)
│   │   └── data/
│   │       ├── config.json          # JSON data (non-TF)
│   │       ├── users.csv            # CSV data (non-TF)
│   │       └── metadata.yaml        # YAML data (non-TF)
│   │
│   └── module_mixed_files/          # Module with mixed file types
│       ├── main.tf
│       ├── outputs.tf
│       ├── config.hcl               # HCL config (non-TF)
│       ├── template.tpl             # Template file (non-TF)
│       ├── init.sh                  # Shell script (non-TF)
│       ├── notes.txt                # Text notes (non-TF)
│       └── test.tfvars
```

## Resources Used

- `terraform_data` - For stateful operations
- `random_string` - For generating random values
- `random_integer` - For generating random numbers
- `null_resource` - For triggering on file changes

## Test Purpose

Verify that all non-Terraform files (.sh, .py, .txt, .json, .csv, .yaml, .md, .hcl, .tpl) within local modules:
1. Are present during the plan phase
2. Persist through to the apply phase
3. Are not deleted or modified between operations
4. Can be referenced by Terraform resources (e.g., via `file()`, `filemd5()`)

## Expected Behavior

- All modules should initialize successfully
- Non-Terraform files should be accessible during plan
- File references (filemd5, file) should work correctly
- All files should remain intact between plan and apply
