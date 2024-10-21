package terraform

deny[reason] {
    some_undefined_rule(input.tfplan)

    reason := "Some reason that shouldn't be shown due to OPA error"
}