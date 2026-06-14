resource "aws_iam_role" "ls_framework_terraform_state_codebuild_role" {
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
resource "aws_iam_role_policy" "ls_framework_codebuild_policy" {
  name = "${var.project_prefix}-terraform-policy"
  role = aws_iam_role.ls_framework_terraform_state_codebuild_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "*"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:GetObjectVersion",
          "s3:PutObject",
          "s3:GetBucketLocation",
          "s3:DeleteObject"
        ]
        Resource = [
          var.ls_framework_pipeline_artifacts_bucket_arn,
          "${var.ls_framework_pipeline_artifacts_bucket_arn}/*"
        ]
      }
    ]
  })
}

#######################################################################
### codepipeline roles
resource "aws_iam_role" "ls_framework_codepipeline_role" {
  name = "${var.project_prefix}-terraform-pipeline-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "codepipeline.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}
resource "aws_iam_role_policy" "ls_framework_terraform_state_codebuild_policy" {
  name = "${var.project_prefix}-terraform-state-codebuild-policy"
  role = aws_iam_role.ls_framework_codepipeline_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Action   = ["codestar-connections:UseConnection"]
        Resource = [aws_codestarconnections_connection.ls_framework_github.arn]
      },
      {
        Effect = "Allow"
        Action = [
          "codebuild:BatchGetBuilds",
          "codebuild:StartBuild"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "ecs:DescribeServices",
          "ecs:DescribeTaskDefinition",
          "ecs:RegisterTaskDefinition",
          "ecs:UpdateService",
          "ecs:ListTasks",
          "ecs:DescribeTasks",
          "ecs:DescribeClusters"
        ]
        Resource = "*"
      },
      # Needed for ECS service updates
      {
        Effect = "Allow"
        Action = [
          "elasticloadbalancing:DescribeTargetGroups",
          "elasticloadbalancing:DescribeListeners",
          "elasticloadbalancing:DescribeRules"
        ]
        Resource = ["*"]
      },
      # CodePipeline Artifact Bucket
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
      {
        Effect = "Allow"
        Action = [
          "kms:Decrypt",
          "kms:Encrypt",
          "kms:GenerateDataKey",
          "kms:DescribeKey"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_codestarconnections_connection" "ls_framework_github" {
  name          = var.github_connection#"github-connection"
  provider_type = "GitHub"
}
data "aws_kms_alias" "s3kmskey" {
  name = "alias/aws/s3"
}