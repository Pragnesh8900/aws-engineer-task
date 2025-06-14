output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = module.alb.alb_dns_name
}

output "s3_bucket_name" {
  description = "Name of the S3 bucket for static assets"
  value       = module.s3.bucket_name
}