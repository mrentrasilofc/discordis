local class = {}
class.__index = class
local _cache = {}

function class:iter()
    return function()
        return ipairs(_cache[self.name])
    end
end

function class:set(id, value)
    local last = _cache[self.name][id]
    _cache[self.name][id] = value

    return last
end

function class:get(id)
    return _cache[self.name][id]
end

function class.new(name)
    local self = setmetatable({}, class)
    local c = _cache[name]
    if not c then
        _cache[name] = {}
    end
    
    self.name = name

    return self
end

return class