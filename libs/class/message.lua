local json = require "json"
local request = require "../utils/request"
local endp = require "../endpoints"
local cache = require "../utils/cache"
local channel = require "./channel"
local class = {}
class.__index = class

function class.new(channel_id, object, use_cache, token)
    local message_cache = cache.new("message"):get(object.id)
    if message_cache and use_cache then return message_cache end
    
    local self = setmetatable(object, class)
    self.channel = channel.new(channel_id, true)

    self._headers = {
        {"Authorization", ("Bot %s"):format(token)},
        {"Content-Type", "Application/json"}
    }

    return self
end

function class:reply(content)
    coroutine.wrap(function()
        local result = {
            content = content
        }

        if type(content) == "table" then
            result = content
        end

        request("POST", (endp.MESSAGES):format(self.channel.id, self.id), self._headers, json.stringify(result))
    end)()
end

return class