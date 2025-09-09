variable "subnet_id" {
  description = "Subnet ID for ALB"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID for ALB"
  type        = string
}

variable "security_group_id" {
  description = "Security group for ALB"
  type        = string
}

variable "instance_ids" {
  description = "List of EC2 instance IDs to attach to target group"
  type        = list(string)
}
