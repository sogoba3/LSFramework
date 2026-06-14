resource "aws_db_instance" "ls_framework_sqlserver_db_instance" {
    allocated_storage           = 20
    # max_allocated_storage = 500
    auto_minor_version_upgrade  = false
    # backup_retention_period     = 7
    db_subnet_group_name        = var.ls_framework_db_subnet_group_name
    engine                      = "sqlserver-ex" #"sqlserver-se"
    engine_version              = "16.00.4250.1.v1"
    identifier                  = "lsf-sqlserver-db-instance"
    instance_class              = "db.t3.micro" #"db.m5.large"
    storage_type = "gp3"
    kms_key_id                  = var.ls_framework_sqlserver_db_key_arn
    # this is should be set to true later for high availability
    multi_az                    = false
    storage_encrypted           = true

    username                    = jsondecode(var.ls_framework_sqlserver_secret_value_string)["username"]
    password                    = jsondecode(var.ls_framework_sqlserver_secret_value_string)["password"]

    port = 1433
    publicly_accessible = false
    vpc_security_group_ids = [aws_security_group.ls_framework_sqlserver_sg.id]
    deletion_protection = false
    enabled_cloudwatch_logs_exports = ["error", "agent"]
    performance_insights_enabled = true
    skip_final_snapshot = true

    timeouts {
    create = "3h"
    delete = "3h"
    update = "3h"
    }
    lifecycle {
        # for production only
      #prevent_destroy = true
      
      ignore_changes = [ kms_key_id, engine_version ]
    }
    tags = {
    Name = "lsf-sqlserver-db-instance"
    }
  
}