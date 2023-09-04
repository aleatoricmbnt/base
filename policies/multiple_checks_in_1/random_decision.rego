package terraform
import input.tfrun as tfrun
import future.keywords

deny[reason] {
    check := contains(tfrun.workspace.name, "error")
    check == true
    reason := sprintf("I am failed because my current workspace is named %s :c",[tfrun.workspace.name])
}

deny[reason] {
    check := contains(tfrun.environment.name, "error")
    check == true
    reason := sprintf("I am failed because my current environment is named %s :c",[tfrun.environment.name])
}

deny[reason] {
    check := contains(tfrun.created_by.email, "aleatoricmbnt@gmail.com")
    check == true
    reason := sprintf("I am failed because run was started by %s :c",[tfrun.created_by.email])
}
