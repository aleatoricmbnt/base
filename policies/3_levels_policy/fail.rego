package terraform
import input.tfrun as tfrun

bool_value = true

deny[reason] {
    check := bool_value
    check == true
    reason := sprintf("NEW PR COMMIT // 19-DEC-2023 PR: This policy is always failed. FUN FACT: your workspace has the dumbest name ever: %s",[tfrun.workspace.name])
}
