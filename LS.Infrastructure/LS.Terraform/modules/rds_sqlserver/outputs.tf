output "ls_framework_sqlserver_db_instance_endpoint" {
    value = aws_db_instance.ls_framework_sqlserver_db_instance.address
}
output "ls_framework_sqlserver_sg_id" {
  value = aws_security_group.ls_framework_sqlserver_sg.id
}