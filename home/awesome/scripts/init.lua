local awful = require("awful")
local gears = require("gears")

local autorun = gears.filesystem.get_xdg_config_home() .. "awesome/scripts/autorun.sh"

awful.spawn.with_shell(autorun)

