# `for_each` on provider + per-key `provider` meta-argument

Uses the **Null** provider with **multiple provider configurations** created from **`provider "null" { alias = "cfg" for_each = ... }`**, and a **`null_resource`** with matching **`for_each`** and **`provider = null.cfg[each.key]`**.

## What it exercises

- A **dynamic map** of instances drives both the **provider `for_each`** and the **resource `for_each`** so each resource instance is bound to the provider instance with the same key.
- End-to-end **`init` / `plan` / `apply`** when the workspace expands or changes the set of provider instances (keys in `var.instances`).

## Requirements

- **Terraform 1.9 or newer** (provider `for_each` and the associated configuration handling).
- **Null provider** available to Terraform (registry default is fine).

## Var file (Scalr UI)

Runs are expected from the **Scalr** UI. Paths are relative to **`base/`** (repo root).

If you need the sample `instances` map, attach var file **`main/for_each_provider/dev.tfvars`**. Otherwise set variables in the UI as usual.

`instances` is a `map(string)`; values are stored in `null_resource.demo[*].triggers.message` and summarized in the `messages` output.
