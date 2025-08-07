output "output_3mb" {
  description = "3MB output"
  value = join("", [
    for i in range(0, 3145728) : "A" # 3MB = 3 * 1024 * 1024 bytes
  ])
}

output "output_4mb" {
  description = "4MB output"
  value = join("", [
    for i in range(0, 4194304) : "B" # 4MB = 4 * 1024 * 1024 bytes
  ])
}

output "output_5mb" {
  description = "5MB output"
  value = join("", [
    for i in range(0, 5242880) : "C" # 5MB = 5 * 1024 * 1024 bytes
  ])
}
