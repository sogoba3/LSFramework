resource "aws_codebuild_project" "ls_framework_frontend_codebuild" {
  name = "${var.service_name}-frontend-codebuild"

  service_role = aws_iam_role.ls_framework_frontend_codebuild_role.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  source {
    type = "CODEPIPELINE"

    buildspec = "deploy/ls-front-end/buildspec.yml"
  }

  environment {
    type = "LINUX_CONTAINER"
    compute_type = "BUILD_GENERAL1_SMALL"
    image = "aws/codebuild/standard:7.0"
    #"aws/codebuild/amazonlinux2-x86_64-standard:4.0"

    # privileged_mode = true
    environment_variable {
      name  = "LS_FRAMEWORK_FRONTEND_BUCKET"
      value = var.ls_framework_frontend_bucket_name
    }
    environment_variable {
      name = "CLOUDFRONT_DISTRIBUTION_ID"
      value = var.ls_framework_cloudfront_distribution_id
    }
  }
}

resource "aws_iam_role" "ls_framework_frontend_codebuild_role" {
  name = "${var.project_prefix}-${var.service_name}-codebuild-service-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "codebuild.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}
resource "aws_iam_role_policy" "ls_framework_frontend_codebuild_policy" {
  name = "${var.project_prefix}-${var.service_name}-frontend-codebuild-policy"

  role = aws_iam_role.ls_framework_frontend_codebuild_role.id

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [

      #
      # CloudWatch Logs
      #
      {
        Effect = "Allow"

        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]

        Resource = "*"
      },

      #
      # CodePipeline Artifact Bucket
      #
      {
        Effect = "Allow"

        Action = [
          "s3:GetObject",
          "s3:GetObjectVersion",
          "s3:PutObject",
          "s3:GetBucketLocation"
        ]

        Resource = [
          var.ls_framework_pipeline_artifacts_bucket_arn,
          "${var.ls_framework_pipeline_artifacts_bucket_arn}/*"
        ]
      },

      #
      # Frontend Hosting Bucket
      #
      {
        Effect = "Allow"

        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject",
          "s3:ListBucket"
        ]

        Resource = [
          var.ls_framework_frontend_bucket_arn,
          "${var.ls_framework_frontend_bucket_arn}/*"
        ]
      },

      #
      # CloudFront Cache Invalidation
      #
      {
        Effect = "Allow"

        Action = [
          "cloudfront:CreateInvalidation"
        ]

        Resource = "*"
      },

      #
      # Optional: Parameter Store
      #
      {
        Effect = "Allow"

        Action = [
          "ssm:GetParameter",
          "ssm:GetParameters",
          "ssm:GetParametersByPath"
        ]

        Resource = "*"
      },

      #
      # Optional: Secrets Manager
      #
      {
        Effect = "Allow"

        Action = [
          "secretsmanager:GetSecretValue"
        ]

        Resource = "*"
      }
    ]
  })
}