data "archive_file" "telegram_bot_zip" {
  type        = "zip"
  source_dir  = "${path.module}/lambda/telegram_bot"
  output_path = "${path.module}/lambda/telegram_bot.zip"
}

resource "aws_iam_role" "telegram_bot_lambda_role" {
  name = "telegram_bot_lambda_role_${replace(var.domain_name, ".", "_")}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "telegram_bot_lambda_basic_execution" {
  role       = aws_iam_role.telegram_bot_lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_function" "telegram_bot" {
  filename         = data.archive_file.telegram_bot_zip.output_path
  function_name    = "telegram_bot_trigger_${replace(var.domain_name, ".", "_")}"
  role             = aws_iam_role.telegram_bot_lambda_role.arn
  handler          = "index.handler"
  source_code_hash = data.archive_file.telegram_bot_zip.output_base64sha256
  runtime          = "nodejs20.x"
  timeout          = 10

  environment {
    variables = {
      TELEGRAM_BOT_TOKEN = var.telegram_bot_token
      TELEGRAM_USERNAME  = var.telegram_username
      GITHUB_TOKEN       = var.github_token
      GITHUB_REPO        = var.github_repo
    }
  }
}

resource "aws_lambda_function_url" "telegram_bot_url" {
  function_name      = aws_lambda_function.telegram_bot.function_name
  authorization_type = "NONE"
}

output "telegram_bot_function_url" {
  value = aws_lambda_function_url.telegram_bot_url.function_url
}

resource "null_resource" "set_telegram_webhook" {
  triggers = {
    function_url = aws_lambda_function_url.telegram_bot_url.function_url
    bot_token    = var.telegram_bot_token
  }

  provisioner "local-exec" {
    command = "curl -F 'url=${aws_lambda_function_url.telegram_bot_url.function_url}' https://api.telegram.org/bot${var.telegram_bot_token}/setWebhook"
  }
}
