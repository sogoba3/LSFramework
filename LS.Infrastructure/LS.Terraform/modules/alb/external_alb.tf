### APPLICATION LOAD BALANCER FACING THE INTERNET
resource "aws_alb" "ls_framework_external_alb" {
  name               = "${var.project_prefix}-external-alb"
  internal           = false
  load_balancer_type = "application"

  security_groups = [aws_security_group.ls_framework_external_alb_sg.id]
  subnets         = var.ls_framework_public_subnets

  enable_deletion_protection = false

  access_logs {
    bucket  = var.ls_framework_alb_logs
    #module.ls_framework_data.ls_framework_alb_logs
    enabled = true
  }

  tags = {
    Name = "${var.project_prefix}-external-alb"
  }
}

### LS FRAMEWORK APPLICATION LOAD BALANCER FACING THE INTERNET
resource "aws_security_group" "ls_framework_external_alb_sg" {
  name   = "${var.project_prefix}-external-alb-sg"
  vpc_id = var.ls_framework_vpc_id

  description = "LS Framework ALB Security Group allowing public internet traffic to the Gateway"

  tags = {
    Name = "${var.project_prefix}-external-alb-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ls_framework_ext_ingress_rule_http" {
  security_group_id = aws_security_group.ls_framework_external_alb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80

  description = "Allow HTTP"
}


resource "aws_vpc_security_group_ingress_rule" "ls_framework_ext_ingress_rule_https" {
  security_group_id = aws_security_group.ls_framework_external_alb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443

  description = "Allow HTTPs"
}
resource "aws_vpc_security_group_ingress_rule" "ls_framework_ext_ingress_rule_8443" {
  security_group_id = aws_security_group.ls_framework_external_alb_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 8443
  to_port     = 8443
  ip_protocol = "tcp"

  description = "Allow ALB HTTPS custom port"
}

# Outbound traffic
resource "aws_vpc_security_group_egress_rule" "ls_framework_ext_egress_rule" {
  security_group_id = aws_security_group.ls_framework_external_alb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}