# Telegram Bot Setup 🤖

To use this project, you need a Telegram Bot. Here is how to create one.

## 1. Create the Bot

1.  Open Telegram and search for **@BotFather**.
2.  Click **Start**.
3.  Send the command `/newbot`.
4.  Follow the prompts:
    *   **Name**: Choose a display name (e.g., "My Deploy Bot").
    *   **Username**: Choose a unique username ending in `bot` (e.g., `my_deploy_site_bot`).
5.  BotFather will give you a **HTTP API Token**.
    *   It looks like: `123456789:ABCdefGHIjklMNOpqrsTUVwxyz`.
    *   **Copy this token**. You will need it for `terraform.tfvars`.

## 2. Get Your Username

1.  Open your Telegram Settings.
2.  Look for your **Username** (e.g., `@johndoe`).
3.  If you don't have one, set one up.
4.  You will use this (without the `@`) in `terraform.tfvars` as `telegram_username`.

## 3. (Optional) Set Bot Commands

To make your bot look professional, you can set commands in BotFather:
1.  Send `/setcommands`.
2.  Select your bot.
3.  Send the list of commands:
    ```
    deploy - Trigger the deployment workflow
    status - Check system status (if implemented)
    ```
