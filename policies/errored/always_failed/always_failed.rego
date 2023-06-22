package terraform
import input.tfrun as tfrun

deny[reason] {
    test := tfrun.workspace.name
    test == "lw2"
    reason := sprintf("I am failed because my current workspace is named %s!",[test])
}