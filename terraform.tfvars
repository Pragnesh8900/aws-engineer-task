region             = "us-east-1"
vpc_cidr           = "100.0.0.0/16"
public_subnet_cidrs = ["100.0.0.0/24", "100.0.1.0/24"]
private_subnet_cidrs = ["100.0.2.0/24", "100.0.3.0/24"]
azs                = ["us-east-1a", "us-east-1b"]
bucket_prefix      = "ecs-app-sample"
ecr_repository_name = "sample-app-repo"