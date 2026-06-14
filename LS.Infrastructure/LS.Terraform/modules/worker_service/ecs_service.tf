resource "aws_ecs_service" "ls_framework_worker_ecs_service" {
  name            = "${var.service_name}-service"
  cluster         = var.ls_framework_ecs_cluster_id
  task_definition = aws_ecs_task_definition.ls_framework_worker_task_def.arn
  desired_count   = var.desired_count
  launch_type     = "FARGATE"

  # deployment_circuit_breaker {
  #   enable = true
  #   rollback = true
  # }
  deployment_controller {
    type = "ECS"
  }
  network_configuration {
    assign_public_ip = false
    subnets         = var.ls_framework_private_subnets
    security_groups = [aws_security_group.worker_sg.id]
  }

  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent = 200
  enable_execute_command = true

  lifecycle {
    ignore_changes = [ task_definition ]
  }

  tags = {
    Name = "worker-api-service"
  }
}