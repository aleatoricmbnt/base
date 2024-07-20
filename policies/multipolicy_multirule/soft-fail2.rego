package terraform
import input.tfrun as tfrun
import future.keywords.in

bool_value = true

deny[reason] {
    check := bool_value
    check == true
    reason := "This policy is always soft-failed"
}


deny[reason] {
    required_vars := {"check": 2, "replacing": "other"}
    not all_vars_match(required_vars)
    reason := "Variable values do not match the required values"
}

all_vars_match(required_vars) {
    count(required_vars) == count({k | some k in required_vars; input.tfplan.variables[k].value == required_vars[k]})
}

deny[reason] {
    some rc in input.tfplan.resource_changes
    rc.change.actions[_] == "delete"
    reason := "Resource changes include a delete action"
}

deny[reason] {
    prior_resources := input.tfplan.prior_state.values.root_module.resources
    some pr in prior_resources
    pr.values.input != 2
    reason := "Prior state resources have an input value different from 2"
}

deny[reason] {
    not approved_email_domain(input.tfrun.created_by.email)
    reason := "Creator email domain is not approved"
}

approved_email_domain(email) {
    approved_domains := {"example.com"}
    some domain
    split(email, "@", parts)
    domain = parts[1]
    domain in approved_domains
}

deny[reason] {
    input.tfrun.environment.name != "old_env"
    reason := "Environment name is not 'old_env'"
}

deny[reason] {
    input.tfrun.cost_estimate.delta_monthly_cost != 1.0
    reason := "Cost estimate delta is not one"
}

deny[reason] {
    input.tfplan.terraform_version != "0.12.0"
    reason := "Terraform version is not 0.12.0"
}

# Repeating similar rules with different conditions or the same for expansion

deny[reason] {
    required_vars := {"check": 3, "replacing": "another"}
    not all_vars_match(required_vars)
    reason := "Variable values do not match the required values (rule 10)"
}

deny[reason] {
    some rc in input.tfplan.resource_changes
    rc.change.actions[_] == "update"
    reason := "Resource changes include an update action (rule 11)"
}

deny[reason] {
    prior_resources := input.tfplan.prior_state.values.root_module.resources
    some pr in prior_resources
    pr.values.output != 2
    reason := "Prior state resources have an output value different from 2 (rule 12)"
}

deny[reason] {
    not approved_email_domain(input.tfrun.created_by.email)
    reason := "Creator email domain is not approved (rule 13)"
}

deny[reason] {
    input.tfrun.environment.name != "another_env"
    reason := "Environment name is not 'another_env' (rule 14)"
}

deny[reason] {
    input.tfrun.cost_estimate.prior_monthly_cost != 0.0
    reason := "Prior monthly cost is not zero (rule 15)"
}

deny[reason] {
    input.tfplan.terraform_version != "1.0.0"
    reason := "Terraform version is not 1.0.0 (rule 16)"
}

deny[reason] {
    required_vars := {"check": 4, "replacing": "other_value"}
    not all_vars_match(required_vars)
    reason := "Variable values do not match the required values (rule 17)"
}

deny[reason] {
    some rc in input.tfplan.resource_changes
    rc.change.actions[_] == "create"
    reason := "Resource changes include a create action (rule 18)"
}

deny[reason] {
    prior_resources := input.tfplan.prior_state.values.root_module.resources
    some pr in prior_resources
    pr.values.input != 3
    reason := "Prior state resources have an input value different from 3 (rule 19)"
}

deny[reason] {
    not approved_email_domain(input.tfrun.created_by.email)
    reason := "Creator email domain is not approved (rule 20)"
}

deny[reason] {
    input.tfrun.environment.name != "new_environment"
    reason := "Environment name is not 'new_environment' (rule 21)"
}

deny[reason] {
    input.tfrun.cost_estimate.proposed_monthly_cost != 0.0
    reason := "Proposed monthly cost is not zero (rule 22)"
}

deny[reason] {
    input.tfplan.terraform_version != "1.2.0"
    reason := "Terraform version is not 1.2.0 (rule 23)"
}

deny[reason] {
    required_vars := {"check": 5, "replacing": "another_value"}
    not all_vars_match(required_vars)
    reason := "Variable values do not match the required values (rule 24)"
}

deny[reason] {
    some rc in input.tfplan.resource_changes
    rc.change.actions[_] == "replace"
    reason := "Resource changes include a replace action (rule 25)"
}

deny[reason] {
    prior_resources := input.tfplan.prior_state.values.root_module.resources
    some pr in prior_resources
    pr.values.output != 3
    reason := "Prior state resources have an output value different from 3 (rule 26)"
}

deny[reason] {
    not approved_email_domain(input.tfrun.created_by.email)
    reason := "Creator email domain is not approved (rule 27)"
}

deny[reason] {
    input.tfrun.environment.name != "old_environment"
    reason := "Environment name is not 'old_environment'"
}

deny[reason] {
    input.tfrun.cost_estimate.delta_monthly_cost != -1.0
    reason := "Cost estimate delta is not negative one (rule 29)"
}

deny[reason] {
    input.tfplan.terraform_version != "0.11.0"
    reason := "Terraform version is not 0.11.0 (rule 30)"
}

# Additional repetitive rules for further expansion

deny[reason] {
    some rc in input.tfplan.resource_changes
    rc.change.actions[_] == "no-op"
    reason := "Resource changes include a no-op action (rule 31)"
}

deny[reason] {
    input.tfrun.is_destroy == false
    reason := "Run is not marked as destroy (rule 32)"
}

deny[reason] {
    input.tfrun.source != "cli"
    reason := "Source is not CLI (rule 33)"
}

deny[reason] {
    input.tfplan.format_version != "1.0"
    reason := "Format version is not 1.0 (rule 34)"
}

deny[reason] {
    input.tfplan.timestamp == null
    reason := "Timestamp is null (rule 35)"
}

deny[reason] {
    input.tfplan.planned_values == null
    reason := "Planned values are null (rule 36)"
}

deny[reason] {
    input.tfplan.configuration == null
    reason := "Configuration is null (rule 37)"
}

deny[reason] {
    input.tfrun.vcs != null
    reason := "VCS is not null (rule 38)"
}

deny[reason] {
    input.tfrun.working_directory != null
    reason := "Working directory is not null (rule 39)"
}

deny[reason] {
    input.tfrun.tags != []
    reason := "Tags are not empty (rule 40)"
}
