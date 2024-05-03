package terraform
import input.tfrun as tfrun

bool_value = true

deny[reason] {
    check := bool_value
    check == true
    reason := "This policy is always hard-failed"
}