resource "terraform_data" "single" {
  input = var.input
  triggers_replace = timestamp()
}

variable "input" {
  type = string
  default = <<EOT
hello
world
EOT
}

locals {
  map =  {
    some_long_string = 10
    even_much_longer_string = 20
    the_string_as_hard_as_a_day_and_as_long_as_the_whole_week_without_beer = 30
  }
}

variable "attributes" {
  default = {
    short_input = "AvovxIxm",
    function_python = "pxJLN46VIzJLfoLqvN0\nYD17vvp2UI9LBRot9uYFq5",
    random_function_string_generator = "GJ11mUdZj5pSTUEbaPX2FPUZXvKYyndAbDsHyg14Yhy4vvSPTqlyCKxpdvqutjsoiUMYmhH",
    string_value_generator_test_function_string_word_python_python = "mT1r85ZTC1CWQNmRnMxaGn5OTgS5AUERgvHC3jgZaN8u9ult7fagwEShBQ97GEN7C6JBBsVJ3Z5X391opN1oQGp8f30ypTCHrBsWn5\nPJN14iHzDo7",
    random_value_random_value_value_test_value_random_function_underscore_function_random_generator_test_python_string_function = <<EOT
The Adepta Sororitas, colloquially called the 'Sisterhood', 
whose military arm is also known as the Sisters of Battle and formerly as the Daughters of the Emperor, 
are an all-female division of the Imperium of Man's state church known as the Ecclesiarchy or, 
more formally, as the Adeptus Ministorum. 
The Sisterhood's Orders Militant serve as the Ecclesiarchy's armed forces, 
mercilessly rooting out spiritual corruption and heresy within Humanity and every organisation of the Adeptus Terra. 
There is naturally some overlap between the duties of the Sisterhood and the Imperial Inquisition; 
for this reason, although the Inquisition and the Sisterhood remain entirely separate organisations, 
the Orders Militant of the Adepta Sororitas also act as the Chamber Militant of the Inquisition's Ordo Hereticus. 
The Adepta Sororitas and the Sisters of Battle are commonly regarded as the same organisation, 
but the latter title technically refers only to the Orders Militant of the Adepta Sororitas, 
the best-known part of the organisation to the Imperial public.
EOT
  }
}

resource "terraform_data" "diff_attributes" {
  for_each = var.attributes
  input = each.value
}