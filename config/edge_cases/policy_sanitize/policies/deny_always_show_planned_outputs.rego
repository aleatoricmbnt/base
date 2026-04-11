package terraform

import input.tfplan as tfplan

# Always fails when planned outputs include the fixture output; message shows the full output object.
deny[msg] {
    o := tfplan.planned_values.outputs.all_vars_yaml
    msg := sprintf("SCALRCORE-37810 deny (planned_values.outputs.all_vars_yaml): %v", [o])
}
