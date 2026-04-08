output "priority_value" {
  value       = random_integer.priority.result
  description = "Random priority value"
}

output "instance_count" {
  value = var.instance_count
}
