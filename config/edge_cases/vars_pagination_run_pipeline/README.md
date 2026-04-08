# Many workspace variables (pagination / run pipeline)

**Prerequisites:** Scalr provider configuration (`pcfg`) must be available so Terraform can read the current run, resolve the workspace, and create workspace variables. Without it, this module cannot run.

## What this checks

It verifies that **a large set of workspace variables** (more than a single API page) is **correctly passed into the run pipeline**. After variables exist on the workspace, a follow-up run must see their values where Terraform expects them (for example in `random_pet` keepers that reference many `var.user_var*` inputs).

## Why two applies

1. **First apply** creates the `scalr_variable` resources (and any dependencies). Those values are not necessarily visible to the same run in the way the next run will see them.
2. **Second apply** runs after the workspace already has the new variables. That run exercises whether **pagination and propagation** into the pipeline work: Terraform should read all variables and the dependent resource should plan/apply using the real values.

Run `terraform apply` twice in order; do not expect the full check to complete after only the first apply.

## What the config does (short)

- Uses `scalr_current_run` and `scalr_workspace` to target the **current** workspace.
- Creates many Terraform-category workspace variables (`user_var*`) via `count`.
- Declares matching root module `variable` blocks (defaults are placeholders until workspace vars are set).
- A `random_pet` resource depends on the variables being created and uses many of those vars in `keepers` so changes to workspace values force replacement if something is wrong.
