package terraform
import input.tfrun as tfrun

deny[reason] {
    contains_error := strings.contains("error", tfrun.workspace.name)
    contains_error
    reason := sprintf("I am failed because my current workspace contains 'error'! :c")
}