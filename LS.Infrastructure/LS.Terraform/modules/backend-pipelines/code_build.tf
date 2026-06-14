
# # data "aws_caller_identity" "current" {}

# resource "aws_codebuild_project" "ls_framework_codebuild_project" {
#   name = "${var.service_name}-codebuild-project"

#   service_role = aws_iam_role.ls_framework_codebuild_role.arn

#   artifacts {
#     type = "CODEPIPELINE"
#   }

#   source {
#     type = "CODEPIPELINE"
#     buildspec = var.buildspec_path
#     # var.is_web_service ? "deploy/gateway-api/buildspec.yml" : "deploy/${var.service_name}/buildspec.yml"
#   }

#   environment {
#     type = "LINUX_CONTAINER"

#     compute_type = "BUILD_GENERAL1_SMALL"

#     image = "aws/codebuild/amazonlinux2-x86_64-standard:4.0"

#     privileged_mode = true

#     environment_variable {
#       name  = "SERVICE_NAME"
#       value = var.service_name
#     }

#     environment_variable {
#       name  = "DOCKERFILE_PATH"
#       value = var.dockerfile_path
#     }
#   }
# }

# resource "aws_iam_role" "ls_framework_codebuild_role" {
#   name = "${var.project_prefix}-${var.service_name}-codebuild-service-role"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Effect = "Allow"
#         Principal = {
#           Service = "codebuild.amazonaws.com"
#         }
#         Action = "sts:AssumeRole"
#       }
#     ]
#   })
# }

# resource "aws_iam_role_policy" "ls_framework_codebuild_policy" {
#   name = "${var.project_prefix}-${var.service_name}-codebuild-policy"

#   role = aws_iam_role.ls_framework_codebuild_role.id

#   policy = jsonencode({
#     Version = "2012-10-17"

#     Statement = [

#       #
#       # CloudWatch Logs
#       #
#       {
#         Effect = "Allow"

#         Action = [
#           "logs:CreateLogGroup",
#           "logs:CreateLogStream",
#           "logs:PutLogEvents"
#         ]

#         Resource = "*"
#       },

#       {
#         Effect = "Allow"

#         Action = "iam:PassRole"

#         Resource = [
#           var.ls_framework_ecs_task_execution_role_arn,
#           var.ls_framework_ecs_task_role_arn
#         ]

#         Condition = {
#           StringEquals = {
#             "iam:PassedToService": "ecs-tasks.amazonaws.com"
#           }
#         }
#       },

#       #
#       # ECR
#       #
#       {
#         Effect = "Allow"

#         Action = [
#           "ecr:GetAuthorizationToken",
#           "ecr:BatchCheckLayerAvailability",
#           "ecr:BatchGetImage",
#           "ecr:GetDownloadUrlForLayer",
#           "ecr:InitiateLayerUpload",
#           "ecr:UploadLayerPart",
#           "ecr:CompleteLayerUpload",
#           "ecr:PutImage"
#         ]

#         Resource = "*"
#       },

#       #
#       # CodePipeline Artifact Bucket
#       #
#       {
#         Effect = "Allow"

#         Action = [
#           "s3:GetObject",
#           "s3:GetObjectVersion",
#           "s3:PutObject",
#           "s3:GetBucketLocation"
#         ]

#         Resource = [
#           var.ls_framework_pipeline_artifacts_bucket_arn,
#           "${var.ls_framework_pipeline_artifacts_bucket_arn}/*"
#         ]
#       },

#       #
#       # Parameter Store
#       #
#       {
#         Effect = "Allow"

#         Action = [
#           "ssm:GetParameter",
#           "ssm:GetParameters",
#           "ssm:GetParametersByPath"
#         ]

#         Resource = "*"
#       },

#       #
#       # Secrets Manager
#       #
#       {
#         Effect = "Allow"

#         Action = [
#           "secretsmanager:GetSecretValue"
#         ]

#         Resource = "*"
#       },

#       #
#       # KMS
#       #
#       {
#         Effect = "Allow"

#         Action = [
#           "kms:Decrypt",
#           "kms:Encrypt",
#           "kms:GenerateDataKey"
#         ]

#         Resource = "*"
#       }
#     ]
#   })
# }

