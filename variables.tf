# ----------------------
# AWS region and AZ
# ----------------------
variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "az" {
  description = "Availability Zone"
  type        = string
  default     = "us-east-1a"
}

# ----------------------
# EC2 variables
# ----------------------
variable "ec2_ami" {
  description = "AMI ID for EC2 instance"
  type        = string
}

variable "ec2_instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "ec2_user_data" {
  description = "User data script for EC2 instance"
  type        = string
  default = <<EOF
#!/bin/bash
echo "Welcome to Bido's demo" > /var/www/html/index.html
EOF
}

# ----------------------
# RDS variables
# ----------------------
variable "db_name" {
  description = "Database name"
  type        = string
}

variable "db_username" {
  description = "Database username"
  type        = string
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}

variable "db_instance_type" {
  description = "RDS instance type"
  type        = string
  default     = "db.t3.micro"
}
