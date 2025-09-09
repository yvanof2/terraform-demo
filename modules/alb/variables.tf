variable "vpc_id" {
  type        = string
  description = "The VPC ID where the ALB will be created"
}

variable "subnet_id" {
  type        = string
  description = "The subnet ID for the ALB"
}

variable "security_group_id" {
  type        = string
  description = "Security group ID to attach to the ALB"
}

variable "instance_ids" {
  type        = list(string)
  description = "List of EC2 instance IDs to attach to the target group"
}
