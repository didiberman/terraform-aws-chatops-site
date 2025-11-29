output "website_url" {
  value       = "https://${var.domain_name}"
  description = "The URL of your deployed website"
}

output "cloudfront_distribution_id" {
  value       = aws_cloudfront_distribution.website.id
  description = "The ID of the CloudFront distribution (needed for GitHub Actions)"
}

output "s3_bucket_name" {
  value       = aws_s3_bucket.website.id
  description = "The name of the S3 bucket (needed for GitHub Actions)"
}

output "telegram_bot_webhook_url" {
  value       = aws_lambda_function_url.telegram_bot_url.function_url
  description = "URL to set as the Telegram Bot Webhook"
}

output "nameservers" {
  value       = aws_route53_zone.main.name_servers
  description = "Route 53 Nameservers. Update your domain registrar with these."
}

output "github_role_arn" {
  value       = aws_iam_role.github_deploy.arn
  description = "The ARN of the IAM Role for GitHub Actions (needed for GitHub Secrets)"
}
