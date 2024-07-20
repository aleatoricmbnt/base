package terraform
import input.tfrun as tfrun
import future.keywords.in

bool_value = true

deny[reason] {
    check := bool_value
    check == true
    reason := "This policy is always soft-failed"
}