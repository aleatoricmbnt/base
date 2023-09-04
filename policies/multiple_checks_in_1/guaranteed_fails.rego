package terraform
import input.tfrun as tfrun

bool_value = true

deny[reason] {
    check := bool_value
    check == true
    reason := sprintf("Reason ONE. Workspace name: %s",[tfrun.workspace.name])
}

deny[reason] {
    check := bool_value
    check == true
    reason := sprintf("Reason TWO. Envrionment name: %s",[tfrun.environment.name])
}

deny[reason] {
    check := bool_value
    check == true
    reason := sprintf("Reason TWO. Created by // email: %s",[tfrun.created_by.email])
}

deny[reason] {
    check := bool_value
    check == true
    reason := {
        "1st_line": sprintf("Reason ONE. Workspace name: %s",[tfrun.workspace.name]),
        "2nd_line": sprintf("Reason TWO. Envrionment name: %s",[tfrun.environment.name]),
        "3rd_line": sprintf("Reason TWO. Created by // email: %s",[tfrun.created_by.email]),
    }
}