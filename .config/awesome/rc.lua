-- Imports
pcall(require, "luarocks.loader")
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", 
        function (err)
            -- Avoid endless error loop
            if in_error then return end
            in_error = true
            naughty.notify({ preset = naughty.config.presets.critical,
                             title = "Error",
                             text = tostring(err) })
            in_error = false
        end)
end

-- Set theme
beautiful.init(gears.filesystem.get_configuration_dir() .. "themes/custom/theme.lua")
client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

-- Aliases for mod keys 
super = "Mod4"
alt = "Mod1"

-- Layouts
awful.layout.layouts = {
    awful.layout.suit.max,
    awful.layout.suit.tile,
    awful.layout.suit.floating,
}

-- Create textclock widget
textclock = wibox.widget.textclock(" %a %d-%b | %I:%M %p ")

-- Mouse bindings tag list
local taglist_buttons = gears.table.join(
    awful.button({ }, 1, function(t) t:view_only() end),
    awful.button({ super }, 1, 
        function(t)
            if client.focus then
                client.focus:move_to_tag(t)
            end
        end),
    awful.button({ }, 3, awful.tag.viewtoggle),
    awful.button({ super }, 3, 
        function(t)
            if client.focus then
                client.focus:toggle_tag(t)
            end
        end)
)

-- Mouse bindings task list
local tasklist_buttons = gears.table.join(
    awful.button({ }, 1, 
        function (c)
            c:emit_signal(
                "request::activate",
                "tasklist",
                {raise = true}
            )
        end)
)

-- Define function to set the wallpaper
local function set_wallpaper(s)
    gears.wallpaper.maximized(beautiful.wallpaper, s, true)
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

-- Initialize each screen
awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Set tags per screen
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

    -- Create layout indicator 
    s.layoutbox = awful.widget.layoutbox(s)
    s.layoutbox:buttons(gears.table.join(
        awful.button({ }, 1, function () awful.layout.inc( 1) end),
        awful.button({ }, 3, function () awful.layout.inc(-1) end),
        awful.button({ }, 4, function () awful.layout.inc( 1) end),
        awful.button({ }, 5, function () awful.layout.inc(-1) end)))

    -- Create a taglist widget
    s.taglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons
    }

    -- Create a tasklist widget
     s.tasklist = awful.widget.tasklist {
         screen  = s,
         filter  = awful.widget.tasklist.filter.currenttags,
         buttons = tasklist_buttons
    }

    -- Create the wibox
    s.wibox = awful.wibar({ position = "bottom", screen = s })

    -- Add widgets to the wibox
    s.wibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            s.taglist,
        },
        s.tasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            textclock,
            s.layoutbox,
        },
    }
end)

-- Global key bindings
globalkeys = gears.table.join(
    -- Change tag
    awful.key({ super }, "h",  awful.tag.viewprev),
    awful.key({ super }, "l", awful.tag.viewnext),

    -- Change client
    awful.key({ super }, "j", function () awful.client.focus.byidx( 1) end),
    awful.key({ super }, "k", function () awful.client.focus.byidx(-1) end),
    awful.key({ super          }, "Tab", function () awful.client.focus.byidx( 1) end),
    awful.key({ super, "Shift" }, "Tab", function () awful.client.focus.byidx(-1) end),
    
    -- Move client
    awful.key({ super, "Shift" }, "j", function () awful.client.swap.byidx( 1) end),
    awful.key({ super, "Shift" }, "k", function () awful.client.swap.byidx(-1) end),

    -- Reload and quit awesome 
    awful.key({ super }, "r", awesome.restart),
    awful.key({ super, "Control", alt  }, "q", awesome.quit),

    -- Change master width
    awful.key({ super }, "equal", function () awful.tag.incmwfact( 0.01) end),
    awful.key({ super }, "minus", function () awful.tag.incmwfact(-0.01) end),
    awful.key({ super, "Shift" }, "equal", function () awful.tag.incmwfact( 0.05) end),
    awful.key({ super, "Shift" }, "minus", function () awful.tag.incmwfact(-0.05) end),
    awful.key({ super }, "0", function () awful.tag.setmwfact(0.5) end),

    -- Change layout
    awful.key({ super }, "period", function () awful.layout.inc( 1) end),
    awful.key({ super }, "comma",  function () awful.layout.inc(-1) end),
    awful.key({ super }, "m", function () awful.layout.set(awful.layout.suit.max) end),
    awful.key({ super }, "t", function () awful.layout.set(awful.layout.suit.tile) end),
    awful.key({ super }, "f", function () awful.layout.set(awful.layout.suit.floating) end),

    -- Focus a next/previus screen
    awful.key({ super }, "n", function () awful.screen.focus_relative( 1) end),
    awful.key({ super }, "p", function () awful.screen.focus_relative(-1) end)
)

-- Client key bindings
clientkeys = gears.table.join(
    -- Close client
    awful.key({ super }, "q", function (c) c:kill() end),

    -- Move client to master
    awful.key({ super }, "Return", function (c) c:swap(awful.client.getmaster()) end),

    -- Send client to a next/previus screen
    awful.key({ super, "Shift" }, "n", 
        function (c) 
            c:move_to_screen(c.screen.index + 1)
            awful.screen.focus_relative(-1) 
        end),
    awful.key({ super, "Shift" }, "p", 
        function (c) 
            c:move_to_screen(c.screen.index - 1)
            awful.screen.focus_relative(1) 
        end)
)

-- Bind key numbers to tags
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- Move to worspace
        awful.key({ super }, tostring(i),
            function ()
                  local screen = awful.screen.focused()
                  local tag = screen.tags[i]
                  tag:view_only()
            end),

        -- Send client to tag
        awful.key({ super, "Shift" }, tostring(i),
            function ()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    client.focus:move_to_tag(tag)
               end
            end)
    )
end

-- Mouse bindings
clientbuttons = gears.table.join(
    awful.button({ }, 1, 
        function (c)
            c:emit_signal("request::activate", "mouse_click", { raise = true })
        end),
    awful.button({ super }, 1, 
        function (c)
            c:emit_signal("request::activate", "mouse_click", { raise = true })
            awful.mouse.client.move(c)
        end),
    awful.button({ super }, 3, 
        function (c)
            c:emit_signal("request::activate", "mouse_click", { raise = true })
            awful.mouse.client.resize(c)
        end)
)

-- Set global key bindings
root.keys(globalkeys)

-- Rules to apply to new clients
awful.rules.rules = {
    -- All clients will match this rule
    { 
         rule = { },
         properties = { 
             border_width = beautiful.border_width,
             border_color = beautiful.border_normal,
             focus = awful.client.focus.filter,
             raise = true,
             keys = clientkeys,
             buttons = clientbuttons,
             screen = awful.screen.preferred,
             placement = awful.placement.no_overlap+awful.placement.no_offscreen,
             size_hints_honor = false
         }
    },

    -- Floating clients
    { 
         rule_any = {
             name = {
                 "Event Tester", -- xev.
             },
             role = {
                 "pop-up", -- e.g. Google Chrome's (detached) Developer Tools.
             }
      }, properties = { floating = true }}
}

-- Focus follows mouse
client.connect_signal("mouse::enter", 
    function(c)
        c:emit_signal("request::activate", "mouse_enter", {raise = false})
    end)
