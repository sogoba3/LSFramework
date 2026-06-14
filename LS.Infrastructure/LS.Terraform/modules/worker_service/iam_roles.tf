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
resource "aws_iam_role_policy" "ls_framework_sqlserver_secret_access" {

  name = "${var.service_name}-sql-secret"

  role = aws_iam_role.ls_framework_ecs_task_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [ "secretsmanager:GetSecretValue" ]
        Resource = [ var.ls_framework_sqlserver_secret_arn ]
      }
    ]
  })
}
