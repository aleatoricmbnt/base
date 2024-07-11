package terraform

# Define a rule that calls itself recursively without a base case
oom_rule {
    deny
}

# The deny rule that calls oom_rule recursively
deny {
    oom_rule
}

default allow = true