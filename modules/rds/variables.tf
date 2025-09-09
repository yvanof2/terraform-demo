variable "db_name" {
  description = "The name of the initial database to create"
  type        = string
}

variable "username" {
  description = "The master username for the database"
  type        = string
}

variable "password" {
  description = "The master password for the database"
  type        = string
  sensitive   = true
}

variable "instance_type" {
  description = "The RDS instance type (e.g., db.t3.micro)"
  type        = string
  default     = "db.t3.micro"
}

variable "security_group_id" {
  description = "The security group to associate with the RDS instance"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the DB subnet group"
  type        = list(string)
}
