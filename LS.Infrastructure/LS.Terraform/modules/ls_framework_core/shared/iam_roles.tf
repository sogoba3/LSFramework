# LS Framework IAM ROLES

# ECS TASK EXECUTION ROLE
resource "aws_iam_role" "ls_framework_ecs_task_execution_role" {
  name = "${var.project_prefix}-${var.service_name}-ecs-task-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      },
    ]
  })
  
}
resource "aws_iam_role_policy" "ls_framework_ecs_execution_secrets_policy" {
  name = "${var.project_prefix}-${var.service_name}-execution-secrets-policy"
  role = aws_iam_role.ls_framework_ecs_task_execution_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "kms:Decrypt"
        ]
        Resource = "*"
      }
    ]
  })
}

# ECS TASK EXECUTION POLICY
resource "aws_iam_role_policy_attachment" "ls_framework_ecs_task_execution_policy" {
  role       = aws_iam_role.ls_framework_ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

#ECS TASK ROLE
resource "aws_iam_role" "ls_framework_ecs_task_role" {
  name = "${var.project_prefix}-${var.service_name}-ecs-task-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      },
    ]
  })
}
resource "aws_iam_role_policy" "ls_framework_task_role_policies" {

  name = "${var.service_name}-sql-secret"

  role = aws_iam_role.ls_framework_ecs_task_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [ "secretsmanager:GetSecretValue" ]
        Resource = [ var.ls_framework_sqlserver_secret_arn ]
      },
      {
        Effect = "Allow"
        Action = [ 
          "sqs:ReceiveMessage",
          "sqs:DeleteMessage",
          "sqs:GetQueueAttributes",
          "sqs:GetQueueUrl",
          "sqs:ChangeMessageVisibility"
        ]
        Resource = [ var.ls_framework_Tenant_Admin_Signed_Up_Queue_Arn ]
      },
      {
        Effect = "Allow"
        Action = [
          "sns:Publish"
        ]
        Resource = [
          var.ls_framework_Audit_Log_Arn,
          var.ls_framework_Tenant_Admin_Signed_Up_Topic_Arn
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "cognito-idp:SignUp",
          "cognito-idp:AdminConfirmSignUp",
          "cognito-idp:AdminAddUserToGroup"
        ]
        Resource = [
          var.ls_framework_cognito_user_pool_arn
        ]
      }
    ]
  })
}
