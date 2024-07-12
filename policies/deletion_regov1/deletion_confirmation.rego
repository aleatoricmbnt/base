# Does not work
package terraform

import rego.v1

deny[reason] if {
  resource := input.tfplan.resource_changes[_]
  action := resource.change.actions[count(resource.change.actions) - 1]

  resource_types := {"null_resource", "random_pet", "terraform_data"}
  resource.type == resource_types[_]
  action == "update"

  reason := sprintf(
   "Confirm the deletion of the %q",
   [resource.address],
  )
}