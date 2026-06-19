output "ls_framework_sqlserver_secret_value_string" {
  value = aws_secretsmanager_secret_version.ls_framework_sqlserver_secret_value.secret_string
}
output "ls_framework_sqlserver_secret_arn" {
  value = aws_secretsmanager_secret.ls_framework_sqlserver_secret.arn
}
# output "ls_framework_cognito_secret_value_string" {
#   value = aws_secretsmanager_secret_version.ls_framework_cognito_secret_value.secret_string
# }
output "ls_framework_cognito_secret_arn" {
  value = aws_secretsmanager_secret.ls_framework_cognito_secret.arn
}
# output "ls_framework_cognito_secret_value_string" {
#   value = aws_secretsmanager_secret_version.ls_framework_cognito_secret_value.secret_string
# }
# output "ls_framework_sns_secret_value_string" {
#   value = aws_secretsmanager_secret_version.ls_framework_sns_secret_value.secret_string
# }
# output "ls_framework_sqs_secret_value_string" {
#   value = aws_secretsmanager_secret_version.ls_framework_sqs_secret_value.secret_string
# }


output "ls_framework_files_bucket_name" {
  value = aws_s3_bucket.ls_framework_files_bucket.bucket
}
output "ls_framework_frontend_bucket_regional_domain_name" {
  value = aws_s3_bucket.ls_framework_frontend_bucket.bucket_regional_domain_name
}
output "ls_framework_frontend_bucket_id" {
  value = aws_s3_bucket.ls_framework_frontend_bucket.id
}

output "ls_framework_frontend_bucket_arn" {
  value = aws_s3_bucket.ls_framework_frontend_bucket.arn
}
output "ls_framework_frontend_bucket_name" {
  value = aws_s3_bucket.ls_framework_frontend_bucket.bucket
}
output "ls_framework_pipeline_artifacts_bucket" {
  value = aws_s3_bucket.ls_framework_pipeline_artifacts_bucket.bucket
}
output "ls_framework_pipeline_artifacts_bucket_arn" {
  value = aws_s3_bucket.ls_framework_pipeline_artifacts_bucket.arn
}

output "ls_framework_alb_logs" {
  value = aws_s3_bucket.ls_framework_alb_logs.bucket
}

