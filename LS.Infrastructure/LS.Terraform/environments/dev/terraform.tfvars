aws_region   = "us-east-2"
project_name = "ls"
environment  = "dev"
managed_by   = "terraform"

service_names = {
  ecr_repo_name           = "ls_framework_ecr_repository"
  gateway_api_name        = "gateway-api"
  auth_user_api_name      = "auth-user-api"
  tenant_api_name         = "tenant-api"
  appointment_api_name    = "appointment-api"
  audit_api_name          = "audit-api"
  billing_api_name        = "billing-api"
  doctor_api_name         = "doctor-api"
  file_service_api_name   = "file-service-api"
  notification_api_name   = "notification-api"
  patient_api_name        = "patient-api"
  worker_service_api_name = "worker-service-api"
}

#this should be placed in secret manager later and imported into the terraform
ls_framework_sqlserver_username = "admin"
ls_framework_sqlserver_password = "Test123$"
### api services configuration

services = {
  tenant = {
    name = "tenant-api"
  }
  patient = {
    name = "patient-api"
  }
  doctor = {
    name = "doctor-api"
  }
  billing = {
    name = "billing-api"
  }
  auth = {
    name = "auth-api"
  }
  appointment = {
    name = "appointment-api"
  }
  notification = {
    name = "notification-api"
  }
  audit = {
    name = "audit-api"
  }
  file = {
    name = "file-service"
  }
  # worker = "worker-service"
}
api_services_config = {
  gateway-api = {
    cpu                = "1024"
    memory             = "2048"
    container_port     = 4400
    is_web_service     = true
    routing_port       = 443
    routing_test_port  = 8443
    health_check_path  = "/health"
    log_retention_days = 30
    desired_count      = 1

    buildspec  = "deploy/gateway-api/buildspec.yml"
    dockerfile = "deploy/gateway-api/Gateway.Dockerfile"
  }

  auth-api = {
    cpu                = "1024"
    memory             = "2048"
    container_port     = 4404
    is_web_service     = false
    routing_port       = 443
    routing_test_port  = 8443
    health_check_path  = "/health"
    log_retention_days = 30
    desired_count      = 1

    buildspec     = "deploy/auth-api/buildspec.yml"
    dockerfile    = "deploy/auth-api/Auth.Dockerfile"
    source_folder = "src/LS.AuthUserApi"
  }
  tenant-api = {
    cpu                = "1024"
    memory             = "2048"
    container_port     = 4482
    is_web_service     = false
    routing_port       = 443
    routing_test_port  = 8443
    health_check_path  = "/health"
    log_retention_days = 30
    desired_count      = 1

    buildspec     = "deploy/tenant-api/buildspec.yml"
    dockerfile    = "deploy/tenant-api/Tenant.Dockerfile"
    source_folder = "src/LS.TenantApi"
  }
  appointment-api = {
    cpu                = "1024"
    memory             = "2048"
    container_port     = 4466
    is_web_service     = false
    routing_port       = 443
    routing_test_port  = 8443
    health_check_path  = "/health"
    log_retention_days = 30
    desired_count      = 1

    buildspec     = "deploy/appointment-api/buildspec.yml"
    dockerfile    = "deploy/appointment-api/Appointment.Dockerfile"
    source_folder = "src/LS.AppointmentApi"
  }
  audit-api = {
    cpu                = "1024"
    memory             = "2048"
    container_port     = 4488
    is_web_service     = false
    routing_port       = 443
    routing_test_port  = 8443
    health_check_path  = "/health"
    log_retention_days = 30
    desired_count      = 1

    buildspec     = "deploy/audit-api/buildspec.yml"
    dockerfile    = "deploy/audit-api/Audit.Dockerfile"
    source_folder = "src/LS.AuditApi"
  }
  billing-api = {
    cpu                = "1024"
    memory             = "2048"
    container_port     = 4408
    is_web_service     = false
    routing_port       = 443
    routing_test_port  = 8443
    health_check_path  = "/health"
    log_retention_days = 30
    desired_count      = 1

    buildspec     = "deploy/billing-api/buildspec.yml"
    dockerfile    = "deploy/billing-api/Billing.Dockerfile"
    source_folder = "src/LS.BillingApi"
  }
  doctor-api = {
    cpu                = "1024"
    memory             = "2048"
    container_port     = 4440
    is_web_service     = false
    routing_port       = 443
    routing_test_port  = 8443
    health_check_path  = "/health"
    log_retention_days = 30
    desired_count      = 1

    buildspec     = "deploy/doctor-api/buildspec.yml"
    dockerfile    = "deploy/doctor-api/Doctor.Dockerfile"
    source_folder = "src/LS.DoctorApi"
  }
  file-service = {
    cpu                = "1024"
    memory             = "2048"
    container_port     = 4420
    is_web_service     = false
    routing_port       = 443
    routing_test_port  = 8443
    health_check_path  = "/health"
    log_retention_days = 30
    desired_count      = 1

    buildspec     = "deploy/file-service/buildspec.yml"
    dockerfile    = "deploy/file-service/FileService.Dockerfile"
    source_folder = "src/LS.FileServiceApi"
  }
  notification-api = {
    cpu                = "1024"
    memory             = "2048"
    container_port     = 4428
    is_web_service     = false
    routing_port       = 443
    routing_test_port  = 8443
    health_check_path  = "/health"
    log_retention_days = 30
    desired_count      = 1

    buildspec     = "deploy/notification-api/buildspec.yml"
    dockerfile    = "deploy/notification-api/Notification.Dockerfile"
    source_folder = "src/LS.NotificationApi"
  }
  patient-api = {
    cpu                = "1024"
    memory             = "2048"
    container_port     = 4442
    is_web_service     = false
    routing_port       = 443
    routing_test_port  = 8443
    health_check_path  = "/health"
    log_retention_days = 30
    desired_count      = 1

    buildspec     = "deploy/patient-api/buildspec.yml"
    dockerfile    = "deploy/patient-api/Patient.Dockerfile"
    source_folder = "src/LS.PatientApi"
  }
  # worker-service = {
  #   cpu                = "256"
  #   memory             = "512"
  #   container_port     = 0
  #   is_web_service     = false
  #   routing_port       = 443
  #   routing_test_port  = 8443
  #   health_check_path  = "/health"
  #   log_retention_days = 30
  #   desired_count      = 1
  # }
}

### Network module
vpc_cidr                = "10.0.0.0/16"
public_subnet_cidrs     = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs    = ["10.0.16.0/20", "10.0.32.0/20", "10.0.48.0/20"]
private_db_subnet_cidrs = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"]

### dns routing
ls_framework_domain_name = "lsframework.com"

ls_framework_cognito_UserPoolId    = "us-east-2_lXZhLnJRw"
ls_framework_cognito_ClientId      = "70q2ap1l18gl8eno8ask5415r8"
ls_framework_cognito_user_pool_arn = "arn:aws:cognito-idp:us-east-2:968715863111:userpool/us-east-2_lXZhLnJRw"


