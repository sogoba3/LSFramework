resource "aws_vpc_security_group_ingress_rule" "worker_to_rds" {

  security_group_id = module.ls_framework_rds_sql_server.ls_framework_sqlserver_sg_id

  referenced_security_group_id = module.ls_framework_worker_service.ls_framework_worker_sg_id

  from_port = 1433
  to_port   = 1433

  ip_protocol = "tcp"

  description = "Worker Service to SQL Server"
}