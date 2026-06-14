output "ls_framework_sqlserver_db_key_arn" {
  value = aws_kms_alias.ls_framework_sqlserver_kms_key_alias.arn
}
output "ls_framework_ecr_db_key_arn" {
  value = aws_kms_alias.ls_framework_ecr_kms_key_alias.arn
}

