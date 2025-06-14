provider "aws" {
  region = var.region
}

module "vpc" {
  source              = "./modules/vpc"
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidrs = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  azs                 = var.azs
}

module "s3" {
  source = "./modules/s3"
  bucket_prefix = var.bucket_prefix
}

module "ecr" {
  source = "./modules/ecr"
  repository_name = var.ecr_repository_name
}

module "iam" {
  source         = "./modules/iam"
  s3_bucket_arn  = module.s3.bucket_arn
  ecr_repository_arn = module.ecr.repository_arn
}

module "ecs" {
  source              = "./modules/ecs"
  vpc_id              = module.vpc.vpc_id
  private_subnet_ids  = module.vpc.private_subnet_ids
  alb_security_group_id = module.alb.security_group_id
  task_execution_role_arn = module.iam.ecs_task_execution_role_arn
  s3_bucket_name      = module.s3.bucket_name
  ecr_repository_url  = module.ecr.repository_url
  target_group_arn    = module.alb.target_group_arn
  alb_listener_arn    = module.alb.alb_listener_arn
}

module "alb" {
  source             = "./modules/alb"
  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = module.vpc.public_subnet_ids
  ecs_security_group_id = module.ecs.security_group_id
}