package terraform

# Generate a large number of entries
oom_rule {
    data.example.generate_large_set[entry]
}

generate_large_set[entry] {
    count := 10000000
    entry := count
}

# The deny rule that triggers oom_rule
deny {
    oom_rule
}

default allow = true