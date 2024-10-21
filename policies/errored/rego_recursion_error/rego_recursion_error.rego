package terraform

deny[reason] {
    var_x := var_x

    reason := "Some reason that shouldn't be shown due to OPA error"
}