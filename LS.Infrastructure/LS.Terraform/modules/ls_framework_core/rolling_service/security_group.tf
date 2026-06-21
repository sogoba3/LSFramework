### ECS SERVICE SECURITY GROUP
resource "aws_security_group" "ls_framework_ecs_service_sg" {
  name = "${var.project_prefix}-${var.service_name}-ecs-service-sg"
  vpc_id = var.ls_framework_vpc_id
  description = "LS Framework ECS Service Security Group"

  tags = {
    Name = "${var.project_prefix}-${var.service_name}-ecs-service-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "service_ingress" {
  security_group_id = aws_security_group.ls_framework_ecs_service_sg.id

  referenced_security_group_id = var.ls_framework_gateway_service_sg_id

  from_port = var.container_port
  to_port   = var.container_port
  ip_protocol = "tcp"
}

# Outbound traffic
resource "aws_vpc_security_group_egress_rule" "ls_framework_ecs_service_egress_rule" {
  security_group_id = aws_security_group.ls_framework_ecs_service_sg.id
  
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}