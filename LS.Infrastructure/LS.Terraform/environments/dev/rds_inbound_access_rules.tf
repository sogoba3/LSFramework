resource "aws_vpc_security_group_ingress_rule" "internal_services_to_rds" {
  # for_each = var.api_services_config
  # for_each = {
  #   for key, value in var.api_services_config : key => value
  #   if key != "gateway-api"
  # }

  security_group_id = module.ls_framework_rds_sql_server.ls_framework_sqlserver_sg_id

  referenced_security_group_id = module.ls_framework_network.ls_framework_internal_services_sg_id
  #module.ls_framework_services[each.key].ls_framework_ecs_service_sg_id

  from_port   = 1433
  to_port     = 1433
  ip_protocol = "tcp"

  description = "internal services to SQL Server"
}

resource "aws_vpc_security_group_ingress_rule" "worker_to_rds" {

  security_group_id = module.ls_framework_rds_sql_server.ls_framework_sqlserver_sg_id

  referenced_security_group_id = module.ls_framework_worker_service.ls_framework_worker_sg_id

  from_port = 1433
  to_port   = 1433

  ip_protocol = "tcp"

  description = "Worker Service to SQL Server"
}