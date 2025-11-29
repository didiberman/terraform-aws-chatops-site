import https from 'https';

export const handler = async (event) => {
    console.log('Received event:', JSON.stringify(event, null, 2));

    try {
        const body = JSON.parse(event.body);

        // Check if it's a message
        if (!body.message) {
            console.log('No message in body');
            return { statusCode: 200, body: 'OK' };
        }

        const chatId = body.message.chat.id;
        const username = body.message.from.username;
        const authorizedUsername = process.env.TELEGRAM_USERNAME;

        // Authorization Check (Case-insensitive)
        if (!username || username.toLowerCase() !== authorizedUsername.toLowerCase()) {
            console.warn(`Unauthorized access attempt by: ${username} (Chat ID: ${chatId})`);
            return { statusCode: 200, body: 'Unauthorized' };
        }

        console.log(`Authorized message from ${username} (Chat ID: ${chatId}). Triggering workflow...`);

        // Send reply to Telegram immediately
        const firstName = body.message.from.first_name || 'Friend';
        await sendTelegramMessage(chatId, `🚀 Deployment started, ${firstName}! 🤞\n\nSit back and relax while I handle the rest. 😎`);

        // Trigger GitHub Workflow
        await triggerGitHubWorkflow();

        return { statusCode: 200, body: 'Workflow triggered' };

    } catch (error) {
        console.error('Error:', error);
        return { statusCode: 500, body: 'Internal Server Error' };
    }
};

function triggerGitHubWorkflow() {
    return new Promise((resolve, reject) => {
        const data = JSON.stringify({
            ref: 'main',
        });

        const options = {
            hostname: 'api.github.com',
            path: `/repos/${process.env.GITHUB_REPO}/actions/workflows/deploy.yml/dispatches`,
            method: 'POST',
            headers: {
                'User-Agent': 'Lambda-Telegram-Bot',
                'Authorization': `Bearer ${process.env.GITHUB_TOKEN}`,
                'Accept': 'application/vnd.github.v3+json',
                'Content-Type': 'application/json',
                'Content-Length': data.length
            }
        };

        const req = https.request(options, (res) => {
            console.log(`GitHub API Status: ${res.statusCode}`);
            if (res.statusCode === 204) {
                resolve();
            } else {
                let responseBody = '';
                res.on('data', (chunk) => { responseBody += chunk; });
                res.on('end', () => {
                    console.error(`GitHub API Error: ${responseBody}`);
                    reject(new Error(`GitHub API returned ${res.statusCode}`));
                });
            }
        });

        req.on('error', (error) => {
            console.error('GitHub API Request Error:', error);
            reject(error);
        });

        req.write(data);
        req.end();
    });
}

function sendTelegramMessage(chatId, text) {
    return new Promise((resolve, reject) => {
        const data = JSON.stringify({
            chat_id: chatId,
            text: text
        });

        const options = {
            hostname: 'api.telegram.org',
            path: `/bot${process.env.TELEGRAM_BOT_TOKEN}/sendMessage`,
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'Content-Length': Buffer.byteLength(data)
            }
        };

        const req = https.request(options, (res) => {
            let responseBody = '';
            res.on('data', (chunk) => { responseBody += chunk; });
            res.on('end', () => {
                if (res.statusCode === 200) {
                    console.log('Telegram reply sent successfully');
                    resolve();
                } else {
                    console.error(`Telegram API Error: ${responseBody}`);
                    resolve();
                }
            });
        });

        req.on('error', (error) => {
            console.error('Telegram API Request Error:', error);
            resolve();
        });

        req.write(data);
        req.end();
    });
}
