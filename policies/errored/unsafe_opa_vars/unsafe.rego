package terraform

deny[reason] {
    var_x := 1
    var_y != 1

    reason := "Some reason that shouldn't be shown due to OPA error"
}