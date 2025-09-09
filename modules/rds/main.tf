resource "aws_db_subnet_group" "this" {
  name       = "${var.db_name}-subnet-group"
  subnet_ids = var.subnet_ids   # <-- this should be a list of subnet IDs
  tags = {
    Name = "${var.db_name}-subnet-group"
  }
}


resource "aws_db_instance" "this" {
  db_name              = var.db_name
  username             = var.username
  password             = var.password
  instance_class       = var.instance_type
  allocated_storage    = 20
  engine               = "mysql"
  skip_final_snapshot  = true
  publicly_accessible  = false

  vpc_security_group_ids = [var.security_group_id]
  db_subnet_group_name   = var.subnet_id
}
