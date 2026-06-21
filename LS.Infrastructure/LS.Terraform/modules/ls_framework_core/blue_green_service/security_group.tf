### Gateway API SERVICE SECURITY GROUP
resource "aws_security_group" "ls_framework_gateway_service_sg" {
  name = "${var.project_prefix}-${var.service_name}-gateway-service-sg"
  vpc_id = var.ls_framework_vpc_id
  description = "LS Framework Gateway Api Service Security Group"

  tags = {
    Name = "${var.project_prefix}-${var.service_name}-gateway-service-sg"
  }
}

# Inbound rule for LS Framework Application Traffic from ALB only
resource "aws_vpc_security_group_ingress_rule" "ls_framework_gateway_service_ingress" {
  security_group_id = aws_security_group.ls_framework_gateway_service_sg.id
  referenced_security_group_id = var.ls_framework_external_alb_sg_id
  from_port = var.container_port #4400
  ip_protocol = "tcp"
  to_port = var.container_port #4400
}