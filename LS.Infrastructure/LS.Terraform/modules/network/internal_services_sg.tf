resource "aws_security_group" "ls_framework_internal_services_sg" {
  name        = "${var.project_prefix}-internal-services-sg"
  description = "Shared security group for internal ECS services"
  vpc_id      = aws_vpc.ls_framework_vpc.id

  tags = {
    Name = "${var.project_prefix}-internal-services-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "internal_services_ingress" {
  security_group_id = aws_security_group.ls_framework_internal_services_sg.id

  referenced_security_group_id = aws_security_group.ls_framework_internal_services_sg.id

  from_port   = 0
  to_port     = 65535
  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "internal_services_egress" {
  security_group_id = aws_security_group.ls_framework_internal_services_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}