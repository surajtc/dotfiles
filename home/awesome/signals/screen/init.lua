local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")

local vars = require("config.vars")
local widgets = require("widgets")

-- Wallpaper
screen.connect_signal("request::wallpaper", function(s)
    awful.wallpaper {
        screen = s,
        bg = beautiful.colors.base01,
        widget = {
            {
                image = beautiful.wallpaper,
                upscale = true,
                downscale = true,
                widget = wibox.widget.imagebox
            },
            valign = "center",
            halign = "center",
            tiled = false,
            widget = wibox.container.tile
        }
    }
end)

-- Desktop decoration
screen.connect_signal("request::desktop_decoration", function(s)
    awful.tag(vars.tags, s, awful.layout.layouts[1])

    s.promptbox = widgets.create_promptbox()
    s.layoutbox = widgets.create_layoutbox()
    s.taglist = widgets.create_taglist(s)
    s.tasklist = widgets.create_tasklist(s)
    s.wibox = widgets.create_wibox(s)
end)
