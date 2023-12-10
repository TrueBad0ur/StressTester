variable "image_flavor" {
  type = string
  default = "Ubuntu-22.04-202208"
}


variable "compute_flavor" {
  type = string
  default = "Advanced-16-32-50"
}


variable "key_pair_name" {
  type = string
  default = "key"
}


variable "availability_zone_name" {
  type = string
  default = "GZ1"
}
