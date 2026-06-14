
output "ls_framework_vpc_id" {
  value = aws_vpc.ls_framework_vpc.id
}
output "ls_framework_vpc_cidr_block" {
  value = aws_vpc.ls_framework_vpc.cidr_block
}

output "ls_framework_public_subnets" {
  value = [
    aws_subnet.ls_framework_public_subnet_a.id,
    aws_subnet.ls_framework_public_subnet_b.id,
    aws_subnet.ls_framework_public_subnet_c.id
  ]
}
output "ls_framework_private_subnets" {
  value = [
    aws_subnet.ls_framework_private_subnet_a.id,
    aws_subnet.ls_framework_private_subnet_b.id,
    aws_subnet.ls_framework_private_subnet_c.id
  ]
}

output "ls_framework_private_db_subnets" {
  value = [
    aws_subnet.ls_framework_private_db_subnet_a.id,
    aws_subnet.ls_framework_private_db_subnet_b.id,
    aws_subnet.ls_framework_private_db_subnet_c.id
  ]
}

output "ls_framework_db_subnet_group_name" {
  value = aws_db_subnet_group.ls_framework_sqlserver_db_subnet_group.name
}