package terraform

import data.some_inputs

deny[reason] {
    some_inputs.always_false

    reason := "always_false function returned true for some reason"
}

deny[reason] {
    some_inputs.always_true_2(input.tfrun.workspace.auto_apply)

    reason := "always_true_2(input.tfrun.workspace.auto_apply) returned true (hooray! x2)"
}
