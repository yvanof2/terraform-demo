output "instance_id" {
  value = aws_instance.this.id
}

output "ec2_sg_id" {
  value = aws_security_group.ec2.id
}
