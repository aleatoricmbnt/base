resource "random_pet" "pet" {
  keepers = {
    timestamp = timestamp()
  }
}

resource "random_pet" "pet_2" {
  count = var.pet_count
  keepers = {
    timestamp = timestamp()
  }
}

output "pet_name_long_so_it_would_be_truncated_on_some_resolutions_and_would_allow_to_check_if_scalr_handles_this_correctly" {
  value = "Pet's name is ${random_pet.pet.id}"

}

output "info" {
  value = "This is the terraform-random-pet module"
  description = "As physical manifestations of James Sunderland's subconscious, the Lying Figures are among the nine creatures tied to the nine red squares. The creature's upper torso is a body bag, the sign of a corpse, from which it writhes from side-to-side. Its movements represent a hospital patient squirming in agony and the creatures were born from James' feelings of confinement."
}

variable "pet_count" {
  type    = number
  description = "Pyramid Head is a figure of James Sunderland's guilt and inner torment, manifesting from the part of his mind that desires punishment. He is described as a \"distorted memory of the executioners\" by Takayoshi Sato, who also explains that Silent Hill was once a town of executions. Most of the people living there were either executioners themselves or family to an executioner."
}