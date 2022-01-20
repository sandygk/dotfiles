-- Imports
pcall(require, "luarocks.loader")
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
local wibox = require("wibox")
local beautiful = require("beautiful")

-- Set theme
beautiful.init(gears.filesystem.get_configuration_dir() .. "theme/theme.lua")

-- Aliases for mod keys
super = "Mod4"
alt = "Mod1"

-- Layouts
awful.layout.layouts = {
  awful.layout.suit.max,
  awful.layout.suit.tile,
  awful.layout.suit.floating,
  awful.layout.suit.max.fullscreen
}

-- Set the wallpaper
local function set_wallpaper(s)
  gears.wallpaper.set(beautiful.wallpaper_color)
end

-- Swap tags
function swap_tag(other_tag)
  local screen = awful.screen.focused({ client=true })
  this_tag = screen.selected_tag
  other_tag_clients = other_tag:clients()
  other_tag_layout = other_tag.layout

  for i, c in ipairs(this_tag:clients()) do
    c:move_to_tag(other_tag)
  end
  other_tag.layout = this_tag.layout

  for i, c in ipairs(other_tag_clients) do
    c:move_to_tag(this_tag)
  end
  this_tag.layout = other_tag_layout
  other_tag:view_only()
end

-- Get tag by relative id
function tag_by_relative_index(index)
  local screen = awful.screen.focused()
  local tag_index = ((screen.selected_tag.index + index - 1) % #screen.tags) + 1
  local tag = screen.tags[tag_index]
  return tag
end

-- Create status widget
statusbox = awful.widget.watch("status", 0.5)

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
    end)
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
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9", "0" }, s, awful.layout.layouts[1])

    -- Create layout indicator
    s.layoutbox = awful.widget.layoutbox(s)
    s.layoutbox:buttons(
      gears.table.join(
        -- Change to next/previous layout with left/right click
        awful.button({}, 1, function() awful.layout.inc( 1) end),
        awful.button({}, 3, function() awful.layout.inc(-1) end)
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
        statusbox,
        s.layoutbox,
      },
    }
  end
)

-- Global key bindings
globalkeys = gears.table.join(
  -- Change next/previous workspace
  awful.key({ super }, "h",  awful.tag.viewprev),
  awful.key({ super }, "Left", awful.tag.viewprev),
  awful.key({ super }, "l", awful.tag.viewnext),
  awful.key({ super }, "Right",  awful.tag.viewnext),
  awful.key({ super, "Shift", "Control" }, "l", function() swap_tag(tag_by_relative_index(1)) end),
  awful.key({ super, "Shift", "Control" }, "Right", function() swap_tag(tag_by_relative_index(1)) end),
  awful.key({ super, "Shift", "Control" }, "h", function() swap_tag(tag_by_relative_index(-1)) end),
  awful.key({ super, "Shift", "Control" }, "Left", function() swap_tag(tag_by_relative_index(-1)) end),

  -- Focus next/previous client
  awful.key({ super }, "j", function() awful.client.focus.byidx( 1) end),
  awful.key({ super }, "Down", function() awful.client.focus.byidx( 1) end),
  awful.key({ super }, "k", function() awful.client.focus.byidx(-1) end),
  awful.key({ super }, "Up", function() awful.client.focus.byidx(-1) end),
  awful.key({ super          }, "Tab", function() awful.client.focus.byidx( 1) end),
  awful.key({ super, "Shift" }, "Tab", function() awful.client.focus.byidx(-1) end),

  -- Swapt with next/previous client
  awful.key({ super, "Shift" }, "j", function() awful.client.swap.byidx( 1) end),
  awful.key({ super, "Shift" }, "Up", function() awful.client.swap.byidx( 1) end),
  awful.key({ super, "Shift" }, "k", function() awful.client.swap.byidx(-1) end),
  awful.key({ super, "Shift" }, "Down", function() awful.client.swap.byidx(-1) end),

  -- Reload/quit awesome
  awful.key({ super }, "r", awesome.restart),

  -- Change master width
  awful.key({ super }, "comma", function() awful.tag.incmwfact(-0.01) end),
  awful.key({ super }, "period", function() awful.tag.incmwfact( 0.01) end),
  awful.key({ super, "Shift" }, "comma", function() awful.tag.incmwfact(-0.05) end),
  awful.key({ super, "Shift" }, "period", function() awful.tag.incmwfact( 0.05) end),
  awful.key({ super }, "slash", function() awful.tag.setmwfact(0.5) end),

  -- Select layout
  awful.key({ super }, "m", function() awful.layout.set(awful.layout.suit.max) end),
  awful.key({ super }, "t", function() awful.layout.set(awful.layout.suit.tile) end),
  awful.key({ super }, "f", function() awful.layout.set(awful.layout.suit.floating) end),
  awful.key({ super }, "F11", function() awful.layout.set(awful.layout.suit.max.fullscreen) end),

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
  awful.key({ super }, "equal",
    function()
      local clients = awful.screen.focused( { client = true }).selected_tag:clients()
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
    awful.key({ super }, tostring(i%10),
      function()
        local screen = awful.screen.focused( { client = true })
        local tag = screen.tags[i]
        tag:view_only()
      end),

    -- Swap workspace
    awful.key({ super, "Control", "Shift" }, tostring(i%10),
      function()
        local screen = awful.screen.focused( { client = true })
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

  -- Force quit client
  awful.key({ super, "Shift"   }, "q",
      function (c)
          if c.pid then
              awful.spawn("kill -9 " .. c.pid)
          end
      end
  ),

  -- Minimize client
  awful.key({ super }, "minus", function(c) c.minimized = true end),

  -- Toggle client's maximized state
  awful.key({ super, "Shift" }, "m", function(c) c.maximized = not c.maximized end),

  -- Toggle client's floating state
  awful.key({ super, "Shift" }, "f", function(c) c.floating = not c.floating end),

  -- Move client to master
  awful.key({ super }, "Return", function(c) c:swap(awful.client.getmaster()) end),

  -- Send client to a next/previus workspace
  awful.key({ super, "Shift" }, "l", function(c) c:move_to_tag(tag_by_relative_index(1)) end),
  awful.key({ super, "Shift" }, "Right", function(c) c:move_to_tag(tag_by_relative_index(1)) end),
  awful.key({ super, "Shift" }, "h", function(c) c:move_to_tag(tag_by_relative_index(-1)) end),
  awful.key({ super, "Shift" }, "Left", function(c) c:move_to_tag(tag_by_relative_index(-1)) end),

  -- Send client to a next/previus screen
  awful.key({ super, "Shift" }, "n", function(c)
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
      awful.key({ super, "Shift" }, tostring(i%10),
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
      maximized=false,
      maximized_horizontal=false,
      maximized_vertical=false,
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
}

-- Apply theme on focus/unfocus
client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

-- Hide borders if the client is maximized or fullscreen
screen.connect_signal("arrange", function (s)
  for _, c in pairs(s.clients) do
    if (s.selected_tag.layout.name == "max" or
        s.selected_tag.layout.name == "fullscreen")
      and not c.floating
    then
      c.border_width = 0
    else
      c.border_width = beautiful.border_width
    end
  end
end)
