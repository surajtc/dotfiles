pcall(require, "luarocks.loader")

local gears = require("gears")
local beautiful = require("beautiful")

beautiful.init(gears.filesystem.get_xdg_config_home() .. "awesome/theme/init.lua")

require("bindings")
require("rules")
require("signals")
require("scripts")