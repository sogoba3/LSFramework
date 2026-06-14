aws_region = "us-east-2"
project_name = "ls-framework"
environment = "prod"
managed_by   = "terraform"
service_names = [
    "ls_framework_ecr_repository",
    "gateway-api",
    "auth-user-api",
    "tenant-api",
    "appointment-api",
    "audit-api",
    "billing-api",
    "doctor-api",
    "file-service-api",
    "notification-api",
    "patient-api",
    "worker-service-api"
]

### Network module
vpc_cidr = "10.0.0.0/16"
public_subnet_cidrs = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.16.0/20", "10.0.32.0/20", "10.0.48.0/20"]
private_db_subnet_cidrs = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"]