package terraform
import input.tfrun as tfrun
import future.keywords.contains

bool_value = true

deny[reason] {
    check := bool_value
    check == true
    reason := sprintf("I am failed because my current workspace is named %s :c",[tfrun.workspace.name])
}

deny[reason] {
    check := bool_value
    check == true
    reason := sprintf("I am failed because my current environment is named %s :c",[tfrun.environment.name])
}

deny[reason] {
    check := bool_value
    check == true
    reason := sprintf("I am failed because run was started by %s :c",[tfrun.created_by.email])
}
