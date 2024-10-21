package terraform

import data.simple_rules

deny[reason] {
    simple_rules.greater_than_zero(input.tfplan.variables.check.value)

    reason := "Variable `check` is greater than 0"
}

deny[reason] {
    simple_rules.is_false(input.tfrun.workspace.auto_apply)

    reason := "Auto-apply option is false"
}
