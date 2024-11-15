local discordis = require "../libs/init"
local secrets = require "../secrets"
----------------------------------------------
local bot = discordis.client.new(secrets.token_key)
bot.onReceive("messageCreate", function(message)
    print(message.author.username..": "..message.content)
end)
bot:login()