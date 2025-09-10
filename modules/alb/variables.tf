variable "vpc_id" {
  description = "The VPC ID where the ALB will be created"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnets to associate with the ALB"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security group ID for the ALB"
  type        = string
}

variable "instance_ids" {
  description = "List of EC2 instance IDs to attach to the ALB target group"
  type        = list(string)
}
