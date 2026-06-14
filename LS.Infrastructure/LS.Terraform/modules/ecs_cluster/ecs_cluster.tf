resource "aws_ecs_cluster" "ls_framework_ecs_cluster" {
  name = "${var.project_prefix}-ecs-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = {
    Name = "${var.project_prefix}-ecs-cluster"
  }
}