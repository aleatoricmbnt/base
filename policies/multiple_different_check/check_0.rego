package terraform
import input.tfrun as tfrun
import future.keywords

deny[reason] {
    check := contains(tfrun.workspace.name, "error")
    check == true
    reason := sprintf("PR: I am failed because my current workspace is named %s :c",[tfrun.workspace.name])
}
