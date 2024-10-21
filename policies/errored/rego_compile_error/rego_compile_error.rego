package terraform

deny[reason] {
    x := 1

    x := 2

    reason := "Some reason that shouldn't be shown due to OPA error"
}