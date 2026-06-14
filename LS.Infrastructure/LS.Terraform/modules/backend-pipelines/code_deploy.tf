
# resource "aws_codedeploy_app" "ls_framework_codedeploy_ecs" {
#   count            = var.deployment_type == "BLUE_GREEN" ? 1 : 0
#   name = "${var.service_name}-codedeploy-ecs"
#   compute_platform = "ECS"
# }

# resource "aws_iam_role" "ls_framework_codedeploy_ecs_role" {
#   name = "${var.service_name}-codedeploy-ecs-role"
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Effect = "Allow"
#         Principal = {
#           Service = "codedeploy.amazonaws.com"
#         }
#         Action = "sts:AssumeRole"
#       }
#     ]
#   })
# }

# resource "aws_iam_role_policy_attachment" "ls_framework_codedeploy_ecs_role_attachment" {
#   role = aws_iam_role.ls_framework_codedeploy_ecs_role.name
#   policy_arn = "arn:aws:iam::aws:policy/AWSCodeDeployRoleForECS"
# }