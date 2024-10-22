package terraform

import data.no_inputs

deny[reason] {
    no_inputs.always_false

    reason := "always_false function returned true for some reason"
}

deny[reason] {
    no_inputs.always_true

    reason := "always_true returned true (hooray!)"
}
