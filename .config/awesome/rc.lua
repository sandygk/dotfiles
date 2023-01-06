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
local super = "Mod4"
local alt = "Mod1"

-- Layouts
awful.layout.layouts = {
  awful.layout.suit.max,
  awful.layout.suit.tile,
  awful.layout.suit.floating,
  awful.layout.suit.max.fullscreen
}

-- Set theme based on time on start
awful.util.spawn('set_theme --time')

-- Set theme
local function set_theme()
  awful.util.spawn('set_theme')
end

-- Swap tags
local function swap_tag(other_tag)
  local screen = awful.screen.focused({ client=true })
  local this_tag = screen.selected_tag
  local other_tag_clients = other_tag:clients()
  local other_tag_layout = other_tag.layout

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
local function tag_by_relative_index(index)
  local screen = awful.screen.focused()
  local tag_index = ((screen.selected_tag.index + index - 1) % #screen.tags) + 1
  local tag = screen.tags[tag_index]
  return tag
end

-- send client to other screen
local function send_to_screen(dir)
  local screen = awful.screen.focused({ client=true })
  local other_screen = awful.screen.object.get_next_in_direction(screen, dir)
  if client.focus then
    client.focus:move_to_screen(other_screen)
  end
  awful.screen.focus(screen)
end

---swap all tags across screens
function swap_screen(dir)
  local screen = awful.screen.focused({ client=true })
  local other_screen = awful.screen.object.get_next_in_direction(screen, dir)
  local tags = screen.tags
  local other_tags = other_screen.tags

  for i, tag in ipairs(tags) do
    local other_tag = other_tags[i]
    local tag_clients = tag:clients()
    local other_tag_clients = other_tag:clients()

    --swap layouts
    local layout = tag.layout
    local other_layout = other_tag.layout
    tag.layout = other_layout
    other_tag.layout = layout

    --swap clients
    for _, c in ipairs(tag_clients) do
      c:move_to_tag(other_tag)
    end
    for _, c in ipairs(other_tag_clients) do
      c:move_to_tag(tag)
    end
  end

  --swap selected tags
  local tag_index = screen.selected_tag.index
  local other_tag_index = other_screen.selected_tag.index
  local tag = screen.tags[other_tag_index]
  tag:view_only()
  tag = other_screen.tags[tag_index]
  tag:view_only()

  awful.screen.focus(other_screen)
end

-- Toggle between max and tile layout
local function alternate_tile_max()
  if awful.layout.get() ~= awful.layout.suit.max then
    awful.layout.set(awful.layout.suit.max)
  else
    awful.layout.set(awful.layout.suit.tile)
  end
end

-- Mouse bindings tag list
local taglist_buttons = gears.table.join(
  -- Select tag with click
  awful.button({}, 1, function(t) t:view_only() end),

  -- Send client to tag with super + click
  awful.button({ "Shift" }, 1,
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


--move clients and save desired screen when the screen is disconnected
tag.connect_signal("request::screen", function(t)
  local fallback_tag = nil

  for other_screen in screen do
    if other_screen ~= t.screen then
      fallback_tag = awful.tag.find_by_name(other_screen, t.name)
      if fallback_tag ~= nil then
        break
      end
    end
  end

  if fallback_tag == nil then
    fallback_tag = awful.tag.find_fallback()
  end

  if not (fallback_tag == nil) then
    clients = t:clients()
    for _, c in ipairs(clients) do
       c:move_to_tag(fallback_tag)
    end
  end
end)


-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_theme)

-- Initialize each screen
awful.screen.connect_for_each_screen(
  function(s)
    -- Set tags per screen
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9", "0" }, s, awful.layout.layouts[1])

    -- Create a taglist widget
    local taglist = awful.widget.taglist {
      screen  = s,
      filter  = awful.widget.taglist.filter.all,
      buttons = taglist_buttons
    }

    -- Create a tasklist widget
     local tasklist = awful.widget.tasklist {
       screen   = s,
       filter   = awful.widget.tasklist.filter.currenttags,
       buttons  = tasklist_buttons
    }

    -- Create status widget
    local statusbox = awful.widget.watch("status", 0.5)

    -- Create systray
    local systray = wibox.widget.systray()

    -- Create layout indicator
    local layoutbox = awful.widget.layoutbox(s)
    layoutbox:buttons(
      gears.table.join(
        -- Change to next/previous layout with left/right click
        awful.button({}, 1, function() awful.layout.inc( 1) end),
        awful.button({}, 3, function() awful.layout.inc(-1) end)
      )
    )

    -- Create the wibox
    s.wibox = awful.wibar({ position = "bottom", screen = s })

    -- Add widgets to the wibox
    s.wibox:setup {
      layout = wibox.layout.align.horizontal,

      -- Left widgets
      {
        layout = wibox.layout.fixed.horizontal,
        taglist,
      },

      -- Middle widget
      tasklist,

      -- Right widgets
      {
        layout = wibox.layout.fixed.horizontal,
        statusbox,
        systray,
        layoutbox,
      },
    }
  end
)

-- Global key bindings
local globalkeys = gears.table.join(

  -- Change next/previous tag
  awful.key({ super }, "h",  awful.tag.viewprev),
  awful.key({ super }, "Left", awful.tag.viewprev),
  awful.key({ super }, "l", awful.tag.viewnext),
  awful.key({ super }, "Right",  awful.tag.viewnext),
  awful.key({ super, "Shift", alt }, "l", function() swap_tag(tag_by_relative_index(1)) end),
  awful.key({ super, "Shift", alt }, "Right", function() swap_tag(tag_by_relative_index(1)) end),
  awful.key({ super, "Shift", alt }, "h", function() swap_tag(tag_by_relative_index(-1)) end),
  awful.key({ super, "Shift", alt }, "Left", function() swap_tag(tag_by_relative_index(-1)) end),

  -- Focus next/previous client
  awful.key({ super }, "j", function() awful.client.focus.byidx( 1) end),
  awful.key({ super }, "Down", function() awful.client.focus.byidx( 1) end),
  awful.key({ super }, "k", function() awful.client.focus.byidx(-1) end),
  awful.key({ super }, "Up", function() awful.client.focus.byidx(-1) end),
  awful.key({ super          }, "Tab", function() awful.client.focus.byidx( 1) end),
  awful.key({ super, "Shift" }, "Tab", function() awful.client.focus.byidx(-1) end),

  -- Swap with next/previous client
  awful.key({ super, "Shift" }, "j", function() awful.client.swap.byidx( 1) end),
  awful.key({ super, "Shift" }, "Up", function() awful.client.swap.byidx( 1) end),
  awful.key({ super, "Shift" }, "k", function() awful.client.swap.byidx(-1) end),
  awful.key({ super, "Shift" }, "Down", function() awful.client.swap.byidx(-1) end),

  -- Reload/quit awesome
  awful.key({ super }, "r", awesome.restart),

  -- Change master width
  awful.key({ super }, "z", function() awful.tag.incmwfact(-0.01) end),
  awful.key({ super }, "x", function() awful.tag.incmwfact( 0.01) end),
  awful.key({ super, "Shift" }, "z", function() awful.tag.incmwfact(-0.05) end),
  awful.key({ super, "Shift" }, "x", function() awful.tag.incmwfact( 0.05) end),
  awful.key({ super }, "c", function() awful.tag.setmwfact(0.5) end),

  -- Select layout
  awful.key({ super }, "m", function() awful.layout.set(awful.layout.suit.max) end),
  awful.key({ super }, "s", function() awful.layout.set(awful.layout.suit.tile) end),
  awful.key({ super }, "f", function() awful.layout.set(awful.layout.suit.floating) end),
  awful.key({ super }, "F11", function() awful.layout.set(awful.layout.suit.max.fullscreen) end),

  -- Quickly alternate between max and tile
  awful.key({ super }, "a", alternate_tile_max),

  -- Unminimize all clients in tag in focused screen
  awful.key({ super }, "b",
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

  -- Focus screen
  awful.key({ super }, "u", function() awful.screen.focus_bydirection("down") end),
  awful.key({ super }, "i", function() awful.screen.focus_bydirection("up") end),
  awful.key({ super }, "y", function() awful.screen.focus_bydirection("left") end),
  awful.key({ super }, "o", function() awful.screen.focus_bydirection("right") end),

  -- Send to screen
  awful.key({ super, "Shift" }, "u", function() send_to_screen("down") end),
  awful.key({ super, "Shift" }, "i", function() send_to_screen("up") end),
  awful.key({ super, "Shift" }, "y", function() send_to_screen("left") end),
  awful.key({ super, "Shift" }, "o", function() send_to_screen("right") end),

  -- Swap screen
  awful.key({ super, "Shift", alt }, "u", function() swap_screen("down") end),
  awful.key({ super, "Shift", alt }, "i", function() swap_screen("up") end),
  awful.key({ super, "Shift", alt }, "y", function() swap_screen("left") end),
  awful.key({ super, "Shift", alt }, "o", function() swap_screen("right") end)
)

-- Global key bindings per tag
for i = 1, #screen.primary.tags do
  globalkeys = gears.table.join(globalkeys,
    -- Select tag
    awful.key({ super }, tostring(i%10),
      function()
        local screen = awful.screen.focused( { client = true })
        local tag = screen.tags[i]
        tag:view_only()
      end),

    -- Swap tag
    awful.key({ super, alt, "Shift" }, tostring(i%10),
      function()
        local screen = awful.screen.focused( { client = true })
        local other_tag = screen.tags[i]
        swap_tag(other_tag)
      end
    )
  )
end

-- Client key bindings
local clientkeys = gears.table.join(
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
  awful.key({ super }, "v", function(c) c.minimized = true end),

  -- Toggle client's maximized state
  awful.key({ super, "Shift" }, "m", function(c) c.maximized = not c.maximized end),

  -- Toggle client's floating state
  awful.key({ super, "Shift" }, "f", function(c) c.floating = not c.floating end),

  -- Move client to master
  awful.key({ super }, "Return", function(c) c:swap(awful.client.getmaster()) end),

  -- Send client to a next/previus tag
  awful.key({ super, "Shift" }, "l", function(c) c:move_to_tag(tag_by_relative_index(1)) end),
  awful.key({ super, "Shift" }, "Right", function(c) c:move_to_tag(tag_by_relative_index(1)) end),
  awful.key({ super, "Shift" }, "h", function(c) c:move_to_tag(tag_by_relative_index(-1)) end),
  awful.key({ super, "Shift" }, "Left", function(c) c:move_to_tag(tag_by_relative_index(-1)) end)
)

-- Client key bindings per tag
for i = 1, #screen.primary.tags do
    clientkeys = gears.table.join(clientkeys,
      -- Send client to tag
      awful.key({ super, "Shift" }, tostring(i%10),
        function(c)
          local tag = c.screen.tags[i]
          c:move_to_tag(tag)
        end
      )
    )
end

-- Mouse bindings
local clientbuttons = gears.table.join(
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
  }
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

