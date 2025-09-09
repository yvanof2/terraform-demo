variable "subnet_id" {
  description = "Subnet ID for the ALB"
  type        = string
}

variable "security_group_id" {
  description = "Security group ID for the ALB"
  type        = string
}

variable "instance_ids" {
  description = "List of EC2 instance IDs to register with ALB"
  type        = list(string)
}
variable "vpc_id" {
  description = "VPC ID where the ALB target group will be created"
  type        = string
}
