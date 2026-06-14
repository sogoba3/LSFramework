# ELASTIC IP FOR NAT GATEWAYs
resource "aws_eip" "ls_framework_nat_a" {
  domain = "vpc"

  tags = {
    Name = "${var.project_prefix}-nat-a"
  }
}
resource "aws_eip" "ls_framework_nat_b" {
  domain = "vpc"

  tags = {
    Name = "${var.project_prefix}-nat-b"
  }
}
resource "aws_eip" "ls_framework_nat_c" {
  domain = "vpc"

  tags = {
    Name = "${var.project_prefix}-nat-c"
  }
}
# NAT Gateways
resource "aws_nat_gateway" "ls_framework_nat_a" {
  allocation_id = aws_eip.ls_framework_nat_a.id
  subnet_id = aws_subnet.ls_framework_public_subnet_a.id

  depends_on = [ aws_internet_gateway.ls_framework_igw ]

  tags = {
    Name = "${var.project_prefix}-nat-a"
  }
}
resource "aws_nat_gateway" "ls_framework_nat_b" {
  allocation_id = aws_eip.ls_framework_nat_b.id
  subnet_id = aws_subnet.ls_framework_public_subnet_b.id

  depends_on = [ aws_internet_gateway.ls_framework_igw ]

  tags = {
    Name = "${var.project_prefix}-nat-b"
  }
}
resource "aws_nat_gateway" "ls_framework_nat_c" {
  allocation_id = aws_eip.ls_framework_nat_c.id
  subnet_id = aws_subnet.ls_framework_public_subnet_c.id

  depends_on = [ aws_internet_gateway.ls_framework_igw ]

  tags = {
    Name = "${var.project_prefix}-nat-c"
  }
}