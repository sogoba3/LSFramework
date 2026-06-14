

resource "aws_security_group" "ls_framework_vpc_endpoint_sg" {
  name = "${var.project_prefix}-vpce-sg"
  vpc_id = aws_vpc.ls_framework_vpc.id
  description = "VPC endpoint security group (ECR, Logs, SecretsManager etc...)"

  tags = {
    Name = "${var.project_prefix}-vpc-sg"
  }
}

# Inbound rule for LS Framework Application Traffic from aws services
resource "aws_vpc_security_group_ingress_rule" "ls_framework_vpc-endpoint_allow_inbound" {
  for_each = var.ls_framework_ecs_service_sg_id

  security_group_id = aws_security_group.ls_framework_vpc_endpoint_sg.id
  referenced_security_group_id = each.value
  from_port = 443
  ip_protocol = "tcp"
  to_port = 443
}
resource "aws_vpc_security_group_ingress_rule" "vpce_https_from_worker" {
  security_group_id            = aws_security_group.ls_framework_vpc_endpoint_sg.id
  referenced_security_group_id = var.ls_framework_worker_sg_id

  from_port   = 443
  to_port     = 443
  ip_protocol = "tcp"
}

# Outbound traffic
# resource "aws_vpc_security_group_egress_rule" "ls_framework_vpc-endpoint_allow_all_outbound_ipv4" {
#   security_group_id = aws_security_group.ls_framework_vpc_endpoint_sg.id
#   cidr_ipv4         = "0.0.0.0/0"
#   ip_protocol       = "-1"
# }