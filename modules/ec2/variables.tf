variable "subnet_id" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "ami" {
  type = string
}

variable "user_data" {
  type = string
  default = ""
}
