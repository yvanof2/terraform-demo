resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = var.az
  map_public_ip_on_launch = true
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = var.az
}
