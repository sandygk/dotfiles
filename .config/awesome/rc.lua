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
    function(err)
      -- Avoid endless error loop
      if in_error then return end
      in_error = true
      naughty.notify({ 
        preset = naughty.config.presets.critical,
        title = "Error",
        text = tostring(err) 
      })
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
  awful.layout.suit.floating
}

-- Set the wallpaper
local function set_wallpaper(s)
  gears.wallpaper.maximized(beautiful.wallpaper, s, true)
end

-- Swap tags 
function swap_tag(other_tag)
  local screen = awful.screen.focused()
  this_tag = screen.selected_tag
  other_tag_clients = other_tag:clients()
  for i, c in ipairs(this_tag:clients()) do
    c:move_to_tag(other_tag)
  end
  for i, c in ipairs(other_tag_clients) do
    c:move_to_tag(this_tag)
  end
  other_tag:view_only()
end

-- Get tag by relative id
function tag_by_relative_index(index)
  local screen = awful.screen.focused()
  local tag_index = ((screen.selected_tag.index + index - 1) % #screen.tags) + 1
  local tag = screen.tags[tag_index]
  return tag
end

-- Create textclock widget
textclock = wibox.widget.textclock(" %a %d-%b | %I:%M %p ", 1)

-- Mouse bindings tag list
local taglist_buttons = gears.table.join(
  -- Select workspace with click
  awful.button({}, 1, function(t) t:view_only() end),

  -- Send client to workspace with super + click
  awful.button({ super }, 1, 
    function(t)
      if client.focus then
        client.focus:move_to_tag(t)
      end
    end),

  -- Change workspace with scroll wheel
  awful.button({}, 4, function(t) awful.tag.viewnext(t.screen) end),
  awful.button({}, 5, function(t) awful.tag.viewprev(t.screen) end)
)

-- Mouse bindings task list
local tasklist_buttons = gears.table.join(
  -- Focus client with click
  awful.button({}, 1, 
    function(c)
      c:emit_signal(
        "request::activate",
        "tasklist",
        { raise = true }
      )
    end),

  -- Change client with scroll wheel
  awful.button({}, 4, function()
    awful.client.focus.byidx(1)
  end),
  awful.button({}, 5, function()
    awful.client.focus.byidx(-1)
  end)
)

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

-- Initialize each screen
awful.screen.connect_for_each_screen(
  function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Set tags per screen
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

    -- Create layout indicator 
    s.layoutbox = awful.widget.layoutbox(s)
    s.layoutbox:buttons(
      gears.table.join(
        -- Change to next/previous layout with left/right click
        awful.button({}, 1, function() awful.layout.inc( 1) end),
        awful.button({}, 3, function() awful.layout.inc(-1) end),

        -- Change layout with scroll wheel
        awful.button({}, 4, function() awful.layout.inc( 1) end),
        awful.button({}, 5, function() awful.layout.inc(-1) end)
      )
    )

    -- Create a taglist widget
    s.taglist = awful.widget.taglist {
      screen  = s,
      filter  = awful.widget.taglist.filter.all,
      buttons = taglist_buttons
    }

    -- Create a tasklist widget
     s.tasklist = awful.widget.tasklist {
       screen   = s,
       filter   = awful.widget.tasklist.filter.currenttags,
       buttons  = tasklist_buttons
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
  end
)

-- Global key bindings
globalkeys = gears.table.join(
  -- Change next/previous workspace
  awful.key({ super }, "h",  awful.tag.viewprev),
  awful.key({ super }, "l", awful.tag.viewnext),
  awful.key({ super, "Shift", "Control" }, "l",
    function()
      swap_tag(tag_by_relative_index(1))
    end
  ),
  awful.key({ super, "Shift", "Control" }, "h",
    function()
      swap_tag(tag_by_relative_index(-1))
    end
  ),

  -- Focus next/previous client
  awful.key({ super }, "j", function() awful.client.focus.byidx( 1) end),
  awful.key({ super }, "k", function() awful.client.focus.byidx(-1) end),
  awful.key({ super          }, "Tab", function() awful.client.focus.byidx( 1) end),
  awful.key({ super, "Shift" }, "Tab", function() awful.client.focus.byidx(-1) end),
  
  -- Swapt with next/previous client
  awful.key({ super, "Shift" }, "j", function() awful.client.swap.byidx( 1) end),
  awful.key({ super, "Shift" }, "k", function() awful.client.swap.byidx(-1) end),

  -- Reload/quit awesome 
  awful.key({ super }, "r", awesome.restart),
  awful.key({ super, "Control", alt  }, "q", awesome.quit),

  -- Change master width
  awful.key({ super }, "equal", function() awful.tag.incmwfact( 0.01) end),
  awful.key({ super }, "minus", function() awful.tag.incmwfact(-0.01) end),
  awful.key({ super, "Shift" }, "equal", function() awful.tag.incmwfact( 0.05) end),
  awful.key({ super, "Shift" }, "minus", function() awful.tag.incmwfact(-0.05) end),
  awful.key({ super }, "0", function() awful.tag.setmwfact(0.5) end),

  -- Select layout
  awful.key({ super }, "m", function() awful.layout.set(awful.layout.suit.max) end),
  awful.key({ super }, "t", function() awful.layout.set(awful.layout.suit.tile) end),
  awful.key({ super }, "f", function() awful.layout.set(awful.layout.suit.floating) end),

  -- Quickly swap between max and tile
  awful.key({ super }, "grave", 
    function() 
      if awful.layout.get() ~= awful.layout.suit.max then
        awful.layout.set(awful.layout.suit.max) 
      else
        awful.layout.set(awful.layout.suit.tile) 
      end
    end),

  -- Unminimize all clients in workspace in focused screen
  awful.key({ super, "Shift" }, "x", 
    function() 
      local clients = awful.screen.focused().selected_tag:clients()
      for _, c in ipairs(clients) do
        if c.minimized then
          c.minimized = false
          c:emit_signal(
              "request::activate", "key.unminimize", { raise = true }
          )
        end
      end
    end),

  -- Focus next/previus screen
  awful.key({ super }, "n", function() awful.screen.focus_relative( 1) end),
  awful.key({ super }, "p", function() awful.screen.focus_relative(-1) end)
)

-- Global key bindings per workspace
for i = 1, #screen.primary.tags do
  globalkeys = gears.table.join(globalkeys,
    -- Select workspace
    awful.key({ super }, tostring(i),
      function()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        tag:view_only()
      end),

    -- Swap workspace
    awful.key({ super, "Control", "Shift" }, tostring(i),
      function()
        local screen = awful.screen.focused()
        local other_tag = screen.tags[i]
        swap_tag(other_tag)
      end
    )
  )
end

-- Client key bindings
clientkeys = gears.table.join(
  -- Close client
  awful.key({ super }, "q", function(c) c:kill() end),

  -- Minimize client
  awful.key({ super }, "x", function(c) c.minimized = true end),

  -- Move client to master
  awful.key({ super }, "Return", function(c) c:swap(awful.client.getmaster()) end),

  -- Send client to a next/previus workspace
  awful.key({ super, "Shift" }, "l", 
    function(c) 
        c:move_to_tag(tag_by_relative_index(1))
    end),

  awful.key({ super, "Shift" }, "h", 
    function(c) 
        c:move_to_tag(tag_by_relative_index(-1))
    end),

  -- Send client to a next/previus screen
  awful.key({ super, "Shift" }, "n", 
    function(c) 
      c:move_to_screen(c.screen.index + 1)
      awful.screen.focus_relative(-1) 
    end),

  awful.key({ super, "Shift" }, "p", 
    function(c) 
      c:move_to_screen(c.screen.index - 1)
      awful.screen.focus_relative(1) 
    end)
)

-- Client key bindings per workspace
for i = 1, #screen.primary.tags do
    clientkeys = gears.table.join(clientkeys,
      -- Send client to workspace
      awful.key({ super, "Shift" }, tostring(i),
        function(c)
          local tag = c.screen.tags[i]
          c:move_to_tag(tag)
        end
      )
    )
end

-- Mouse bindings
clientbuttons = gears.table.join(
  awful.button({}, 1, 
    function(c)
      c:emit_signal("request::activate", "mouse_click", { raise = true })
    end),
  awful.button({ super }, 1, 
    function(c)
      c:emit_signal("request::activate", "mouse_click", { raise = true })
      awful.mouse.client.move(c)
    end),
  awful.button({ super }, 3, 
    function(c)
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
    rule = {},
    properties = { 
      border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      focus = awful.client.focus.filter,
      raise = true,
      keys = clientkeys,
      buttons = clientbuttons,
      screen = awful.screen.preferred,
      placement = awful.placement.centered,
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
    c:emit_signal("request::activate", "mouse_enter", { raise = false })
  end)
