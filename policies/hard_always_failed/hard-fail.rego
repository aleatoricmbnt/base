package terraform
import input.tfrun as tfrun

bool_value = true

deny[reason] {
    check := bool_value
    check == true
    reason := "BRANCH_A -> master"
}
