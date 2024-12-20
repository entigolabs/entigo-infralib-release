output "vpc_id" {
  value = module.vpc.vpc_id
}

output "private_subnets" {
  value = module.vpc.private_subnets
}

output "public_subnets" {
  value = module.vpc.public_subnets
}

output "intra_subnets" {
  value = module.vpc.intra_subnets
}

output "database_subnets" {
  value = module.vpc.database_subnets
}

output "database_subnet_group" {
  value = module.vpc.database_subnet_group
}

output "elasticache_subnets" {
  value = module.vpc.elasticache_subnets
}

output "elasticache_subnet_group" {
  value = module.vpc.elasticache_subnet_group
}

output "private_subnet_cidrs" {
  value = module.vpc.private_subnets_cidr_blocks
}

output "public_subnet_cidrs" {
  value = module.vpc.public_subnets_cidr_blocks
}

output "database_subnet_cidrs" {
  value = module.vpc.database_subnets_cidr_blocks
}

output "elasticache_subnet_cidrs" {
  value = module.vpc.elasticache_subnets_cidr_blocks
}

output "intra_subnet_cidrs" {
  value = module.vpc.intra_subnets_cidr_blocks
}

output "private_subnet_names" {
  value = var.private_subnet_names
}

output "public_subnet_names" {
  value = var.public_subnet_names
}

output "database_subnet_names" {
  value = var.database_subnet_names
}

output "elasticache_subnet_names" {
  value = var.elasticache_subnet_names
}

output "intra_subnet_names" {
  value = var.intra_subnet_names
}

output "intra_route_table_ids" {
  value = module.vpc.intra_route_table_ids
}

output "private_route_table_ids" {
  value = module.vpc.private_route_table_ids
}

output "public_route_table_ids" {
  value = module.vpc.public_route_table_ids
}

output "database_route_table_ids" {
  value = module.vpc.database_route_table_ids
}

output "elasticache_route_table_ids" {
  value = module.vpc.elasticache_route_table_ids
}

output "pipeline_security_group" {
  value = aws_security_group.pipeline_security_group.id
}
