# Terraform Variable Types Test Module

Tests typed, untyped, sensitive, and non-sensitive variables across all Terraform types. Uses `terraform_data` resources. Use the values below to set variables in Scalr UI.

## Module structure

| Resource | Variables | Output |
|----------|-----------|--------|
| `terraform_data.non_sensitive_simple` | string, string_untyped, number, number_untyped, bool, bool_untyped | `non_sensitive_simple_output` |
| `terraform_data.non_sensitive_list` | list | `non_sensitive_list_output` |
| `terraform_data.non_sensitive_list_untyped` | list_untyped | `non_sensitive_list_untyped_output` |
| `terraform_data.non_sensitive_set` | set | `non_sensitive_set_output` |
| `terraform_data.non_sensitive_set_untyped` | set_untyped | `non_sensitive_set_untyped_output` |
| `terraform_data.non_sensitive_map` | map | `non_sensitive_map_output` |
| `terraform_data.non_sensitive_map_untyped` | map_untyped | `non_sensitive_map_untyped_output` |
| `terraform_data.non_sensitive_object` | object | `non_sensitive_object_output` |
| `terraform_data.non_sensitive_object_untyped` | object_untyped | `non_sensitive_object_untyped_output` |
| `terraform_data.non_sensitive_tuple` | tuple | `non_sensitive_tuple_output` |
| `terraform_data.non_sensitive_tuple_untyped` | tuple_untyped | `non_sensitive_tuple_untyped_output` |
| `terraform_data.sensitive` | All sensitive vars | `sensitive_output` (sensitive) |

## Variable categories

| Category        | Example vars                    |
|----------------|---------------------------------|
| Typed          | string, number, bool, list, map, object, tuple, set |
| Untyped        | string_untyped, number_untyped, list_untyped, etc. |
| Non-sensitive  | All vars above (default)        |
| Sensitive      | string_sensitive, number_sensitive, map_sensitive, etc. |

---

## Copyable values for Scalr UI

### Simple types (string, number, bool)

**string**
```
"Production environment for the main application hosted in us-east-1"
```

**string_untyped**
```
"Staging database connection pool configuration for read replicas"
```

**number**
```
65535
```

**number_untyped**
```
99.99
```

**bool**
```
true
```

**bool_untyped**
```
false
```

---

### Sensitive simple types

**string_sensitive**
```
"postgresql://admin:super_secret_password@db.example.com:5432/production"
```

**number_sensitive**
```
42424242
```

**bool_sensitive**
```
true
```

---

### List / set (single line)

**list**
```
["us-east-1", "us-west-2", "eu-west-1", "ap-southeast-1", "sa-east-1"]
```

**list_untyped**
```
[8080, "https", 3.14159, true, "api"]
```

**set**
```
["read", "write", "execute", "admin", "audit"]
```

**set_untyped**
```
["alpha", "beta", "gamma", "delta"]
```

**list_sensitive**
```
["api-key-xxxxxxxxxxxx", "shared-secret-yyyyyyyy", "token-zzzzzzzzzzzz"]
```

**set_sensitive**
```
["secret_read", "secret_write", "secret_admin"]
```

---

### List / set (multiline, human-readable)

**list** (multiline)
```
[
  "us-east-1",
  "us-west-2",
  "eu-west-1",
  "ap-southeast-1",
  "sa-east-1"
]
```

**list_untyped** (multiline)
```
[
  8080,
  "https",
  3.14159,
  true,
  "api"
]
```

**set** (multiline)
```
[
  "read",
  "write",
  "execute",
  "admin",
  "audit"
]
```

**list_sensitive** (multiline)
```
[
  "api-key-xxxxxxxxxxxx",
  "shared-secret-yyyyyyyy",
  "token-zzzzzzzzzzzz"
]
```

---

### Map (single line)

**map**
```
{"environment" = "production", "region" = "us-east-1", "instance_type" = "m5.large", "min_size" = "3", "max_size" = "10"}
```

**map_untyped**
```
{"port" = 8080, "protocol" = "https", "enabled" = true, "tags" = ["api", "backend", "critical"]}
```

**map_sensitive**
```
{"api_key" = "sk-abc123xyz789", "db_password" = "super_secret_db_pass", "jwt_secret" = "jwt-signing-key-xxx"}
```

---

### Map (multiline, human-readable)

**map** (multiline)
```
{
  "environment"   = "production"
  "region"        = "us-east-1"
  "instance_type" = "m5.large"
  "min_size"      = "3"
  "max_size"      = "10"
  "log_level"     = "info"
}
```

**map_untyped** (multiline)
```
{
  "port"     = 8080
  "protocol" = "https"
  "enabled"  = true
  "tags"     = ["api", "backend", "critical"]
}
```

**map_sensitive** (multiline)
```
{
  "api_key"     = "sk-abc123xyz789"
  "db_password" = "super_secret_db_pass"
  "jwt_secret"  = "jwt-signing-key-xxx"
}
```

---

### Object (single line)

**object**
```
{"name" = "production-database-config", "value" = 5432, "list" = ["primary", "replica-1", "replica-2", "replica-3"]}
```

**object_untyped**
```
{"name" = "api-server-settings", "value" = "8080", "list" = [100, 200, 300, 400]}
```

**object_sensitive**
```
{"name" = "credentials-vault", "value" = 42, "list" = ["secret_a", "secret_b", "secret_c"]}
```

---

### Object (multiline, human-readable)

**object** (multiline)
```
{
  name  = "production-database-config"
  value = 5432
  list  = ["primary", "replica-1", "replica-2", "replica-3"]
}
```

**object_untyped** (multiline)
```
{
  name  = "api-server-settings"
  value = "8080"
  list  = [100, 200, 300, 400]
}
```

**object_sensitive** (multiline)
```
{
  name  = "credentials-vault"
  value = 42
  list  = ["secret_a", "secret_b", "secret_c"]
}
```

---

### Tuple (single line)

**tuple**
```
["production-api-gateway", 443, ["v1", "v2", "v3", "health"]]
```

**tuple_untyped**
```
["staging-worker", 6379, ["queue-a", "queue-b", "queue-c", "dlq"]]
```

**tuple_sensitive**
```
["internal-service-token", 424242]
```

---

### Tuple (multiline, human-readable)

**tuple** (multiline)
```
[
  "production-api-gateway",
  443,
  ["v1", "v2", "v3", "health"]
]
```

**tuple_untyped** (multiline)
```
[
  "staging-worker",
  6379,
  ["queue-a", "queue-b", "queue-c", "dlq"]
]
```

**tuple_sensitive** (multiline)
```
[
  "internal-service-token",
  424242
]
```

---

### Multiline string (Heredoc-style)

For a multiline string value, use a heredoc in Scalr if supported, or escape newlines:

**string** (multiline content)
```
"This is a longer multiline string value.
It can span multiple lines for configuration
or documentation that needs to be human-readable.
Use it for policies, templates, or notes."
```

Or as heredoc (if Scalr accepts):
```
<<-EOT
  Server configuration for production:
  - Enable TLS 1.3
  - Set max connections to 1000
  - Enable connection pooling
EOT
```
