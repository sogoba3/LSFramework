
# Start of LS Framework ECR Repositories
resource "aws_ecr_repository" "ls_framework_ecr_repository" {
  name = "lsf-dev-${var.service_name}-repo"
  # force_delete = true
  encryption_configuration {
    encryption_type = "KMS"
    kms_key = var.ls_framework_ecr_db_key_arn
  }
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
  lifecycle {
    ignore_changes = [ encryption_configuration ]
  }
  tags = {
    Name = "ls-dev-${var.service_name}-ecr-repository"
  }
}

#####################################################################################################################