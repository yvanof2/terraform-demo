output "instance_ids" {
  description = "List of EC2 instance IDs"
  value       = [aws_instance.this.id]   # wrap in list
}

output "ec2_sg_id" {
  description = "EC2 security group ID"
  value       = aws_security_group.ec2.id
}

output "public_ip" {
  description = "Public IP of EC2 instance"
  value       = aws_instance.this.public_ip
}
