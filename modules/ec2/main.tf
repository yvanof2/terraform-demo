resource "aws_instance" "this" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = var.subnet_id

  vpc_security_group_ids = [var.security_group_id]

  user_data = var.user_data

  tags = {
    Name = "Demo-EC2"
  }
}

# Output EC2 instance ID
output "instance_id" {
  value = aws_instance.this.id
}
