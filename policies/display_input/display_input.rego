package terraform

import input.tfplan as tfplan
import input.tfrun as tfrun

bool_value = true

deny[reason] {
    check := bool_value
    check == true

    reason := sprintf("PR _CHECK Input tfplan: %v, \n Input tfrun: %v ",[tfplan, tfrun])
}
