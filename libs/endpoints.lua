local base_url = "https://discord.com/api/v9"

return {
    CHANNEL = base_url.."/channels/%s",
    MESSAGES = base_url.."/channels/%s/messages",
    MESSAGE = base_url.."/channels/%s/messages/%s",
    USER = base_url.."/users/%s"
}