variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "az1" {
  description = "Availability zone 1"
  type        = string
}

variable "az2" {
  description = "Availability zone 2"
  type        = string
}
