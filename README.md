# AWS ChatOps Static Site 🚀

**The Smartest, Cheapest Way to Host Your Website.**

This project isn't just about hosting a website; it's about giving you a **professional-grade web presence** for practically **zero cost**, with the power to update it just by sending a text message.

## Why is this "Smart"? 🧠

### 1. It's Virtually Free (AWS Free Tier Power) 💸
Most hosting services charge you $5-20/month just to keep a site online. This project uses **AWS Serverless** technology, which means you only pay for what you use.
-   **Hosting**: Uses AWS S3 & CloudFront. If you have low traffic (like a personal portfolio or small business site), this is often **completely free** under the AWS Free Tier.
-   **SSL Certificate**: Secure HTTPS (the lock icon in the browser) is **free** and auto-renewing.
-   **The Bot**: The "brain" that updates your site runs on AWS Lambda, which gives you **400,000 GB-seconds of compute time per month for free**. You will likely never pay a cent for this.
-   **Real Cost**: You mostly only pay for the domain name (Route 53), which is about **$0.50/month**.

### 2. "Text-to-Deploy" Simplicity 📱
You don't need to be a coder to update your site.
-   **The Old Way**: Open laptop -> Open terminal -> Run complex commands -> Wait -> Hope it works.
-   **The Smart Way**: Open Telegram on your phone -> Send a message to your private bot -> **Done**.
Your site updates automatically in seconds. It's like having a personal assistant for your website.

### 3. Professional Speed & Security ⚡
Even though it's cheap, it's **enterprise-grade**.
-   **Global Speed**: Your site is distributed worldwide via a Content Delivery Network (CDN). A user in Tokyo loads your site as fast as a user in New York.
-   **Secure**: It uses banking-grade security standards (OIDC, HTTPS) without you needing to configure them.

### 4. AI-Ready (Bolt.new / Lovable.dev) 🤖
You can use powerful AI website builders like **Bolt.new** or **Lovable.dev** to create your site.
-   **The Problem**: These tools are amazing for building, but they often charge you monthly fees to *host* the site with them.
-   **The Solution**:
    1.  Build your site with AI.
    2.  Export the code to your GitHub repository.
    3.  Text your Telegram bot to deploy.
-   **The Result**: You get the power of AI creation without the recurring hosting fees. You own the code, and you host it for free on AWS.

---

## How It Works (Simplified)

1.  **You** send a message to your Telegram Bot.
2.  **The Bot** (AWS Lambda) wakes up, checks it's really you, and tells GitHub to start working.
3.  **GitHub** builds your website and pushes the new files to AWS.
4.  **AWS** updates your live site instantly.

## Features

-   **Global Hosting**: Lightning-fast load times everywhere.
-   **ChatOps Deployment**: Update your site from your phone.
-   **Secure**: Enterprise-level security built-in.
-   **HTTPS**: Free, secure connection.
-   **Zero Maintenance**: No servers to manage, patch, or restart. Ever.

## Quick Start

1.  **Clone this repo**.
2.  **Copy** `terraform.tfvars.example` to `terraform.tfvars`.
3.  **Fill in** your domain, tokens, and username.
4.  **Run** `terraform apply`.
5.  **Set** the Telegram Webhook.
6.  **Add** the [Deployment Workflow](docs/WEBSITE_WORKFLOW.md) to your website repo.

👉 **[Read the Full Setup Guide](docs/SETUP.md)**

## Documentation

-   [🛠️ Setup Guide](docs/SETUP.md) - Step-by-step instructions.
-   [🤖 Telegram Bot Setup](docs/TELEGRAM_BOT.md) - How to get your bot token.
-   [🏗️ Architecture Details](docs/ARCHITECTURE.md) - Deep dive into the tech stack.

## License

MIT
