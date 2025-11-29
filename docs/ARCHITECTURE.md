# Architecture Overview 🏗️

This project uses a **Serverless** architecture on AWS.

## Components

### 1. Hosting Layer (S3 + CloudFront)
*   **AWS S3**: Stores the static assets (HTML, CSS, JS, Images). Configured as a private bucket.
*   **AWS CloudFront**: A global Content Delivery Network (CDN). It caches content at the edge, close to users. It also handles SSL termination.
*   **Security**: Access to S3 is restricted to CloudFront only via **Origin Access Control (OAC)**.

### 2. DNS Layer (Route 53 + ACM)
*   **AWS Route 53**: Managed DNS service. Handles the hosted zone and routing to CloudFront.
*   **AWS ACM**: Certificate Manager. Provisions a free public SSL certificate. Validation is automated via Route 53 DNS records.

### 3. ChatOps Layer (Lambda + Telegram)
*   **AWS Lambda**: A Node.js function that acts as the backend logic.
*   **Function URL**: A public HTTPS endpoint for the Lambda function, used as the Telegram Webhook.
*   **Logic**:
    1.  Receives JSON payload from Telegram.
    2.  Verifies the sender's **Username** matches the authorized user.
    3.  Sends an immediate reply to Telegram.
    4.  Calls the GitHub API to trigger a `workflow_dispatch` event.

### 4. CI/CD Layer (GitHub Actions)
*   **OIDC (OpenID Connect)**: A secure trust relationship between GitHub and AWS.
*   **IAM Role**: A specific role that GitHub Actions assumes. It has permission *only* to:
    *   Upload files to the specific S3 bucket.
    *   Invalidate the specific CloudFront distribution.
*   **Workflow**: The GitHub Action builds the site and uses the AWS CLI to sync files and invalidate cache.
