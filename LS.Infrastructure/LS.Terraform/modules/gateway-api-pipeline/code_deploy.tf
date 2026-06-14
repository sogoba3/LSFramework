resource "aws_codedeploy_app" "ls_framework_blue_green_codedeploy_app" {
  name = "${var.service_name}-codedeploy-ecs"
  compute_platform = "ECS"
}