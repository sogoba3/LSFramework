
#CLOUDWATCH LOG GROUP for LS Framework ECS 
resource "aws_cloudwatch_log_group" "ls_framework_logs" {
  name =  "/${var.project_prefix}/${var.service_name}"
  retention_in_days = var.log_retention_days

  tags = {
    Name = "${var.project_prefix}-${var.service_name}-logs"
  }
}