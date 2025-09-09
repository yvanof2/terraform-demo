aws_region        = "us-east-1"
az                = "us-east-1a"

ec2_instance_type = "t3.micro"
ec2_ami           = "ami-0c02fb55956c7d316" # Example Amazon Linux 2 AMI

db_name           = "demodb"
db_username       = "admin"
db_password       = "StrongPassword123!" # Use GitHub secret in production
db_instance_type  = "db.t3.micro"
