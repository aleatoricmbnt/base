package terraform

deny[reason] {
    1 == "1"

    reason := "Some reason that shouldn't be shown due to OPA error"
}