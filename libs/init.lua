--[[lit-meta
	name = "mrentrasilofc/discordis"
	version = "0.0.1"
	homepage = "https://github.com/mrentrasilofc/discordis"
	description = "A simple discord wrapper written in lua"
	license = "MIT"
]]

return {
	cache = require "./utils/cache",
	client = require "./class/client"
}
