package terraform
import input.tfrun as tfrun

deny[reason] {
    test := tfrun.workspace.name
    reason := sprintf("I am failed :c My current workspace is named %s!",[test])
}