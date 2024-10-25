
local awful = require("awful")

local vars = require("config.vars")

-- Tag layouts
tag.connect_signal("request::default_layouts", function()
    awful.layout.append_default_layouts(vars.layouts)
end)