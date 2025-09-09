# AWS provider configuration
variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "az" {
  description = "Availability zone to deploy resources"
  type        = string
  default     = "us-east-1a"
}

# EC2 variables
variable "ec2_instance_type" {
  description = "Type of EC2 instance"
  type        = string
  default     = "t3.micro"
}

variable "ec2_ami" {
  description = "AMI ID for EC2"
  type        = string
}

# RDS variables
variable "db_name" {
  description = "RDS database name"
  type        = string
  default     = "demodb"
}

variable "db_username" {
  description = "RDS master username"
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "RDS master password"
  type        = string
  sensitive   = true
}

variable "db_inst_
