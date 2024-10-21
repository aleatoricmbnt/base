package terraform

deny[reason] {
  obj := {k: v |
    k := "foo"
    some v in [1, 2]
  }

    reason := "Some reason that shouldn't be shown due to OPA error"
}