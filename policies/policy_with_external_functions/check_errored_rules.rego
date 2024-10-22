package terraform

import data.errored_rules

deny[reason] {
    errored_rules.compile_error

    reason := "compile_error function returned true for some reason instead of error"
}

deny[reason] {
    errored_rules.recursive_error(input.tfplan)

    reason := "recursive_error() function returned true for some reason instead of error"
}

deny[reason] {
    errored_rules.type_error

    reason := "type_error function returned true for some reason instead of error"
}