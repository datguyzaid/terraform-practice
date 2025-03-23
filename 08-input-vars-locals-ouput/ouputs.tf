output "s3_bucket_name" {
  value = aws_s3_bucket.project_bucket.bucket
  sensitive = true
  description = "The S3 bucket name"
}

output "sensitive_var" {
  value = var.my_sensitive_value
}