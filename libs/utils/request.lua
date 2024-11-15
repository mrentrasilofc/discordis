local uv = require "uv"
local http = require "coro-http"

return function(method, url, headers, body)
    local data, body = http.request(method, url, headers, body)

    uv.run()
    uv.walk(uv.close)

    return data, body
end