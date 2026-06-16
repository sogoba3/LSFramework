data "aws_caller_identity" "current" {}

### FILES S3 BUCKET
resource "aws_s3_bucket" "ls_framework_files_bucket" {
  bucket = "${var.project_prefix}-files-bucket"
  
  #force_destroy = true
  tags = {
    Name = "${var.project_prefix}-files-bucket"
  }
}

### VERSIONING
resource "aws_s3_bucket_versioning" "ls_framework_files_bucket_versioning" {
  bucket = aws_s3_bucket.ls_framework_files_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

### Encryption at Rest (SSE-S3)
resource "aws_s3_bucket_server_side_encryption_configuration" "ls_framework_fb_sse_s3" {
  bucket = aws_s3_bucket.ls_framework_files_bucket.id
  
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

### Encryption In-Transit
resource "aws_s3_bucket_policy" "ls_framework_fb_enforce_tls" {
    bucket = aws_s3_bucket.ls_framework_files_bucket.id

    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
        {
            Sid       = "EnforceHTTPSOnly"
            Effect    = "Deny"
            Principal = "*"
            Action    = "s3:*"
            Resource = [
            aws_s3_bucket.ls_framework_files_bucket.arn,
            "${aws_s3_bucket.ls_framework_files_bucket.arn}/*"
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

### BLOCK PUBLIC ACCESS
resource "aws_s3_bucket_public_access_block" "ls_framework_fb_access_block" {
    bucket = aws_s3_bucket.ls_framework_files_bucket.id

    block_public_acls = true
    block_public_policy = true
    ignore_public_acls = true
    restrict_public_buckets = true
}

######################################################################################################

### ALB Access Logs Bucket
resource "aws_s3_bucket" "ls_framework_alb_logs" {
  bucket = "${var.project_prefix}-alb-logs"
  force_destroy = true
  tags = {
    Name = "${var.project_prefix}-alb-logs"
  }
}

### VERSIONING
resource "aws_s3_bucket_versioning" "ls_framework_alb_logs_bucket_versioning" {
  bucket = aws_s3_bucket.ls_framework_alb_logs.id
  versioning_configuration {
    status = "Enabled"
  }
}

### Encryption at Rest (SSE-S3)
resource "aws_s3_bucket_server_side_encryption_configuration" "ls_framework_alb_logs_sse_s3" {
  bucket = aws_s3_bucket.ls_framework_alb_logs.id
  
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

### Encryption In-Transit
data "aws_iam_policy_document" "ls_framework_alb_logs_policy" {
  statement {
    sid    = "EnforceTLSRequestsOnly"
    effect = "Deny"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = [
      "s3:*"
    ]

    resources = [
      aws_s3_bucket.ls_framework_alb_logs.arn,
      "${aws_s3_bucket.ls_framework_alb_logs.arn}/*"
    ]

    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values   = ["false"]
    }
  }

  statement {
    sid    = "AllowALBToReadBucketACL"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["logdelivery.elasticloadbalancing.amazonaws.com"]
    }

    actions = [
      "s3:GetBucketAcl"
    ]

    resources = [
      aws_s3_bucket.ls_framework_alb_logs.arn
    ]
  }

  statement {
    sid    = "AllowALBToWriteLogs"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["logdelivery.elasticloadbalancing.amazonaws.com"]
    }

    actions = [
      "s3:PutObject"
    ]

    resources = [
      "${aws_s3_bucket.ls_framework_alb_logs.arn}/AWSLogs/${data.aws_caller_identity.current.account_id}/*"
    ]

    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }
  }

}

resource "aws_s3_bucket_policy" "ls_framework_alb_logs_enforce_tls" {
  bucket = aws_s3_bucket.ls_framework_alb_logs.id
  policy = data.aws_iam_policy_document.ls_framework_alb_logs_policy.json
}

### BLOCK PUBLIC ACCESS
resource "aws_s3_bucket_public_access_block" "ls_framework_alb_logs_access_block" {
    bucket = aws_s3_bucket.ls_framework_alb_logs.id

    block_public_acls = true
    block_public_policy = true
    ignore_public_acls = true
    restrict_public_buckets = true
}

######################################################################################################
### React JS Typescript Material UI FrontEnd Bucket
resource "aws_s3_bucket" "ls_framework_frontend_bucket" {
  bucket = "${var.project_prefix}-frontend-bucket"

  force_destroy = true
  tags = {
    Name = "${var.project_prefix}-frontend-bucket"
  }
}

### VERSIONING
resource "aws_s3_bucket_versioning" "ls_framework_frontend_bucket_versioning" {
  bucket = aws_s3_bucket.ls_framework_frontend_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

### Encryption at Rest (SSE-S3)
resource "aws_s3_bucket_server_side_encryption_configuration" "ls_framework_frontend_sse_s3" {
  bucket = aws_s3_bucket.ls_framework_frontend_bucket.id
  
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

### Allow cloudfront to access S3
resource "aws_s3_bucket_policy" "ls_framework_s3_bucket_frontend_policy" {
    bucket = aws_s3_bucket.ls_framework_frontend_bucket.id
    policy = data.aws_iam_policy_document.ls_framework_frontend_policy_document.json

    # depends_on = [aws_cloudfront_distribution.ls_framework_frontend_s3_distribution]
}
data "aws_iam_policy_document" "ls_framework_frontend_policy_document" {
  # version = "2012-10-17"

  statement {
    sid    = "AllowCloudFront"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    actions   = ["s3:GetObject"]
    resources = ["arn:aws:s3:::${aws_s3_bucket.ls_framework_frontend_bucket.id}/*"]
    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = [var.ls_framework_frontend_s3_distribution_arn]
      #["arn:aws:cloudfront::${data.aws_caller_identity.current.account_id}:distribution/*"]
      
    }
  }

  statement {
    sid    = "DenyInsecureTransport"
    effect = "Deny"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = ["s3:*"]

    resources = [
      "arn:aws:s3:::${aws_s3_bucket.ls_framework_frontend_bucket.id}",
      "arn:aws:s3:::${aws_s3_bucket.ls_framework_frontend_bucket.id}/*"
      ]
    #[ "arn:aws:s3:::${var.ls_framework_frontend_bucket_id}/*" ]

    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values   = ["false"]
    }
  }
}

### BLOCK PUBLIC ACCESS
resource "aws_s3_bucket_public_access_block" "ls_framework_frontend_access_block" {
    bucket = aws_s3_bucket.ls_framework_frontend_bucket.id

    block_public_acls = true
    block_public_policy = true
    ignore_public_acls = true
    restrict_public_buckets = true
}

######################################################################################################

### CI/CD pipeline artifacts
resource "aws_s3_bucket" "ls_framework_pipeline_artifacts_bucket" {
  bucket = "${var.project_prefix}-pipeline-artifacts-bucket"
  force_destroy = true
  tags = {
    Name = "${var.project_prefix}-pipeline-artifacts-bucket"
  }
}

### VERSIONING
resource "aws_s3_bucket_versioning" "ls_framework_pipeline_artifacts_bucket_versioning" {
  bucket = aws_s3_bucket.ls_framework_pipeline_artifacts_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

### Encryption at Rest (SSE-S3)
resource "aws_s3_bucket_server_side_encryption_configuration" "ls_framework_pipeline_artifacts_sse_s3" {
  bucket = aws_s3_bucket.ls_framework_pipeline_artifacts_bucket.id
  
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

### Encryption In-Transit
resource "aws_s3_bucket_policy" "ls_framework_pipeline_artifacts_enforce_tls" {
    bucket = aws_s3_bucket.ls_framework_pipeline_artifacts_bucket.id

    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
        {
            Sid       = "EnforceHTTPSOnly"
            Effect    = "Deny"
            Principal = "*"
            Action    = "s3:*"
            Resource = [
            aws_s3_bucket.ls_framework_pipeline_artifacts_bucket.arn,
            "${aws_s3_bucket.ls_framework_pipeline_artifacts_bucket.arn}/*"
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

### BLOCK PUBLIC ACCESS
resource "aws_s3_bucket_public_access_block" "ls_framework_pipeline_artifacts_access_block" {
    bucket = aws_s3_bucket.ls_framework_pipeline_artifacts_bucket.id

    block_public_acls = true
    block_public_policy = true
    ignore_public_acls = true
    restrict_public_buckets = true
}

