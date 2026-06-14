# Internet Gatway
resource "aws_internet_gateway" "ls_framework_igw" {
  vpc_id = aws_vpc.ls_framework_vpc.id

  tags = {
    Name = "${var.project_prefix}-igw"
  }
}