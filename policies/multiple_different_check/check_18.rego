package terraform

import input.tfplan as tfplan

deny[reason] {
    number := to_number(tfplan.variables.check.value)
    required := 1
    number < required

    reason := sprintf("Value of 'check' variable is %d! Required to proceed: %d",[number,required])
}
