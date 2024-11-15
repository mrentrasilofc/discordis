local cache = require "../utils/cache"
local class = {}
class.__index = class

function class.new(id, use_cache)
    local channel_cache = cache.new("channel"):get(id)
    if use_cache and channel_cache then return channel_cache end
    local self = setmetatable({}, class)

    self.id = id

    return self
end

return class