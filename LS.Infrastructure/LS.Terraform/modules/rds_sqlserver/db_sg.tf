### LS FRAMEWORK RDS SQLSERVER SECURITY GROUP
resource "aws_security_group" "ls_framework_sqlserver_sg" {
  name = "${var.project_prefix}-sqlserver-sg"
  vpc_id = var.ls_framework_vpc_id
  
  description = "LS Framework Sql Server Security Group"

  tags = {
    Name = "${var.project_prefix}-sqlserver-sg"
  }
}

# Outbound traffic
resource "aws_vpc_security_group_egress_rule" "ls_framework_sqlserver_allow_all_outbound_ipv4" {
  security_group_id = aws_security_group.ls_framework_sqlserver_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}
