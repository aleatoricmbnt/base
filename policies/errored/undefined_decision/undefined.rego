package terraform

deny[reason] {
    number == true

    reason := "Some reason that shouldn't be shown due to OPA error"
}