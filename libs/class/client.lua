local ws = require"../client/ws"
local emitter = require"../utils/emitter":get("client")
local class = {}
class.__index = class

function class.new(token)
    local self = setmetatable({}, class)
    assert(token, debug.traceback("token needed!"))

    self.onReceive = emitter.on
    self.token = token
    return self
end

function class:login(status)
    if not status then status = "online" end
    ws:run(self.token, status)
end

return class