package terraform

import input.tfplan as tfplan

deny[reason] {
    tfplan.variables != null

    reason := sprintf("Template contains variables. Get rid of the following variables in order to proceed: %v",[tfplan.variables])
}