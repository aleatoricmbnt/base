# This dummy policy makes a decision based on a number received from random.org service
# just to demonstrate possible usage of HTTP requests
# to fetch external data during policy evaluation.
# See <https://www.openpolicyagent.org/docs/latest/policy-reference/#http>

package terraform


random_number = 6
deny[reason] {
    number := random_number
    number < 1

    reason := sprintf(
        "Unlucky you: got %d, but 6 or more is required",
        [number]
    )
}

random_number2 = 5

deny[reason] {
    number := random_number2
    number < 2

    reason := sprintf(
        "Unlucky you: got %d, but 5 or more is required",
        [number]
    )
}

random_number3 = 4


deny[reason] {
    number := random_number3
    number < 3

    reason := sprintf(
        "Unlucky you: got %d, but 4 or more is required",
        [number]
    )
}
