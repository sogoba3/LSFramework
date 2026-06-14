
resource "aws_kms_key" "ls_framework_sqlserver_db_key" {
  description = "Encryption key for ls framework databases"
  deletion_window_in_days = 30
  enable_key_rotation = true
}

resource "aws_kms_alias" "ls_framework_sqlserver_kms_key_alias" {
  name          = "alias/${var.project_prefix}/sqlserver/kms/key/alias"
  target_key_id = aws_kms_key.ls_framework_sqlserver_db_key.id
}

resource "aws_kms_key" "ls_framework_ecr_key" {
  description = "Encryption key for ls framework ecr repositories"
  deletion_window_in_days = 30
  enable_key_rotation = true
}

resource "aws_kms_alias" "ls_framework_ecr_kms_key_alias" {
  name          = "alias/${var.project_prefix}/ecr/kms/key/alias"
  target_key_id = aws_kms_key.ls_framework_ecr_key.id
}