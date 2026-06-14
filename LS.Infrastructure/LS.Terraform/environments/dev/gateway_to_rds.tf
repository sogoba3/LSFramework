resource "aws_vpc_security_group_ingress_rule" "gateway_to_rds" {

  security_group_id = module.ls_framework_rds_sql_server.ls_framework_sqlserver_sg_id

  referenced_security_group_id = module.ls_framework_core_shared_ressources["gateway-api"].ls_framework_ecs_service_sg_id

  from_port   = 1433
  to_port     = 1433
  ip_protocol = "tcp"

  description = "Gateway API to SQL Server"
}