package terraform

import input.tfplan as tfplan

# Always fails; message embeds tfplan.variables so you can compare sanitized vs raw policy input.
deny[msg] {
    tfplan.variables
    msg := sprintf("SCALRCORE-37810 deny (tfplan.variables): %v", [tfplan.variables])
}
