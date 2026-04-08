# Local exec vs Terraform path references

This module prints how **shell working directory** and Terraform **path attributes** line up when `local-exec` runs.

## What it does

- Runs `script.sh`, which writes the shell `pwd` to `script_result.txt`.
- Writes `path.cwd`, `path.module`, and `path.root` into small text files via `local-exec` and reads them back.
- Exposes everything in the `pwd_results` output.

## Why it exists

Useful when you want to see whether the provisioner’s cwd matches `path.cwd`, and how `path.module` and `path.root` differ (nested modules, remote runners, etc.).

## Scalr UI

Start a run from the **Scalr** UI. Terraform root in the repo (from **`base/`**): **`main/local_exec_path_refs/`**. No var file. Inspect the **`pwd_results`** output (and the generated `*.txt` files on the runner if you need them).

## Note

`null_resource` triggers include `timestamp()`, so Terraform will often want to recreate these resources on every run. That keeps the probe easy to re-run; it is not a pattern for normal infrastructure.
