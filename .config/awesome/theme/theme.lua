---------------------------
-- Default awesome theme --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
local theme_path = gfs.get_configuration_dir() .. "theme/"

local theme = {}

theme.wallpaper = "~/wallpaper"

theme.font          = "sans 9"

theme.bg_normal     = "#232729"
theme.bg_focus      = "#17426f"
theme.bg_urgent     = "theme.bg_normal"
theme.bg_minimize   = "#444444"
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = "#ffffff"
theme.fg_focus      = theme.fg_normal
theme.fg_urgent     = theme.fg_normal
theme.fg_minimize   = theme.fg_normal

theme.useless_gap   = dpi(0)
theme.border_width  = dpi(2)

theme.border_normal = "#1b1f20" 
theme.border_focus  = "#215d9c"
theme.border_marked = theme.border_normal

-- Generate taglist squares
local taglist_square_size = dpi(4)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_normal
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal
)

-- Menu
theme.menu_submenu_icon = theme_path.."images/submenu.png"
theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)

-- Awesome icons 
theme.layout_floating  = theme_path.."images/floating.png"
theme.layout_max = theme_path.."images/max.png"
theme.layout_tile = theme_path.."images/tile.png"
theme.layout_fullscreen = theme_path.."images/max.png"

return theme
