package terraform

deny[reason] {
    rule_a := rule_b

    rule_b := rule_a

    reason := "Some reason that shouldn't be shown due to OPA error"
}