# resource "aws_codestarconnections_connection" "ls_framework_github" {
#   name          = "github-connection"
#   provider_type = "GitHub"
# }

# resource "aws_codepipeline" "ls_framework_codepipeline" {
#   name     = "${var.service_name}-pipeline"
#   role_arn = aws_iam_role.ls_framework_codepipeline_role.arn

#   artifact_store {
#     location = var.ls_framework_pipeline_artifacts_bucket
#     type     = "S3"

#     encryption_key {
#       id   = data.aws_kms_alias.s3kmskey.arn
#       type = "KMS"
#     }
#   }

#   stage {
#     name = "Source"

#     action {
#         name             = "Source"

#         category         = "Source"
#         owner            = "AWS"
#         provider         = "CodeStarSourceConnection"
#         version          = "1"

#         output_artifacts = ["source_output"]

#         configuration = {
#         ConnectionArn    = aws_codestarconnections_connection.ls_framework_github.arn
#         FullRepositoryId = "sogoba3/LSFramework"
#         BranchName       = "main"
#       }
#     }
#   }

#   stage {
#     name = "Build"

#     action {
#         name             = "Build"
#         category         = "Build"
#         owner            = "AWS"
#         provider         = "CodeBuild"
#         version = "1"

#         input_artifacts  = ["source_output"]
#         output_artifacts = ["build_output"]

#         configuration = {
#             ProjectName = aws_codebuild_project.ls_framework_codebuild_project.name
#         }
#     }
#   }

#   dynamic "stage" {
#     for_each = var.deployment_type == "ECS_ROLLING" ? [1] : []
    
#     content {
#       name = "Deploy"

#       action {
#         name     = "Deploy"
#         category = "Deploy"
#         owner    = "AWS"
#         #provider = "CodeDeployToECS"
#         version = "1"

#         provider = "ECS"
#         # var.is_web_service ? "CodeDeployToECS" : "ECS"

#         input_artifacts = ["build_output"]

#         configuration = {
#             ClusterName = var.ls_framework_ecs_cluster_name
#             ServiceName = "${var.service_name}-service"
#             FileName    = "imagedefinitions.json"
#         }
#       }
#     }
    
    
#   }

#   # blue/green
#   dynamic "stage" {
#     for_each = var.deployment_type == "BLUE_GREEN" ? [1] : []
    
#     content {
#       name = "Deploy"

#       action {
#         name     = "Deploy"
#         category = "Deploy"
#         owner    = "AWS"
#         provider = "CodeDeployToECS"
#         version = "1"

#         input_artifacts = ["build_output"]

#         configuration = {
#             ApplicationName = aws_codedeploy_app.ls_framework_codedeploy_ecs[0].name
#             DeploymentGroupName = aws_codedeploy_deployment_group.ls_framework_deployment_group[0].deployment_group_name

#             TaskDefinitionTemplateArtifact = "build_output"
#             TaskDefinitionTemplatePath     = "deploy/gateway-api/taskdef.json"

#             AppSpecTemplateArtifact = "build_output"
#             AppSpecTemplatePath     = "deploy/gateway-api/appspec.yaml"

#             # Image1ArtifactName             = "build_output"
#             # Image1ContainerName            = "IMAGE1_NAME"
#         }
#       }
#     }
#   }
# }


# data "aws_iam_policy_document" "assume_role" {
#   statement {
#     effect = "Allow"

#     principals {
#       type        = "Service"
#       identifiers = ["codepipeline.amazonaws.com"]
#     }

#     actions = ["sts:AssumeRole"]
#   }
# }
# resource "aws_iam_role" "ls_framework_codepipeline_role" {
#   name               = "${var.service_name}-role"
#   assume_role_policy = data.aws_iam_policy_document.assume_role.json
# }
# data "aws_iam_policy_document" "codepipeline_policy" {
#   # S3 Artifact Bucket
#   statement {
#     effect = "Allow"

#     actions = [
#       "s3:GetObject",
#       "s3:GetObjectVersion",
#       "s3:GetBucketVersioning",
#       "s3:PutObject",
#       "s3:PutObjectAcl",
#       "s3:DeleteObject"
#     ]

#     resources = [
#       var.ls_framework_pipeline_artifacts_bucket_arn,
#       "${var.ls_framework_pipeline_artifacts_bucket_arn}/*"
#     ]
#   }
#   # GitHub Connection
#   statement {
#     effect    = "Allow"
#     actions   = ["codestar-connections:UseConnection"]
#     resources = [aws_codestarconnections_connection.ls_framework_github.arn]
#   }

#   # CodeBuild
#   statement {
#     effect = "Allow"

#     actions = [
#       "codebuild:BatchGetBuilds",
#       "codebuild:StartBuild",
#     ]

#     resources = ["*"]
#   }

#   # ECS Deployments
#   statement {
#     effect = "Allow"

#     actions = [
#       "ecs:DescribeServices",
#       "ecs:DescribeTaskDefinition",
#       "ecs:RegisterTaskDefinition",
#       "ecs:UpdateService",
#       "ecs:ListTasks",
#       "ecs:DescribeTasks",
#       "ecs:DescribeClusters"
#     ]
#     resources = ["*"]
#   }

#   # Required when ECS task definitions contain
#   # executionRoleArn and taskRoleArn
#   statement {
#     effect = "Allow"

#     actions = [
#       "iam:PassRole"
#     ]

#     resources = [
#       var.ls_framework_ecs_task_execution_role_arn,
#       var.ls_framework_ecs_task_role_arn
#     ]
#   }

#   # Needed for ECS service updates
#   statement {
#     effect = "Allow"

#     actions = [
#       "elasticloadbalancing:DescribeTargetGroups",
#       "elasticloadbalancing:DescribeListeners",
#       "elasticloadbalancing:DescribeRules"
#     ]

#     resources = ["*"]
#   }

#   # ONLY needed if deployment_type = BLUE_GREEN
#   statement {
#     effect = "Allow"

#     actions = [
#       "codedeploy:CreateDeployment",
#       "codedeploy:GetDeployment",
#       "codedeploy:GetDeploymentGroup",
#       "codedeploy:GetApplication"
#     ]

#     resources = ["*"]
#   }

# }


# resource "aws_iam_role_policy" "codepipeline_policy" {
#   name   = "codepipeline_policy"
#   role   = aws_iam_role.ls_framework_codepipeline_role.id
#   policy = data.aws_iam_policy_document.codepipeline_policy.json
# }

# data "aws_kms_alias" "s3kmskey" {
#   name = "alias/aws/s3"
# }