package terraform

import data.simple_rules

deny[reason] {
    simple_rules.is_false(input.tfrun.workspace.auto_apply)

    reason := "Auto-apply option is false"
}
