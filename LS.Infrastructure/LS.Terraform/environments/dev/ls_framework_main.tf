# LS Framework

# This will return the current region LS FRAMEWORK is running
data "aws_region" "current" {}
# This will returns all the active AZs for my current region
data "aws_availability_zones" "available" {
  state = "available"
}
### Terraform state bucket
data "aws_s3_bucket" "ls_framework_terraform_state_bucket" {
  bucket = "lsf-terraform-state"
}
##########################################################################################
# LS Framework network (VPC)
module "ls_framework_network" {
  source                  = "../../modules/network"
  aws_region              = "us-east-2"
  vpc_cidr                = var.vpc_cidr
  public_subnet_cidrs     = var.public_subnet_cidrs
  private_subnet_cidrs    = var.private_subnet_cidrs
  private_db_subnet_cidrs = var.private_db_subnet_cidrs

  ls_framework_ecs_service_sg_id = {
    for k, v in module.ls_framework_core_shared_ressources :
    k => v.ls_framework_ecs_service_sg_id
  }
  ls_framework_worker_sg_id = module.ls_framework_worker_service.ls_framework_worker_sg_id

  project_prefix = local.env_context.resource_prefix
}
##########################################################################################
### LS Framework  security
module "ls_framework_security" {
  source = "../../modules/security"

  project_prefix = local.env_context.resource_prefix
}
##########################################################################################
### LS Framework ECR
module "ls_framework_ecr" {
  source                      = "../../global/ecr"
  for_each                    = toset(local.env_context.ecr_repositories)
  service_name                = each.value #var.service_names.ecr_repo_name
  ls_framework_ecr_db_key_arn = module.ls_framework_security.ls_framework_ecr_db_key_arn

  project_prefix = local.env_context.resource_prefix
}
##########################################################################################
### LS Framework ECS Cluster
module "ls_framework_ecs_cluster" {
  source = "../../modules/ecs_cluster"

  project_prefix = local.env_context.resource_prefix
}
##########################################################################################
### LS Framework data
module "ls_framework_rds_sql_server" {
  source                                     = "../../modules/rds_sqlserver"
  ls_framework_db_subnet_group_name          = module.ls_framework_network.ls_framework_db_subnet_group_name
  ls_framework_sqlserver_db_key_arn          = module.ls_framework_security.ls_framework_sqlserver_db_key_arn
  ls_framework_vpc_id                        = module.ls_framework_network.ls_framework_vpc_id
  ls_framework_sqlserver_secret_value_string = module.ls_framework_data.ls_framework_sqlserver_secret_value_string

  project_prefix = local.env_context.resource_prefix
}
module "ls_framework_data" {
  source = "../../modules/data"

  ls_framework_frontend_s3_distribution_arn = module.ls_framework_edge.ls_framework_frontend_s3_distribution_arn

  ls_framework_sqlserver_password = var.ls_framework_sqlserver_password
  ls_framework_sqlserver_username = var.ls_framework_sqlserver_username

  # ls_framework_sqlserver_endpoint = module.ls_framework_rds_sql_server.ls_framework_sqlserver_db_instance_endpoint

  # ls_framework_ecs_service_sg_id    = module.ls_framework_gateway_api_service.ls_framework_ecs_service_sg_id
  ls_framework_sqlserver_db_key_arn = module.ls_framework_security.ls_framework_sqlserver_db_key_arn

  project_prefix = local.env_context.resource_prefix
}
##########################################################################################
### LS Framework edge
module "ls_framework_edge" {
  source = "../../modules/edge"

  providers = {
    aws          = aws
    aws.virginia = aws.virginia
  }
  ls_framework_alb_dns_name = module.ls_framework_alb.ls_framework_alb_dns_name
  # ls_framework_domain_name                          = var.ls_framework_domain_name
  # ls_framework_frontend_bucket_id                   = module.ls_framework_data.ls_framework_frontend_bucket_id
  ls_framework_frontend_bucket_regional_domain_name = module.ls_framework_data.ls_framework_frontend_bucket_regional_domain_name

  project_prefix = local.env_context.resource_prefix
}
##########################################################################################
### LS Framework Gateway
# module "ls_framework_gateway" {
#   source = "../../modules/gateway"

#   domain_name                  = "api"
#   ls_framework_alb_dns_name    = module.ls_framework_alb.ls_framework_alb_dns_name
#   ls_framework_alb_zone_id     = module.ls_framework_alb.ls_framework_alb_zone_id
#   ls_framework_route53_zone_id = module.ls_framework_dns_routing.ls_framework_route53_zone_id
# }
##########################################################################################
### LS Framework Application Load Balancer
module "ls_framework_alb" {
  source                         = "../../modules/alb"
  domain_name                    = "lsframework"
  gateway_blue_target_group_arn  = module.ls_framework_gateway_api_service.ls_framework_lb_blue_tg_arn
  gateway_green_target_group_arn = module.ls_framework_gateway_api_service.ls_framework_lb_green_tg_arn
  ls_framework_alb_logs          = module.ls_framework_data.ls_framework_alb_logs
  ls_framework_ecs_service_sg_id = module.ls_framework_core_shared_ressources["gateway-api"].ls_framework_ecs_service_sg_id
  routing_port                   = var.api_services_config["gateway-api"].routing_port
  routing_test_port              = var.api_services_config["gateway-api"].routing_test_port
  ls_framework_vpc_id            = module.ls_framework_network.ls_framework_vpc_id
  ls_framework_private_subnets   = module.ls_framework_network.ls_framework_private_subnets
  ls_framework_public_subnets    = module.ls_framework_network.ls_framework_public_subnets

  project_prefix = local.env_context.resource_prefix
}
module "ls_framework_service_discovery" {
  source              = "../../global/service_discovery"
  services            = var.services
  ls_framework_vpc_id = module.ls_framework_network.ls_framework_vpc_id
}
##########################################################################################
### Shared LS framework Core ressources
module "ls_framework_core_shared_ressources" {
  for_each = var.api_services_config

  source       = "../../modules/ls_framework_core/shared"
  service_name = each.key
  aws_region   = "us-east-2"

  container_port                    = each.value.container_port
  memory                            = each.value.memory
  cpu                               = each.value.cpu
  log_retention_days                = each.value.log_retention_days
  ls_framework_ecr_repository_url   = module.ls_framework_ecr[each.key].ls_framework_ecr_repository_url
  ls_framework_external_alb_sg_id   = module.ls_framework_alb.ls_framework_external_alb_sg_id
  ls_framework_sqlserver_endpoint   = module.ls_framework_rds_sql_server.ls_framework_sqlserver_db_instance_endpoint
  ls_framework_sqlserver_secret_arn = module.ls_framework_data.ls_framework_sqlserver_secret_arn
  ls_framework_vpc_id               = module.ls_framework_network.ls_framework_vpc_id
  # ls_framework_internal_alb_dns_name = module.ls_framework_alb.ls_framework_internal_alb_name

  project_prefix = local.env_context.resource_prefix
}
### gateway-api service module
module "ls_framework_gateway_api_service" {
  source = "../../modules/ls_framework_core/blue_green_service"

  service_name                     = var.service_names.gateway_api_name
  ls_framework_ecs_service_sg_id   = module.ls_framework_core_shared_ressources["gateway-api"].ls_framework_ecs_service_sg_id
  ls_framework_task_definition_arn = module.ls_framework_core_shared_ressources["gateway-api"].ls_framework_ecs_task_definition_arn
  container_port                   = var.api_services_config["gateway-api"].container_port
  desired_count                    = var.api_services_config["gateway-api"].desired_count
  health_check_path                = var.api_services_config["gateway-api"].health_check_path
  ls_framework_private_subnets     = module.ls_framework_network.ls_framework_private_subnets
  ls_framework_vpc_id              = module.ls_framework_network.ls_framework_vpc_id
  ls_framework_ecs_cluster_id      = module.ls_framework_ecs_cluster.ls_framework_ecs_cluster_id

  ls_framework_service_discovery_arn = ""

  project_prefix = local.env_context.resource_prefix
}
##########################################################################################
# Api's modules
module "ls_framework_services" {
  for_each = {
    for key, value in var.api_services_config : key => value
    if key != "gateway-api"
  }
  source = "../../modules/ls_framework_core/rolling_service"

  service_name                     = each.key
  ls_framework_ecs_service_sg_id   = module.ls_framework_core_shared_ressources[each.key].ls_framework_ecs_service_sg_id
  ls_framework_task_definition_arn = module.ls_framework_core_shared_ressources[each.key].ls_framework_ecs_task_definition_arn
  desired_count                    = each.value.desired_count
  ls_framework_ecs_cluster_id      = module.ls_framework_ecs_cluster.ls_framework_ecs_cluster_id
  ls_framework_private_subnets     = module.ls_framework_network.ls_framework_private_subnets

  ls_framework_service_discovery_arn = module.ls_framework_service_discovery.ls_framework_discovery_services_arns[replace(replace(each.key, "-service", ""), "-api", "")]
}
module "ls_framework_worker_service" {
  source                          = "../../modules/worker_service"
  log_retention_days              = 30
  cpu                             = "256"
  memory                          = "512"
  desired_count                   = 1
  aws_region                      = "us-east-2"
  service_name                    = "worker"
  ls_framework_ecr_repository_url = module.ls_framework_ecr["worker-service"].ls_framework_ecr_repository_url
  ls_framework_ecs_cluster_id     = module.ls_framework_ecs_cluster.ls_framework_ecs_cluster_id
  ls_framework_private_subnets    = module.ls_framework_network.ls_framework_private_subnets
  ls_framework_vpc_id             = module.ls_framework_network.ls_framework_vpc_id

  ls_framework_sqlserver_secret_arn = module.ls_framework_data.ls_framework_sqlserver_secret_arn
  ls_framework_sqlserver_endpoint   = module.ls_framework_rds_sql_server.ls_framework_sqlserver_db_instance_endpoint

  # ls_framework_service_discovery_arn = module.ls_framework_service_discovery.ls_framework_discovery_services_arns["worker"]

  project_prefix = local.env_context.resource_prefix
}



##########################################################################################
### AWS CI/CD Pipelines
# Terraform State Pipeline
module "ls_framework_terraform_state_pipeline" {
  source            = "../../modules/terraform-state-pipeline"
  github_connection = "terraform-state-github-connect"

  service_name                               = "lsf-terraform-state"
  ls_framework_pipeline_artifacts_bucket     = module.ls_framework_data.ls_framework_pipeline_artifacts_bucket
  ls_framework_pipeline_artifacts_bucket_arn = module.ls_framework_data.ls_framework_pipeline_artifacts_bucket_arn
  ls_framework_terraform_state_bucket_arn    = data.aws_s3_bucket.ls_framework_terraform_state_bucket.arn

  project_prefix = local.env_context.resource_prefix
}
# Front End pipeline
module "ls_framework_frontend_pipeline" {
  source = "../../modules/frontend-pipeline"

  service_name                               = "ls-framework-frontend"
  ls_framework_cloudfront_distribution_id    = module.ls_framework_edge.ls_framework_cloudfront_distribution_id
  ls_framework_frontend_bucket_arn           = module.ls_framework_data.ls_framework_frontend_bucket_arn
  ls_framework_frontend_bucket_name          = module.ls_framework_data.ls_framework_frontend_bucket_name
  ls_framework_pipeline_artifacts_bucket     = module.ls_framework_data.ls_framework_pipeline_artifacts_bucket
  ls_framework_pipeline_artifacts_bucket_arn = module.ls_framework_data.ls_framework_pipeline_artifacts_bucket_arn

  project_prefix = local.env_context.resource_prefix
}

# Worker Service pipeline
module "ls_framework_worker_service_pipeline" {
  source            = "../../modules/worker-service-pipeline"
  service_name      = "worker"
  github_connection = "worker-service-github-connection"

  buildspec_path  = "deploy/worker-service/buildspec.yml"
  dockerfile_path = "deploy/worker-service/WorkerService.Dockerfile"

  ls_framework_ecs_cluster_name              = module.ls_framework_ecs_cluster.ls_framework_ecs_cluster_name
  ls_framework_ecs_task_execution_role_arn   = module.ls_framework_worker_service.ls_framework_ecs_task_execution_role_arn
  ls_framework_ecs_task_role_arn             = module.ls_framework_worker_service.ls_framework_ecs_task_role_arn
  ls_framework_pipeline_artifacts_bucket     = module.ls_framework_data.ls_framework_pipeline_artifacts_bucket
  ls_framework_pipeline_artifacts_bucket_arn = module.ls_framework_data.ls_framework_pipeline_artifacts_bucket_arn

  project_prefix = local.env_context.resource_prefix
}
# Api services pipelines
module "ls_framework_internal_services_pipelines" {
  for_each = {
    for key, value in var.api_services_config : key => value
    if key != "gateway-api"
  }
  #Source
  source = "../../modules/internal-apis-pipeline"

  #service name
  service_name = each.key

  github_connection = "${each.key}-github-connect"
  buildspec_path    = each.value.buildspec
  dockerfile_path   = each.value.dockerfile

  # Cluster Name
  ls_framework_ecs_cluster_name = module.ls_framework_ecs_cluster.ls_framework_ecs_cluster_name

  ls_framework_ecs_task_execution_role_arn = module.ls_framework_core_shared_ressources[each.key].ls_framework_ecs_task_execution_role_arn
  ls_framework_ecs_task_role_arn           = module.ls_framework_core_shared_ressources[each.key].ls_framework_ecs_task_role_arn

  # pipeline artifacts bucket
  ls_framework_pipeline_artifacts_bucket     = module.ls_framework_data.ls_framework_pipeline_artifacts_bucket
  ls_framework_pipeline_artifacts_bucket_arn = module.ls_framework_data.ls_framework_pipeline_artifacts_bucket_arn

  # project environment context
  project_prefix = local.env_context.resource_prefix

}

# Gateway api service pipeline
module "ls_framework_gateway_api_service_pipeline" {
  #Source
  source = "../../modules/gateway-api-pipeline"
  #service name
  service_name = "gateway-api"

  github_connection = "gateway-api-github-connection"

  buildspec_path  = "deploy/gateway-api/buildspec.yml"
  dockerfile_path = "deploy/gateway-api/Gateway.Dockerfile"

  # Cluster Name
  ls_framework_ecs_cluster_name            = module.ls_framework_ecs_cluster.ls_framework_ecs_cluster_name
  ls_framework_ecs_task_execution_role_arn = module.ls_framework_core_shared_ressources["gateway-api"].ls_framework_ecs_task_execution_role_arn
  ls_framework_ecs_task_role_arn           = module.ls_framework_core_shared_ressources["gateway-api"].ls_framework_ecs_task_role_arn

  # pipeline artifacts bucket
  ls_framework_pipeline_artifacts_bucket     = module.ls_framework_data.ls_framework_pipeline_artifacts_bucket
  ls_framework_pipeline_artifacts_bucket_arn = module.ls_framework_data.ls_framework_pipeline_artifacts_bucket_arn

  # ECS Service Name
  ls_framework_ecs_service_name     = module.ls_framework_gateway_api_service.ls_framework_ecs_service_name
  ls_framework_sqlserver_secret_arn = module.ls_framework_data.ls_framework_sqlserver_secret_arn
  # Target Groups
  ls_framework_lb_blue_tg_name  = module.ls_framework_gateway_api_service.ls_framework_lb_blue_tg_name
  ls_framework_lb_green_tg_name = module.ls_framework_gateway_api_service.ls_framework_lb_green_tg_name

  # Listners
  ls_framework_lb_listner_production_arn = module.ls_framework_alb.ls_framework_lb_listner_production_arn
  ls_framework_lb_listner_test_arn       = module.ls_framework_alb.ls_framework_lb_listner_test_arn

  # project environment context
  project_prefix = local.env_context.resource_prefix
}