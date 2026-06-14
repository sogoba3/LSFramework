# LS Framework

data "aws_region" "current" {}
# This will returns all the active AZs for my current region
data "aws_availability_zones" "available" {
    state = "available"
}

# LS Framework network (VPC)
module "ls_framework_network" {
  source = "../../../modules/network"
  
  vpc_cidr = var.vpc_cidr
  public_subnet_cidrs = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  private_db_subnet_cidrs = var.private_db_subnet_cidrs

  project_prefix = local.env_context.resource_prefix
}

### LS Framework ECR
module "ls_framework_ecr" {
  source = "../../../global/ecr"
  service_name = var.service_names[0]

  project_prefix = local.env_context.resource_prefix
}

### LS Framework  security
module "ls_framework_security" {
  source = "../../modules/security"

  project_prefix = local.env_context.resource_prefix
}

### LS Framework data
module "ls_framework_data" {
  source = "../../modules/data"
  ls_framework_vpc_id = module.ls_framework_network.ls_framework_vpc_id
  ls_framework_vpc_cidr_block = module.ls_framework_network.ls_framework_vpc_cidr_block
  ls_framework_sqlserver_password = var.ls_framework_sqlserver_password
  # ls_framework_sqlserver_username = var.ls_framework_sqlserver_username
  ls_framework_ecs_service_sg_id = module.ls_framework_security.ls_framework_ecs_service_sg_id
  ls_framework_sqlserver_db_key_arn = module.ls_framework_security.ls_framework_sqlserver_db_key_arn
  ls_framework_db_subnet_group_name = module.ls_framework_network.ls_framework_db_subnet_group_name

  project_prefix = local.env_context.resource_prefix
}


#### Api's modules
module "ls_framework_gateway" {
  source = "../../../modules/ecs_service"
  service_name = var.service_names[1]
  ls_framework_ecr_repository_url = module.ls_framework_ecr.ls_framework_ecr_repository_url
  log_retention_days = 30
  container_port = 4400
  cpu = "256"
  memory = "512"
  desired_count = 1
  ls_framework_vpc_id = module.ls_framework_network.ls_framework_vpc_id
  ls_framework_vpc_private_subnets = module.ls_framework_network.ls_framework_vpc_private_subnets
  ls_framework_vpc_cidr_block = module.ls_framework_network.ls_framework_vpc_cidr_block

  project_prefix = local.env_context.resource_prefix
}

module "ls_framework_auth" {
  source = "../../../modules/ecs_service"
  service_name = var.service_names[2]
  ls_framework_ecr_repository_url = module.ls_framework_ecr.ls_framework_ecr_repository_url
  log_retention_days = 30
  container_port = 4400
  cpu = "256"
  memory = "512"
  desired_count = 1
  ls_framework_vpc_id = module.ls_framework_network.ls_framework_vpc_id
  ls_framework_vpc_private_subnets = module.ls_framework_network.ls_framework_vpc_private_subnets
  ls_framework_vpc_cidr_block = module.ls_framework_network.ls_framework_vpc_cidr_block

  project_prefix = local.env_context.resource_prefix
}
module "ls_framework_tenant_api" {
  source = "../../../modules/ecs_service"
  service_name = var.service_names[3]
  ls_framework_ecr_repository_url = module.ls_framework_ecr.ls_framework_ecr_repository_url
  log_retention_days = 30
  container_port = 4400
  cpu = "256"
  memory = "512"
  desired_count = 1
  ls_framework_vpc_id = module.ls_framework_network.ls_framework_vpc_id
  ls_framework_vpc_private_subnets = module.ls_framework_network.ls_framework_vpc_private_subnets
  ls_framework_vpc_cidr_block = module.ls_framework_network.ls_framework_vpc_cidr_block

  project_prefix = local.env_context.resource_prefix
}
module "ls_framework_appointment_api" {
  source = "../../../modules/ecs_service"
  service_name = var.service_names[4]
  ls_framework_ecr_repository_url = module.ls_framework_ecr.ls_framework_ecr_repository_url
  log_retention_days = 30
  container_port = 4400
  cpu = "256"
  memory = "512"
  desired_count = 1
  ls_framework_vpc_id = module.ls_framework_network.ls_framework_vpc_id
  ls_framework_vpc_private_subnets = module.ls_framework_network.ls_framework_vpc_private_subnets
  ls_framework_vpc_cidr_block = module.ls_framework_network.ls_framework_vpc_cidr_block

  project_prefix = local.env_context.resource_prefix
}
module "ls_framework_audit_api" {
  source = "../../../modules/ecs_service"
  service_name = var.service_names[5]
  ls_framework_ecr_repository_url = module.ls_framework_ecr.ls_framework_ecr_repository_url
  log_retention_days = 30
  container_port = 4400
  cpu = "256"
  memory = "512"
  desired_count = 1
  ls_framework_vpc_id = module.ls_framework_network.ls_framework_vpc_id
  ls_framework_vpc_private_subnets = module.ls_framework_network.ls_framework_vpc_private_subnets
  ls_framework_vpc_cidr_block = module.ls_framework_network.ls_framework_vpc_cidr_block

  project_prefix = local.env_context.resource_prefix
}
module "ls_framework_billing_api" {
  source = "../../../modules/ecs_service"
  service_name = var.service_names[6]
  ls_framework_ecr_repository_url = module.ls_framework_ecr.ls_framework_ecr_repository_url
  log_retention_days = 30
  container_port = 4400
  cpu = "256"
  memory = "512"
  desired_count = 1
  ls_framework_vpc_id = module.ls_framework_network.ls_framework_vpc_id
  ls_framework_vpc_private_subnets = module.ls_framework_network.ls_framework_vpc_private_subnets
  ls_framework_vpc_cidr_block = module.ls_framework_network.ls_framework_vpc_cidr_block

  project_prefix = local.env_context.resource_prefix
}
module "ls_framework_doctor_api" {
  source = "../../../modules/ecs_service"
  service_name = var.service_names[7]
  ls_framework_ecr_repository_url = module.ls_framework_ecr.ls_framework_ecr_repository_url
  log_retention_days = 30
  container_port = 4400
  cpu = "256"
  memory = "512"
  desired_count = 1
  ls_framework_vpc_id = module.ls_framework_network.ls_framework_vpc_id
  ls_framework_vpc_private_subnets = module.ls_framework_network.ls_framework_vpc_private_subnets
  ls_framework_vpc_cidr_block = module.ls_framework_network.ls_framework_vpc_cidr_block

  project_prefix = local.env_context.resource_prefix
}
module "ls_framework_file_service" {
  source = "../../../modules/ecs_service"
  service_name = var.service_names[8]
  ls_framework_ecr_repository_url = module.ls_framework_ecr.ls_framework_ecr_repository_url
  log_retention_days = 30
  container_port = 4400
  cpu = "256"
  memory = "512"
  desired_count = 1
  ls_framework_vpc_id = module.ls_framework_network.ls_framework_vpc_id
  ls_framework_vpc_private_subnets = module.ls_framework_network.ls_framework_vpc_private_subnets
  ls_framework_vpc_cidr_block = module.ls_framework_network.ls_framework_vpc_cidr_block

  project_prefix = local.env_context.resource_prefix
}
module "ls_framework_notification_api" {
  source = "../../../modules/ecs_service"
  service_name = var.service_names[9]
  ls_framework_ecr_repository_url = module.ls_framework_ecr.ls_framework_ecr_repository_url
  log_retention_days = 30
  container_port = 4400
  cpu = "256"
  memory = "512"
  desired_count = 1
  ls_framework_vpc_id = module.ls_framework_network.ls_framework_vpc_id
  ls_framework_vpc_private_subnets = module.ls_framework_network.ls_framework_vpc_private_subnets
  ls_framework_vpc_cidr_block = module.ls_framework_network.ls_framework_vpc_cidr_block

  project_prefix = local.env_context.resource_prefix
}
module "ls_framework_patient_api" {
  source = "../../../modules/ecs_service"
  service_name = var.service_names[10]
  ls_framework_ecr_repository_url = module.ls_framework_ecr.ls_framework_ecr_repository_url
  log_retention_days = 30
  container_port = 4400
  cpu = "256"
  memory = "512"
  desired_count = 1
  ls_framework_vpc_id = module.ls_framework_network.ls_framework_vpc_id
  ls_framework_vpc_private_subnets = module.ls_framework_network.ls_framework_vpc_private_subnets
  ls_framework_vpc_cidr_block = module.ls_framework_network.ls_framework_vpc_cidr_block

  project_prefix = local.env_context.resource_prefix
}
module "ls_framework_worker_service" {
  source = "../../../modules/ecs_service"
  service_name = var.service_names[11]
  ls_framework_ecr_repository_url = module.ls_framework_ecr.ls_framework_ecr_repository_url
  log_retention_days = 30
  container_port = 4400
  cpu = "256"
  memory = "512"
  desired_count = 1
  ls_framework_vpc_id = module.ls_framework_network.ls_framework_vpc_id
  ls_framework_vpc_private_subnets = module.ls_framework_network.ls_framework_vpc_private_subnets
  ls_framework_vpc_cidr_block = module.ls_framework_network.ls_framework_vpc_cidr_block

  project_prefix = local.env_context.resource_prefix
}

