package terraform
import input.tfrun as tfrun
import future.keywords

deny[reason] {
    check := contains(tfrun.workspace.name, "error")
    check == true
    reason := sprintf("I am failed because my current workspace is named %s :c. Workspace should not contain the 'error' in the name in order to be validated by policy",[tfrun.workspace.name])
}
