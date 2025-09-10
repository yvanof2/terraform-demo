# Output the ALB URL
output "alb_url" {
  description = "The public URL of the ALB"
  value       = module.alb.alb_dns_name
}

# Output EC2 instance IDs (list)
output "ec2_instance_ids" {
  description = "The ID(s) of the EC2 instance(s)"
  value       = module.ec2.instance_ids
}

# Optional: single EC2 instance ID
output "ec2_instance_id" {
  description = "The first EC2 instance ID"
  value       = module.ec2.instance_ids[0]
}

# Output EC2 public IP
output "ec2_public_ip" {
  description = "The public IP of the EC2 instance(s)"
  value       = module.ec2.public_ip
}

# Output RDS endpoint
output "rds_endpoint" {
  description = "The endpoint of the RDS instance"
  value       = module.rds.db_endpoint
}
