resource "aws_ecs_task_definition" "ls_framework_worker_task_def" {
  family                   = "${var.service_name}-task-def"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"

  cpu    = var.cpu
  memory = var.memory

  execution_role_arn = aws_iam_role.ls_framework_ecs_task_execution_role.arn
  task_role_arn      = aws_iam_role.ls_framework_ecs_task_role.arn

  container_definitions = jsonencode([
    {
      name      = "worker-service"
      image     = var.ls_framework_ecr_repository_url
      essential = true
      cpu    = tonumber(var.cpu)
      memory = tonumber(var.memory)

      environment = [
        {
          name  = "AwsSettings__Region"
          value = var.aws_region
        },
        {
          name = "Database__Host"
          value = var.ls_framework_sqlserver_endpoint
        },
        {
          name = "Database__Name"
          value = "LSFrameworkDb"
        }
      ]
      secrets = [
        {
          name = "ConnectionStrings__DefaultConnection"
          valueFrom = var.ls_framework_sqlserver_secret_arn
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.ls_framework_worker_logs.name
          awslogs-region        = var.aws_region
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
}