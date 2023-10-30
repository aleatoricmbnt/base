module "s3bucket" {
	source  = "mshytse.on-prem.scalr.dev/acc-v0o4a0poe8vnenk6r/s3bucket/aws"
	version = "0.0.1"

	# Set 1 required variable below.

	# Number of buckets to be created
 	quantity = 1
}