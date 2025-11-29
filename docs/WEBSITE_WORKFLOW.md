# Website Repository Workflow ⚙️

To deploy your website automatically, you need to add a GitHub Actions workflow to **your website's repository** (not this Terraform repository).

## 1. Create the Workflow File

In your website's repository, create a new file at this path:
`.github/workflows/deploy.yml`

## 2. Copy the Content

Paste the following YAML content into that file:

```yaml
name: Deploy Website

on:
  push:
    branches:
      - main
  workflow_dispatch:

permissions:
  id-token: write
  contents: read

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '20'
          cache: 'npm'

      - name: Install Dependencies
        run: npm ci

      - name: Build Site
        run: npm run build

      - name: Configure AWS credentials
        uses: aws-actions/configure-aws-credentials@v4
        with:
          role-to-assume: ${{ secrets.AWS_ROLE_ARN }}
          aws-region: us-east-1

      - name: Sync files to S3
        run: |
          aws s3 sync ./dist s3://${{ secrets.AWS_S3_BUCKET }} --delete --exclude ".git/*"

      - name: Invalidate CloudFront cache
        run: |
          aws cloudfront create-invalidation --distribution-id ${{ secrets.CLOUDFRONT_DISTRIBUTION_ID }} --paths "/*"
```

## 3. Important Notes

-   **Build Command**: This workflow assumes your site uses `npm run build` to create a `dist` folder. If your site uses a different build command or output folder (e.g., `build` or `public`), update the "Build Site" and "Sync files to S3" steps accordingly.
-   **Secrets**: Ensure you have added the necessary secrets (`AWS_ROLE_ARN`, `AWS_S3_BUCKET`, `CLOUDFRONT_DISTRIBUTION_ID`) to your repository settings as described in the [Setup Guide](SETUP.md).
