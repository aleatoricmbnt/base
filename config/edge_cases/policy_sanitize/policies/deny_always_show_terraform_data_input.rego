package terraform

import input.tfplan as tfplan

# Always fails when the fixture resource is in planned_values; message shows address and values.input.
deny[msg] {
    r := tfplan.planned_values.root_module.resources[_]
    r.address == "terraform_data.policy_sanitize_inputs"
    msg := sprintf("SCALRCORE-37810 deny (resource %v): values=%v input=%v", [r.address, r.values, r.values.input])
}
