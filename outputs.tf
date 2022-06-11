output "bucket_dns" {
  description = "Public DNS of the created bucket"
  value       = aws_s3_bucket.terraform_state.*.bucket_domain_name
}