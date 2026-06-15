
# LS FRAMEWORK ECS Task Definition
resource "aws_ecs_task_definition" "ls_framework_ecs_task_definition" {
    family = "${var.service_name}-task-def"
    requires_compatibilities = ["FARGATE"]
    network_mode             = "awsvpc"
    cpu                      = var.cpu
    memory                   = var.memory

    execution_role_arn = aws_iam_role.ls_framework_ecs_task_execution_role.arn
    task_role_arn = aws_iam_role.ls_framework_ecs_task_role.arn

    container_definitions = jsonencode([{
        #"${var.context.project_name}-${var.context.environment}-gateway"
        "name" = var.service_name
        "image" = var.ls_framework_ecr_repository_url #"nginx:latest"
        "cpu": tonumber(var.cpu)
        "memory": tonumber(var.memory)
        "essential" = true
        
        
        portMappings = [{
            containerPort = tonumber(var.container_port)
            hostPort = tonumber(var.container_port)

        }]
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
            # {
            #     name  = "InternalAlbDns"
            #     value = var.ls_framework_internal_alb_dns_name
            # }
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
                "awslogs-group" = aws_cloudwatch_log_group.ls_framework_logs.name
                "awslogs-region" = var.aws_region
                "awslogs-stream-prefix" = "ecs"
            }
        }
    }])
    
    runtime_platform {
      operating_system_family = "LINUX"
      cpu_architecture = "X86_64" 
    }
}
