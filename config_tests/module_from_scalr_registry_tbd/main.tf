module "aleatoric" {
	source  = "test.mshytse-tests.testenv.scalr.dev/base/aleatoric/nested"
	version = "2.0.0"
}

module "data" {
	source  = "test.mshytse-tests.testenv.scalr.dev/base/data/readme"
	version = "2.0.0"

	# Set 1 required variable below.

	# Some variable description
 	not_a_trigger = "value"
}

module "data" {
	source  = "test.mshytse-tests.testenv.scalr.dev/base/data/terrafrom"
	version = "2.0.0"

	# Set 2 required variables below.

 	data_input = "<value>"

 	quantity = 1
}

module "git" {
	source  = "test.mshytse-tests.testenv.scalr.dev/base/git/reference"
	version = "2.0.0"
}

module "gyk6lofu95wnsersaw46m67kfg6oaoo2z9f0rw1aav1tsdt0zb87rxxeu6y4r48z" {
	source  = "test.mshytse-tests.testenv.scalr.dev/base/gyk6lofu95wnsersaw46m67kfg6oaoo2z9f0rw1aav1tsdt0zb87rxxeu6y4r48z/long"
	version = "2.0.0"
}

module "integer" {
	source  = "test.mshytse-tests.testenv.scalr.dev/base/integer/random"
	version = "2.0.0"
}

module "module" {
	source  = "test.mshytse-tests.testenv.scalr.dev/base/module/1ver"
	version = "2.0.0"
}

module "module" {
	source  = "test.mshytse-tests.testenv.scalr.dev/base/module/null"
	version = "2.0.0"

	# Set 1 required variable below.

	# Number of resources to be created
 	quantity = 1
}

module "pet" {
	source  = "test.mshytse-tests.testenv.scalr.dev/base/pet/random"
	version = "2.0.0"
}

module "readme" {
	source  = "test.mshytse-tests.testenv.scalr.dev/base/readme/extensive"
	version = "2.0.0"
}