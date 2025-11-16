resource "null_resource" "no_vars" {
  triggers = {
    "timestamp_2" = timestamp()
  }
}

# resource "terraform_data" "oom_test" {
#   depends_on = [null_resource.no_vars]
#   provisioner "local-exec" {
#     command = "python3 -c \"s = ' ' * (2**30)\""
#   }
# }

data "external" "oom_generator" {
  program = ["python3", "-c", <<-EOF
import json
import sys

# Allocate massive data structure
data = {}
for i in range(10000000):
    data[f'key_{i}'] = 'x' * 1000

# Terraform expects JSON output
print(json.dumps({'result': 'completed'}))
EOF
  ]
}
