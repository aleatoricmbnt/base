package terraform

deny[reason] {
  recursive_check(input.tfplan)

  reason := "Some reason that shouldn't be shown due to OPA error"
}

recursive_check(x) {
  x == "some_value"
}

recursive_check(x) {
  recursive_check(x)
}