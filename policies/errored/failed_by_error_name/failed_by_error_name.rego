package terraform
import input.tfrun as tfrun
import future.keywords

deny[reason] {
    contains("error", tfrun.workspace.name)
    reason := sprintf("I am failed because my current workspace contains 'error'! :c")
}