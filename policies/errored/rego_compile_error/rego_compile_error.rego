package terraform

deny[reason] {
    var_x := input.tfplan
    input.tfplan == null

    reason := "Some reason that shouldn't be shown due to OPA error"
}