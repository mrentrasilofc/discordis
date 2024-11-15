--[[ // Class \\ ]]--
local message = require("../class/message")

--[[ // Require \\ ]]--
local timer = require("timer")
local json = require("json")
local ws = require("coro-websocket")
local emitter = require("../utils/emitter")
local logs = require("../utils/logs")

--[[ // Methods \\ ]]--
local module = {}
local client = emitter:get("client")

--[[ // Pre Fabs \\ ]]--
local payload = {
    op = 2,
    d = {
        intents = 513,
        properties = {
            os = "linux",
            browser = "discordis",
            device = "discordis"
        },
        presence = {
            activities = {},
            since = 91879201,
            afk = false
        }
    }
}

--[[ // Functions \\ ]]--
function module.ManageEvents(pd, token)
    local t = pd.t
    local d = pd.d

    if t == "MESSAGE_CREATE" then
        client.emit("messageCreate", message.new(d.channel_id, d, false, token))
    end
end

function module:ManageOP(pd, op, token, write)
    coroutine.wrap(function()
        local t = pd.t

        if op == 10 then
            print(logs.Received:format("HELLO"))
            if pd.op == 10 then
                local heartbeat_interval = pd.d.heartbeat_interval
                coroutine.wrap(function()
                    timer.setInterval(heartbeat_interval, function()
                        coroutine.wrap(function()
                            write({
                                opcode = 1,
                                payload = json.stringify({
                                    op = 1,
                                    d = nil
                                })
                            })
                        end)()
                    end)
                end)()

                write({
                    opcode = 2,
                    payload = json.stringify(payload)
                })
            end
        end

        if t then
            self.ManageEvents(pd, token)
        end
    end)()
end

function module:run(token, status)
    coroutine.wrap(function()
        payload.d.token = token
        payload.d.presence.status = status
        local res, read, write = ws.connect{
            port = 443,
            host = "gateway.discord.gg",
            path = "/?v=9&encoding=json",
            tls = true
        }

        for message in read do
            if not message then break end
            local pd = json.parse(message.payload)
            if not pd then break end

            self:ManageOP(pd, pd.op, token, write)
        end
    end)()
end

return module