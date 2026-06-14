output "ls_framework_ecs_cluster_name" {
  value = aws_ecs_cluster.ls_framework_ecs_cluster.name
  description = "The name of the cluster hosting LS Framework microservices"
}

output "ls_framework_ecs_cluster_id" {
  value = aws_ecs_cluster.ls_framework_ecs_cluster.id
}