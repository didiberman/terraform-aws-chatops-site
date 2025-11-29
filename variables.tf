variable "aws_region" {
  description = "AWS Region to deploy resources (e.g., us-east-1)"
  type        = string
  default     = "us-east-1"
}

variable "domain_name" {
  description = "The domain name for the website (e.g., example.com)"
  type        = string
}

variable "github_repo" {
  description = "The GitHub repository in format 'owner/repo' that will deploy to this infrastructure"
  type        = string
}

variable "telegram_bot_token" {
  description = "Telegram Bot Token from BotFather"
  type        = string
  sensitive   = true
}

variable "telegram_username" {
  description = "Authorized Telegram Username (without @) allowed to trigger deployments"
  type        = string
}

variable "github_token" {
  description = "GitHub Personal Access Token (classic) with 'repo' scope for triggering workflows"
  type        = string
  sensitive   = true
}
