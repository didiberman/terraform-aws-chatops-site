# Setup Guide 🛠️

Follow these steps to deploy your own ChatOps website platform.

## Prerequisites

1.  **AWS Account**: You need an active AWS account.
2.  **Terraform**: Installed on your machine ([Install Guide](https://developer.hashicorp.com/terraform/downloads)).
3.  **Domain Name**: You must own a domain name (e.g., `example.com`).
4.  **GitHub Repository**: A repository containing your website code. You must add the **[Deployment Workflow](WEBSITE_WORKFLOW.md)** to this repo.

## Step 0: Authenticate with AWS 🔑

Before running Terraform, you must authenticate with your AWS account.

1.  **Install AWS CLI**: If you haven't already, [install the AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html).
2.  **Configure Credentials**: Run the following command and enter your Access Key ID and Secret Access Key:
    ```bash
    aws configure
    ```
3.  **Permissions**: Ensure your user has **AdministratorAccess**.
    *   *Why?* This project creates a wide range of resources (IAM Roles, CloudFront Distributions, S3 Buckets, Lambda Functions, Route 53 Zones). It is easiest to run this with Admin privileges.

## Step 1: Configure Terraform

1.  Navigate to the project directory:
    ```bash
    cd terraform-aws-chatops-site
    ```
2.  Create your secrets file:
    ```bash
    cp terraform.tfvars.example terraform.tfvars
    ```
3.  Open `terraform.tfvars` and fill in the values:
    *   `domain_name`: Your domain (e.g., `example.com`).
    *   `aws_region`: Target region (e.g., `us-east-1`).
    *   `github_repo`: Your repo (e.g., `johndoe/my-website`).
    *   `telegram_bot_token`: Get this from BotFather (see [Telegram Bot Setup](TELEGRAM_BOT.md)).
    *   `telegram_username`: **Your** Telegram username (without `@`). This is who the bot will listen to.
    *   `github_token`: A Personal Access Token (Classic) with `repo` scope.

## Step 2: Deploy Infrastructure

1.  Initialize Terraform:
    ```bash
    terraform init
    ```
2.  Review the plan:
    ```bash
    terraform plan
    ```
3.  Apply the configuration:
    ```bash
    terraform apply
    ```
    Type `yes` to confirm.

## Step 3: Final Configuration

### 1. Update Nameservers
Terraform will output a list of `nameservers` (e.g., `ns-123.awsdns-45.com`).
*   Go to your Domain Registrar (GoDaddy, Namecheap, etc.).
*   Update the Custom DNS / Nameservers to these 4 values.

### 2. Set Telegram Webhook
Terraform will output a `telegram_bot_webhook_url`. Run this command to connect your bot to the Lambda function:

```bash
# Replace with your actual values
curl -F "url=<YOUR_WEBHOOK_URL>" https://api.telegram.org/bot<YOUR_BOT_TOKEN>/setWebhook
```

### 3. Configure GitHub Secrets
Go to your GitHub Repository > Settings > Secrets and variables > Actions. Add the following secrets (values are in Terraform outputs):
*   `AWS_ROLE_ARN`: Value of `github_role_arn`.
*   `AWS_S3_BUCKET`: Value of `s3_bucket_name`.
*   `CLOUDFRONT_DISTRIBUTION_ID`: Value of `cloudfront_distribution_id`.

## Step 4: Test It! 🚀

1.  Open Telegram and find your bot.
2.  Send any message (e.g., "Deploy!").
3.  The bot should reply: "🚀 Deployment started, [Name]!".
4.  Check your GitHub Actions tab to see the workflow running.
