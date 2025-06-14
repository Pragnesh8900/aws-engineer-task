output "bucket_name" {
  value = aws_s3_bucket.static_assets.bucket
}

output "bucket_arn" {
  value = aws_s3_bucket.static_assets.arn
}