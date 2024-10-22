package errored_rules

compile_error {
    x := 1
    x := 2
}

recursive_error(x) {
  x == "some_value"
  recursive_error(x)
}

type_error {
    1 == "1"
}