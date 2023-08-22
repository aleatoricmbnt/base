package terraform
import input.tfrun as tfrun
import future.keywords

deny[reason] {
    check := contains(tfrun.workspace.name, "error")
    check == true
    reason := sprintf("I am failed because my current workspace contains 'error'! :c",[tfrun.workspace.name])
}