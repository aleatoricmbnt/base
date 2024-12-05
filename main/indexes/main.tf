locals {
  map =  {
    some_long_string = 10
    even_much_longer_string = 20
    the_string_as_hard_as_a_day_and_as_long_as_the_whole_week_without_beer = 30
  }
}

resource "random_password" "test" {
  for_each = local.map
  length = each.value
}

locals {
  triggers =  {
    0 = "one"
    1 = "two"
    2 = "three"
  }
}

resource "null_resource" "test" {
  for_each = local.triggers
  triggers = {
    some_trigger = each.value
  }
}

resource "terraform_data" "test" {
  count = 3
  input = "blah-blah-blah"
}

resource "terraform_data" "test_string" {
  for_each = local.triggers
  input = each.value
}

resource "terraform_data" "triggered_by_test" {
  input = "my input"
  triggers_replace = terraform_data.test
}