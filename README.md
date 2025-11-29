# AWS ChatOps Static Site 🚀

**Deploy your website by texting a Telegram Bot.**

This project sets up a professional, serverless static website hosting platform on AWS. It features a "ChatOps" deployment workflow where you can trigger updates simply by sending a message to your private Telegram bot.

## Features

-   **Global Hosting**: S3 Bucket + CloudFront CDN for lightning-fast load times.
-   **ChatOps Deployment**: Trigger GitHub Actions workflows via a secure Telegram Bot.
-   **Secure**: OIDC authentication for GitHub (no keys stored), and username-based authorization for the bot.
-   **HTTPS**: Free, auto-renewing SSL certificate via AWS ACM.
-   **Zero Maintenance**: 100% serverless architecture.
-   **Low Cost**: Estimated < $1.00/month for low-traffic sites (mostly Route 53 fees).

## Architecture

![Architecture](https://img.shields.io/badge/Architecture-Serverless-blue)

1.  **Hosting**: AWS S3 (Storage) + CloudFront (CDN).
2.  **DNS**: AWS Route 53 + ACM (SSL).
3.  **Bot**: AWS Lambda (Node.js) + Function URL (Webhook).
4.  **CI/CD**: GitHub Actions (triggered via API).

## Quick Start

1.  **Clone this repo**.
2.  **Copy** `terraform.tfvars.example` to `terraform.tfvars`.
3.  **Fill in** your domain, tokens, and username.
4.  **Run** `terraform apply`.
5.  **Set** the Telegram Webhook.

👉 **[Read the Full Setup Guide](docs/SETUP.md)**

## Documentation

-   [🛠️ Setup Guide](docs/SETUP.md) - Step-by-step instructions.
-   [🤖 Telegram Bot Setup](docs/TELEGRAM_BOT.md) - How to get your bot token.
-   [🏗️ Architecture Details](docs/ARCHITECTURE.md) - Deep dive into the tech stack.

## Cost Estimate

-   **Route 53**: $0.50 / month per hosted zone.
-   **S3 & CloudFront**: Free Tier eligible (pennies for low traffic).
-   **Lambda**: Free Tier eligible (virtually free for this use case).

## License

MIT
