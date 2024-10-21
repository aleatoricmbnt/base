package terraform

deny[reason] {
    greater_than_zero(input.tfplan.variables.check.value)

    reason := "Variable `check` is greater than 0"
}

deny[reason] {
    is_false(input.tfrun.workspace.auto_apply)

    reason := "Auto-apply option is false"
}

deny[reason] {
    always_true()

    reason := "Always denied"
}