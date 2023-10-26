module "s3bucket" {
	source  = "mshytse.on-prem.scalr.dev/global/s3bucket/aws"
	version = "0.0.1"

	# Set 1 required variable below.

	# Number of buckets to be created
 	quantity = 1
}