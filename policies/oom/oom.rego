package terraform
package example

# Define a rule that calls itself recursively without a base case
oom_rule {
    oom_rule
}

default allow = false

allow {
    oom_rule
}