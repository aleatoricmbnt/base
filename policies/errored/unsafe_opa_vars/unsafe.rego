deny[reason] {
    x := 1
    x != y

    reason := "In this policy variable 'x' is compared with non-assigned 'y' variable"
}