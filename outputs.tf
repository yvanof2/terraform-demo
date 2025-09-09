# Output the ALB URL
output "alb_url" {
  description = "The public URL of the ALB"
  value       = module.alb.alb_dns_name
}

# Output EC2 instance ID
output "ec2_instance_id" {
  description = "The ID of the EC2 instance"
  value       = module.ec2.instance_id
}

# Output RDS endpoint
output "rds_endpoint" {
  description = "The endpoint of the RDS instance"
  value       = module.rds.db_endpoint
}
