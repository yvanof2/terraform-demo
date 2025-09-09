variable "ami" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID where EC2 will be deployed"
  type        = string
}

variable "security_group_id" {
  description = "Security group ID for the EC2 instance"
  type        = string
}

variable "user_data" {
  description = "User data script for the EC2 instance"
  type        = string
  default     = ""
}
variable "vpc_id" {
  description = "VPC ID for EC2 and security group"
  type        = string
}

