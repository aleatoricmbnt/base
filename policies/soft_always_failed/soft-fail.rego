package terraform

bool_value = true

deny[reason] {
    check := bool_value
    check == true
    reason := "This policy is always soft-failed"
}
