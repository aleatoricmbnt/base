package terraform

import data.some_inputs

deny[reason] {
    some_inputs.always_true_new

    reason := "always_true_new() function returned true (hooray!)"
}

deny[reason] {
    some_inputs.always_true_2(input.tfrun.workspace.auto_apply)

    reason := "always_true_2(input.tfrun.workspace.auto_apply) returned true (hooray! x2)"
}
