
# TERRAFORM STATE BUCKET
resource "aws_s3_bucket" "ls_framework_terraform_state" {
  bucket = "lsf-terraform-state"
  
  tags = {
    Name = "lsf-terraform-state"
  }
}

# ENABLE VERSIONING
resource "aws_s3_bucket_versioning" "ls_framework_terraform_state_versioning" {
  bucket = aws_s3_bucket.ls_framework_terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

### Encryption at Rest (SSE-S3)
resource "aws_s3_bucket_server_side_encryption_configuration" "ls_framework_terraform_state_sse_s3" {
  bucket = aws_s3_bucket.ls_framework_terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

### Encryption In-Transit
resource "aws_s3_bucket_policy" "ls_framework_tfs_enforce_tls" {
  bucket = aws_s3_bucket.ls_framework_terraform_state.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "EnforceHTTPSOnly"
        Effect    = "Deny"
        Principal = "*"
        Action    = "s3:*"
        Resource = [
          aws_s3_bucket.ls_framework_terraform_state.arn,
          "${aws_s3_bucket.ls_framework_terraform_state.arn}/*"
        ]
        Condition = {
          Bool = {
            "aws:SecureTransport" = "false"
          }
        }
      }
    ]
  })

}

# BLOCK PUBLIC ACCESS
resource "aws_s3_bucket_public_access_block" "ls_framework_terraform_state_access_block" {
  bucket = aws_s3_bucket.ls_framework_terraform_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# # DYNAMODB LOCK TABLE
# resource "aws_dynamodb_table" "ls_framework_terraform_locks" {
#   name         = "${var.project_prefix}-terraform-locks"
#   billing_mode = "PAY_PER_REQUEST"

#   hash_key = "LockID"

#   attribute {
#     name = "LockID"
#     type = "S"
#   }

#   tags = {
#     Name = "${var.project_prefix}-terraform-locks"
#   }
# }