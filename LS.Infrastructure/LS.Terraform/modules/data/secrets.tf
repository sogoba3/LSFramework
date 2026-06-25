### LS FRAMEWORK SECRETS MANAGER SECRET
resource "aws_secretsmanager_secret" "ls_framework_sqlserver_secret" {
  #name = "${var.project_prefix}/sqlserver"
  name = "${var.project_prefix}/sqlserver44"
  description             = "Master credentials for the LS Framework SQL Server DB"
  kms_key_id = var.ls_framework_sqlserver_db_key_arn
  tags = {
    Name = "${var.project_prefix}-sqlserver-secret"
  }
}

### STORE SQL SERVER CREDENTIALS(Secrets)
resource "aws_secretsmanager_secret_version" "ls_framework_sqlserver_secret_value" {
  secret_id = aws_secretsmanager_secret.ls_framework_sqlserver_secret.id

  secret_string = jsonencode({
    username = var.ls_framework_sqlserver_username
    password = var.ls_framework_sqlserver_password
  })
}

######################################################################################
resource "aws_secretsmanager_secret" "ls_framework_cognito_secret" {
  name = "${var.project_prefix}/cognito21"
  description             = "Cognito secrets"
  tags = {
    Name = "${var.project_prefix}-cognito-secret"
  }
}
resource "aws_secretsmanager_secret_version" "ls_framework_cognito_secret_value" {
  secret_id = aws_secretsmanager_secret.ls_framework_cognito_secret.id

  secret_string = jsonencode({
    UserPoolId = var.ls_framework_cognito_UserPoolId
    ClientId = var.ls_framework_cognito_ClientId
  })
}


