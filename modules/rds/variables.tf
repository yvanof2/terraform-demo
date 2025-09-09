variable "subnet_id" {
  description = "Subnet ID where the RDS instance will be deployed"
  type        = string
}

variable "db_name" {
  description = "Database name"
  type        = string
}

variable "username" {
  description = "Database username"
  type        = string
}

variable "password" {
  description = "Database password"
  type        = string
  sensitive   = true
}

variable "instance_type" {
  description = "RDS instance type"
  type        = string
  default     = "db.t3.micro"
}

variable "security_group_id" {
  description = "Security group ID for RDS instance"
  type        = string
}
