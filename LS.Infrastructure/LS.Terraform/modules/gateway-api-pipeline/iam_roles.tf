### codebuild role
resource "aws_iam_role" "ls_framework_gateway_api_service_codebuild_role" {
  name = "${var.project_prefix}-${var.service_name}-codebuild-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "codebuild.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}
resource "aws_iam_role_policy" "codebuild_policy" {
  name = "${var.project_prefix}-${var.service_name}-codebuild-policy"
  role = aws_iam_role.ls_framework_gateway_api_service_codebuild_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      # CloudWatch Logs
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "*"
      },
      # ECR
      {
        Effect = "Allow"
        Action = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:BatchGetImage",
          "ecr:GetDownloadUrlForLayer",
          "ecr:InitiateLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:CompleteLayerUpload",
          "ecr:PutImage"
        ]
        Resource = "*"
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


      # Parameter Store
      {
        Effect = "Allow"
        Action = [
          "ssm:GetParameter",
          "ssm:GetParameters",
          "ssm:GetParametersByPath"
        ]
        Resource = "*"
      },
      # Secrets Manager
      {
        Effect = "Allow"
        Action = [ "secretsmanager:GetSecretValue" ]
        Resource = "*"
      },
      # KMS
      {
        Effect = "Allow"
        Action = [
          "kms:Decrypt",
          "kms:Encrypt",
          "kms:GenerateDataKey"
        ]
        Resource = "*"
      }
    ]
  })
}



resource "aws_iam_role" "ls_framework_gateway_api_service_codepipeline_role" {
  name = "${var.service_name}-blue-green-pipeline-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "codepipeline.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}
resource "aws_iam_role_policy" "ls_framework_codepipeline_policy" {
  role = aws_iam_role.ls_framework_gateway_api_service_codepipeline_role.id

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
      {
        Effect = "Allow"
        Action = [
        "codedeploy:CreateDeployment",
        "codedeploy:GetDeployment",
        "codedeploy:GetDeploymentGroup",
        "codedeploy:GetApplication",
        "codedeploy:GetApplicationRevision",
        "codedeploy:RegisterApplicationRevision",
        "codedeploy:GetDeploymentConfig"
        ]
        Resource = ["*"]
      },
      # Needed for ECS service updates
      {
        Effect = "Allow"
        Action = [
          "elasticloadbalancing:DescribeTargetGroups",
          "elasticloadbalancing:DescribeListeners",
          "elasticloadbalancing:DescribeRules",
          "elasticloadbalancing:ModifyListener",
          "elasticloadbalancing:ModifyRule"
        ]
        Resource = ["*"]
      },
      {
        Effect = "Allow"
        Action = "iam:PassRole"
        Resource = "*"
        # [
        #   var.ls_framework_ecs_task_execution_role_arn,
        #   var.ls_framework_ecs_task_role_arn
        # ]
        # Condition = {
        #   StringEquals = {
        #     "iam:PassedToService": "ecs-tasks.amazonaws.com"
        #   }
        # }
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


####################
### codedeploy role
resource "aws_iam_role" "ls_framework_blue_green_codedeploy_role" {
  name = "${var.service_name}-codedeploy-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "codedeploy.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}
resource "aws_iam_role_policy_attachment" "ls_framework_policy_attachment" {
  role       = aws_iam_role.ls_framework_blue_green_codedeploy_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeDeployRoleForECS"
}



resource "aws_iam_policy" "ls_framework_ecs_passrole_policy" {
  name = "${var.project_prefix}-${var.service_name}-ecs-passrole-policy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = "iam:PassRole",
        Resource = [
          var.ls_framework_ecs_task_role_arn,
          var.ls_framework_ecs_task_execution_role_arn
        ]
      }
    ]
  })
}
resource "aws_iam_role_policy_attachment" "ls_framework_attach_passrole" {
  role       = aws_iam_role.ls_framework_gateway_api_service_codepipeline_role.name
  policy_arn = aws_iam_policy.ls_framework_ecs_passrole_policy.arn
}