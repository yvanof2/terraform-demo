# modules/alb/main.tf
resource "aws_elb" "this" {
  name               = "demo-elb"
  subnets            = [var.subnet_id]   # single subnet for 1AZ
  security_groups    = [var.security_group_id]
  idle_timeout       = 60
  cross_zone_load_balancing = true

  listener {
    instance_port     = 80
    instance_protocol = "HTTP"
    lb_port           = 80
    lb_protocol       = "HTTP"
  }

  health_check {
    target              = "HTTP:80/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "demo-elb"
  }
}

output "elb_dns_name" {
  value = aws_elb.this.dns_name
}
