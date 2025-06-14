# AWS ECS Fargate Sample App Deployment

This Terraform project deploys a containerized sample application on AWS ECS Fargate with a modular infrastructure setup. The infrastructure includes a VPC with public and private subnets across two availability zones, an Application Load Balancer (ALB), an S3 bucket for static assets, an ECR repository for the container image, and necessary IAM roles.

## Project Structure

```
ecs-sample-app/
├── main.tf               # Root module orchestrating all resources
├── variables.tf          # Input variable definitions
├── outputs.tf            # Output definitions
├── terraform.tfvars      # Variable values for deployment
├── modules/
│   ├── vpc/              # VPC, subnets, NAT Gateway, and routing
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── s3/               # S3 bucket for static assets
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── ecr/              # ECR repository for container images
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── ecs/              # ECS cluster, task definition, and service
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── alb/              # Application Load Balancer and related resources
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── iam/              # IAM roles and policies
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
```

## Infrastructure Components

- **VPC**: A VPC with public and private subnets across two AZs, an Internet Gateway, and a NAT Gateway for outbound internet access.
- **ECR**: An Elastic Container Registry repository to store the container image.
- **ECS**: An ECS Fargate cluster running the sample app, using an image from the ECR repository.
- **ALB**: An Application Load Balancer to route traffic to the ECS service.
- **S3**: A public-read S3 bucket for storing static assets.
- **IAM**: Roles and policies for ECS task execution, with permissions to access S3 and pull images from ECR.

## Prerequisites

- **Terraform**: Version 1.5 or later.
- **AWS CLI**: Configured with appropriate credentials (`~/.aws/credentials` or environment variables).
- **Docker**: Installed for building and pushing the container image to ECR.
- **AWS Account**: With permissions to create VPC, ECS, ALB, S3, ECR, and IAM resources.

## Setup Instructions

1. **Clone the Repository**:
   ```bash
   git clone <repository-url>
   cd <folder-name>
   ```

2. **Configure Variables**:
  - The `variables.tf` and `terraform.tfvars` files serve distinct but complementary purposes in a Terraform project:
  - `variables.tf`: This file defines the variables used in your Terraform configuration. It specifies the variable names, types, descriptions, and optionally default values. It acts as a blueprint for the input parameters your configuration expects.
  - `terraform.tfvars`: This file provides values for the variables defined in variables.tf. It allows you to set specific values for those variables without hardcoding them in the configuration files, making it easier to customize deployments for different environments or use cases.
   - If all variables in `variables.tf` have default values and those defaults are suitable for your use case, you might not need a `terraform.tfvars` file.
   - Edit `terraform.tfvars` to customize values (e.g., `region`, `ecr_repository_name`, `bucket_prefix`).
   - Example `terraform.tfvars`:
     ```hcl
     region             = "us-east-1"
     vpc_cidr           = "10.0.0.0/16"
     public_subnet_cidrs = ["10.0.0.0/24", "10.0.1.0/24"]
     private_subnet_cidrs = ["10.0.2.0/24", "10.0.3.0/24"]
     azs                = ["us-east-1a", "us-east-1b"]
     bucket_prefix      = "ecs-sample-app-static"
     ecr_repository_name = "sample-app-repo"
     ```

3. **Initialize Terraform**:
   ```bash
   terraform init
   ```

4. **Push Container Image to ECR**:
   - Apply the Terraform configuration to create the ECR repository:
     ```bash
     terraform apply -target=module.ecr
     ```
   - Get the ECR repository URL from the Terraform output or AWS console.
   - Authenticate Docker with ECR:
     ```bash
     aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin <account-id>.dkr.ecr.us-east-1.amazonaws.com
     ```
   - Build and tag your Docker image:
     ```bash
     docker build -t <account-id>.dkr.ecr.us-east-1.amazonaws.com/sample-app-repo:latest .
     ```
   - Push the image to ECR:
     ```bash
     docker push <account-id>.dkr.ecr.us-east-1.amazonaws.com/sample-app-repo:latest
     ```

5. **Deploy Infrastructure**:
   ```bash
   terraform apply
   ```
   - Confirm the changes when prompted.
   - Note the outputs: `alb_dns_name` (for accessing the app) and `s3_bucket_name` (for uploading static assets).

6. **Upload Static Assets**:
   - Use the AWS CLI or console to upload assets to the S3 bucket:
     ```bash
     aws s3 cp <local-path> s3://<s3-bucket-name>/ --recursive
     ```

7. **Access the Application**:
   - Open the `alb_dns_name` in a browser to access the deployed app.

## Outputs

- `alb_dns_name`: DNS name of the Application Load Balancer.
- `s3_bucket_name`: Name of the S3 bucket for static assets.

## Cleanup

- Manually delete any objects in the S3 bucket and imanges from ECR before destroying to avoid errors.
- To destroy the infrastructure:
    ```bash
terraform destroy
    ```
- Confirm the destruction when prompted.


## Troubleshooting

- **ECS Service Fails**: Check if the ECR image is available and the IAM role has correct permissions.
- **ALB Returns 502**: Verify the ECS task is running and the health check path (`/`) is correct.
- **Terraform Errors**: Ensure AWS credentials are valid and the region supports all resources.

For issues, refer to the AWS console logs (CloudWatch, ECS, ALB) or open an issue in the repository.