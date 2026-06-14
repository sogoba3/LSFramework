# Details

Date : 2026-05-28 23:06:56

Directory /Users/aboubacarsogoba/Desktop/LSFramework/LS.Infrastructure

Total : 40 files,  1373 codes, 157 comments, 353 blanks, all 1883 lines

[Summary](results.md) / Details / [Diff Summary](diff.md) / [Diff Details](diff-details.md)

## Files
| filename | language | code | comment | blank | total |
| :--- | :--- | ---: | ---: | ---: | ---: |
| [LS.Infrastructure/LS.Terraform/environments/dev/ls\_framework\_main.tf](/LS.Infrastructure/LS.Terraform/environments/dev/ls_framework_main.tf) | Terraform | 193 | 7 | 25 | 225 |
| [LS.Infrastructure/LS.Terraform/environments/dev/terraform.tfvars](/LS.Infrastructure/LS.Terraform/environments/dev/terraform.tfvars) | terraform-vars | 0 | 0 | 1 | 1 |
| [LS.Infrastructure/LS.Terraform/environments/dev/variables.tf](/LS.Infrastructure/LS.Terraform/environments/dev/variables.tf) | Terraform | 16 | 0 | 2 | 18 |
| [LS.Infrastructure/LS.Terraform/global/ecr/ecr\_repo.tf](/LS.Infrastructure/LS.Terraform/global/ecr/ecr_repo.tf) | Terraform | 10 | 2 | 4 | 16 |
| [LS.Infrastructure/LS.Terraform/global/ecr/output.tf](/LS.Infrastructure/LS.Terraform/global/ecr/output.tf) | Terraform | 3 | 0 | 2 | 5 |
| [LS.Infrastructure/LS.Terraform/global/ecr/variables.tf](/LS.Infrastructure/LS.Terraform/global/ecr/variables.tf) | Terraform | 12 | 0 | 2 | 14 |
| [LS.Infrastructure/LS.Terraform/modules/data/db\_sg.tf](/LS.Infrastructure/LS.Terraform/modules/data/db_sg.tf) | Terraform | 23 | 11 | 8 | 42 |
| [LS.Infrastructure/LS.Terraform/modules/data/outputs.tf](/LS.Infrastructure/LS.Terraform/modules/data/outputs.tf) | Terraform | 18 | 0 | 6 | 24 |
| [LS.Infrastructure/LS.Terraform/modules/data/rds.tf](/LS.Infrastructure/LS.Terraform/modules/data/rds.tf) | Terraform | 38 | 1 | 6 | 45 |
| [LS.Infrastructure/LS.Terraform/modules/data/s3\_buckets.tf](/LS.Infrastructure/LS.Terraform/modules/data/s3_buckets.tf) | Terraform | 106 | 13 | 23 | 142 |
| [LS.Infrastructure/LS.Terraform/modules/data/secrets.tf](/LS.Infrastructure/LS.Terraform/modules/data/secrets.tf) | Terraform | 17 | 3 | 5 | 25 |
| [LS.Infrastructure/LS.Terraform/modules/data/variables.tf](/LS.Infrastructure/LS.Terraform/modules/data/variables.tf) | Terraform | 38 | 1 | 7 | 46 |
| [LS.Infrastructure/LS.Terraform/modules/dns\_routing/certificate\_manager.tf](/LS.Infrastructure/LS.Terraform/modules/dns_routing/certificate_manager.tf) | Terraform | 22 | 1 | 6 | 29 |
| [LS.Infrastructure/LS.Terraform/modules/dns\_routing/cloudfront.tf](/LS.Infrastructure/LS.Terraform/modules/dns_routing/cloudfront.tf) | Terraform | 70 | 9 | 16 | 95 |
| [LS.Infrastructure/LS.Terraform/modules/dns\_routing/outputs.tf](/LS.Infrastructure/LS.Terraform/modules/dns_routing/outputs.tf) | Terraform | 6 | 0 | 3 | 9 |
| [LS.Infrastructure/LS.Terraform/modules/dns\_routing/route53\_public.tf.tf](/LS.Infrastructure/LS.Terraform/modules/dns_routing/route53_public.tf.tf) | Terraform | 13 | 2 | 5 | 20 |
| [LS.Infrastructure/LS.Terraform/modules/dns\_routing/variables.tf](/LS.Infrastructure/LS.Terraform/modules/dns_routing/variables.tf) | Terraform | 20 | 0 | 4 | 24 |
| [LS.Infrastructure/LS.Terraform/modules/ls\_framework\_core/alb.tf](/LS.Infrastructure/LS.Terraform/modules/ls_framework_core/alb.tf) | Terraform | 55 | 5 | 20 | 80 |
| [LS.Infrastructure/LS.Terraform/modules/ls\_framework\_core/cloudwatch.tf](/LS.Infrastructure/LS.Terraform/modules/ls_framework_core/cloudwatch.tf) | Terraform | 7 | 1 | 2 | 10 |
| [LS.Infrastructure/LS.Terraform/modules/ls\_framework\_core/ecs\_cluster.tf](/LS.Infrastructure/LS.Terraform/modules/ls_framework_core/ecs_cluster.tf) | Terraform | 10 | 0 | 3 | 13 |
| [LS.Infrastructure/LS.Terraform/modules/ls\_framework\_core/ecs\_service.tf](/LS.Infrastructure/LS.Terraform/modules/ls_framework_core/ecs_service.tf) | Terraform | 26 | 2 | 9 | 37 |
| [LS.Infrastructure/LS.Terraform/modules/ls\_framework\_core/ecs\_task\_definition.tf](/LS.Infrastructure/LS.Terraform/modules/ls_framework_core/ecs_task_definition.tf) | Terraform | 32 | 2 | 8 | 42 |
| [LS.Infrastructure/LS.Terraform/modules/ls\_framework\_core/iam\_roles.tf](/LS.Infrastructure/LS.Terraform/modules/ls_framework_core/iam_roles.tf) | Terraform | 36 | 4 | 8 | 48 |
| [LS.Infrastructure/LS.Terraform/modules/ls\_framework\_core/ls\_framework\_sg.tf](/LS.Infrastructure/LS.Terraform/modules/ls_framework_core/ls_framework_sg.tf) | Terraform | 60 | 7 | 19 | 86 |
| [LS.Infrastructure/LS.Terraform/modules/ls\_framework\_core/output.tf](/LS.Infrastructure/LS.Terraform/modules/ls_framework_core/output.tf) | Terraform | 21 | 0 | 6 | 27 |
| [LS.Infrastructure/LS.Terraform/modules/ls\_framework\_core/route53\_private.tf](/LS.Infrastructure/LS.Terraform/modules/ls_framework_core/route53_private.tf) | Terraform | 10 | 0 | 3 | 13 |
| [LS.Infrastructure/LS.Terraform/modules/ls\_framework\_core/variables.tf](/LS.Infrastructure/LS.Terraform/modules/ls_framework_core/variables.tf) | Terraform | 56 | 5 | 6 | 67 |
| [LS.Infrastructure/LS.Terraform/modules/network/endpoint\_sg.tf](/LS.Infrastructure/LS.Terraform/modules/network/endpoint_sg.tf) | Terraform | 29 | 3 | 6 | 38 |
| [LS.Infrastructure/LS.Terraform/modules/network/gateways.tf](/LS.Infrastructure/LS.Terraform/modules/network/gateways.tf) | Terraform | 20 | 4 | 6 | 30 |
| [LS.Infrastructure/LS.Terraform/modules/network/outputs.tf](/LS.Infrastructure/LS.Terraform/modules/network/outputs.tf) | Terraform | 30 | 0 | 4 | 34 |
| [LS.Infrastructure/LS.Terraform/modules/network/routing.tf](/LS.Infrastructure/LS.Terraform/modules/network/routing.tf) | Terraform | 69 | 14 | 21 | 104 |
| [LS.Infrastructure/LS.Terraform/modules/network/subnets.tf](/LS.Infrastructure/LS.Terraform/modules/network/subnets.tf) | Terraform | 84 | 11 | 24 | 119 |
| [LS.Infrastructure/LS.Terraform/modules/network/variables.tf](/LS.Infrastructure/LS.Terraform/modules/network/variables.tf) | Terraform | 32 | 3 | 6 | 41 |
| [LS.Infrastructure/LS.Terraform/modules/network/vpc\_endpoints.tf](/LS.Infrastructure/LS.Terraform/modules/network/vpc_endpoints.tf) | Terraform | 72 | 5 | 32 | 109 |
| [LS.Infrastructure/LS.Terraform/modules/network/vpc\_main.tf](/LS.Infrastructure/LS.Terraform/modules/network/vpc_main.tf) | Terraform | 8 | 3 | 5 | 16 |
| [LS.Infrastructure/LS.Terraform/modules/security/iam\_global.tf](/LS.Infrastructure/LS.Terraform/modules/security/iam_global.tf) | Terraform | 79 | 23 | 34 | 136 |
| [LS.Infrastructure/LS.Terraform/modules/security/kms.tf](/LS.Infrastructure/LS.Terraform/modules/security/kms.tf) | Terraform | 9 | 0 | 2 | 11 |
| [LS.Infrastructure/LS.Terraform/modules/security/outputs.tf](/LS.Infrastructure/LS.Terraform/modules/security/outputs.tf) | Terraform | 3 | 0 | 1 | 4 |
| [LS.Infrastructure/LS.Terraform/modules/security/variables.tf](/LS.Infrastructure/LS.Terraform/modules/security/variables.tf) | Terraform | 8 | 0 | 0 | 8 |
| [LS.Infrastructure/LS.Terraform/provider.tf](/LS.Infrastructure/LS.Terraform/provider.tf) | Terraform | 12 | 15 | 3 | 30 |

[Summary](results.md) / Details / [Diff Summary](diff.md) / [Diff Details](diff-details.md)