
local gears = require("gears")
local lain  = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local os    = { getenv = os.getenv }
local widgets = require("widgets")

local C = {
    base03      = "#002b36",
    base02      = "#073642",
    base02_l    = "#094959",
    base01      = "#586e75",
    base00      = "#657b83",
    base0       = "#839496",
    base1       = "#93a1a1",
    base2       = "#eee8d5",
    base3       = "#fdf6e3",
    yellow      = "#b58900",
    orange      = "#cb4b16",
    red         = "#dc322f",
    magenta     = "#d33682",
    violet      = "#6c71c4",
    blue        = "#268bd2",
    cyan        = "#2aa198",
    green       = "#859900",
}

local theme                                     = {}
theme.dir                                       = os.getenv("HOME") .. "/.config/awesome/themes/powerarrow-my"
theme.wallpaper                                 = theme.dir .. "/wall.png"
theme.font                                      = "Terminus (TTF) 12"
theme.wibar_height                              = 20
theme.wibar_margin_bottom                       = 2
theme.fg_normal                                 = C.base1
theme.fg_focus                                  = C.base1
theme.fg_urgent                                 = C.cyan
theme.bg_normal                                 = C.base03
theme.bg_focus                                  = C.base02_l
theme.bg_urgent                                 = C.base01
theme.border_width                              = 2
theme.border_normal                             = theme.bg_focus
theme.border_focus                              = theme.bg_focus
theme.border_marked                             = "#CC9393"
theme.tasklist_bg_focus                         = theme.bg_focus
theme.titlebar_bg_focus                         = theme.bg_focus
theme.titlebar_bg_normal                        = theme.bg_normal
theme.titlebar_fg_focus                         = theme.fg_focus
theme.menu_height                               = 16
theme.menu_width                                = 140
theme.menu_submenu_icon                         = theme.dir .. "/icons/submenu.png"
theme.taglist_squares_sel                       = theme.dir .. "/icons/square_sel.png"
theme.taglist_squares_unsel                     = theme.dir .. "/icons/square_unsel.png"
theme.layout_tile                               = theme.dir .. "/icons/tile.png"
theme.layout_tileleft                           = theme.dir .. "/icons/tileleft.png"
theme.layout_tilebottom                         = theme.dir .. "/icons/tilebottom.png"
theme.layout_tiletop                            = theme.dir .. "/icons/tiletop.png"
theme.layout_fairv                              = theme.dir .. "/icons/fairv.png"
theme.layout_fairh                              = theme.dir .. "/icons/fairh.png"
theme.layout_spiral                             = theme.dir .. "/icons/spiral.png"
theme.layout_dwindle                            = theme.dir .. "/icons/dwindle.png"
theme.layout_max                                = theme.dir .. "/icons/max.png"
theme.layout_fullscreen                         = theme.dir .. "/icons/fullscreen.png"
theme.layout_magnifier                          = theme.dir .. "/icons/magnifier.png"
theme.layout_floating                           = theme.dir .. "/icons/floating.png"
theme.widget_ac                                 = theme.dir .. "/icons/ac.png"
theme.widget_battery                            = theme.dir .. "/icons/battery.png"
theme.widget_battery_low                        = theme.dir .. "/icons/battery_low.png"
theme.widget_battery_empty                      = theme.dir .. "/icons/battery_empty.png"
theme.widget_mem                                = theme.dir .. "/icons/mem.png"
theme.widget_cpu                                = theme.dir .. "/icons/cpu.png"
theme.widget_temp                               = theme.dir .. "/icons/temp.png"
theme.widget_net                                = theme.dir .. "/icons/net.png"
theme.widget_hdd                                = theme.dir .. "/icons/hdd.png"
theme.widget_music                              = theme.dir .. "/icons/note.png"
theme.widget_music_on                           = theme.dir .. "/icons/note_on.png"
theme.widget_vol                                = theme.dir .. "/icons/vol.png"
theme.widget_vol_low                            = theme.dir .. "/icons/vol_low.png"
theme.widget_vol_no                             = theme.dir .. "/icons/vol_no.png"
theme.widget_vol_mute                           = theme.dir .. "/icons/vol_mute.png"
theme.widget_mail                               = theme.dir .. "/icons/mail.png"
theme.widget_mail_on                            = theme.dir .. "/icons/mail_on.png"
theme.tasklist_plain_task_name                  = true
theme.tasklist_disable_icon                     = false
theme.useless_gap                               = 0
theme.titlebar_close_button_focus               = theme.dir .. "/icons/titlebar/close_focus.png"
theme.titlebar_close_button_normal              = theme.dir .. "/icons/titlebar/close_normal.png"
theme.titlebar_ontop_button_focus_active        = theme.dir .. "/icons/titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active       = theme.dir .. "/icons/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive      = theme.dir .. "/icons/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive     = theme.dir .. "/icons/titlebar/ontop_normal_inactive.png"
theme.titlebar_sticky_button_focus_active       = theme.dir .. "/icons/titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active      = theme.dir .. "/icons/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive     = theme.dir .. "/icons/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive    = theme.dir .. "/icons/titlebar/sticky_normal_inactive.png"
theme.titlebar_floating_button_focus_active     = theme.dir .. "/icons/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active    = theme.dir .. "/icons/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive   = theme.dir .. "/icons/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive  = theme.dir .. "/icons/titlebar/floating_normal_inactive.png"
theme.titlebar_maximized_button_focus_active    = theme.dir .. "/icons/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active   = theme.dir .. "/icons/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = theme.dir .. "/icons/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = theme.dir .. "/icons/titlebar/maximized_normal_inactive.png"
theme.prompt_bg = theme.bg_focus
theme.prompt_bg_cursor = C.base02

local markup = lain.util.markup
local separators = lain.util.separators

-- Textclock
local clockicon = wibox.widget.imagebox(theme.widget_clock)
local clock = lain.widget.watch({
    timeout  = 60,
    cmd      = " date +'%a %d %b %R '",
    settings = function()
        widget:set_markup(" " .. markup.font(theme.font, output))
    end
})

-- Calendar
theme.cal = lain.widget.calendar({
    attach_to = { clock.widget },
    notification_preset = {
        font = "xos4 Terminus 10",
        fg   = theme.fg_normal,
        bg   = theme.bg_normal
    }
})

-- MEM
local memicon = wibox.widget.imagebox(theme.widget_mem)
local mem = lain.widget.mem({
    settings = function()
        widget:set_markup(markup.font(theme.font, " " .. mem_now.used .. "MB "))
    end
})

-- CPU
local cpuicon = wibox.widget.imagebox(theme.widget_cpu)
local cpu = lain.widget.cpu({
    settings = function()
        widget:set_markup(markup.font(theme.font, " " .. cpu_now.usage .. "% "))
    end
})

-- Coretemp
local tempicon = wibox.widget.imagebox(theme.widget_temp)
local temp = lain.widget.temp({
    settings = function()
        widget:set_markup(markup.font(theme.font, " " .. coretemp_now .. "°C "))
    end
})

-- / fs
local fsicon = wibox.widget.imagebox(theme.widget_hdd)
theme.fs = lain.widget.fs({
    options  = "--exclude-type=tmpfs",
    notification_preset = { fg = theme.fg_normal, bg = theme.bg_normal, font = "xos4 Terminus 10" },
    settings = function()
        widget:set_markup(markup.font(theme.font, " " .. fs_now.used .. "% "))
    end
})

-- Battery
local baticon = wibox.widget.imagebox(theme.widget_battery)
local bat = lain.widget.bat({
    settings = function()
        if bat_now.status ~= "N/A" then
            if bat_now.ac_status == 1 then
                widget:set_markup(markup.font(theme.font, " AC "))
                baticon:set_image(theme.widget_ac)
                return
            elseif not bat_now.perc and tonumber(bat_now.perc) <= 5 then
                baticon:set_image(theme.widget_battery_empty)
            elseif not bat_now.perc and tonumber(bat_now.perc) <= 15 then
                baticon:set_image(theme.widget_battery_low)
            else
                baticon:set_image(theme.widget_battery)
            end
            widget:set_markup(markup.font(theme.font, " " .. bat_now.perc .. "% "))
        else
            widget:set_markup(markup.font(theme.font, " AC "))
            baticon:set_image(theme.widget_ac)
        end
    end
})

-- Net
local neticon = wibox.widget.imagebox(theme.widget_net)
local net = lain.widget.net({
    settings = function()
        widget:set_markup(markup.font(theme.font,
                          markup(C.green, " " .. net_now.received)
                          .. " " ..
                          markup(C.cyan, " " .. net_now.sent .. " ")))
    end
})

function shape_powerline_left(cr, width, height)
    return gears.shape.powerline(cr, width, height, -height/2)
end

function container_arrow(widget, direction)
    local margin = (theme.wibar_height - theme.wibar_margin_bottom) / 2
    local direction = direction or "right"
    local shape = gears.shape.powerline
    if direction == "left" then
        shape = shape_powerline_left
    end
    return {
        {
            widget,
            widget = wibox.container.margin,
            left = margin,
            right = margin,
        },
        widget = wibox.container.background,
        bg = theme.bg_focus,
        shape = shape,
    }
end

function powerline_bar(widgets)
    local direction = widgets["direction"] or "right"
    local definitions = {
        layout = wibox.layout.fixed.horizontal,
    }

    for index, widget in ipairs(widgets) do
        if math.fmod(index, 2) == 0 then
            widget = container_arrow(widget, direction)
        end
        if direction == "right" then
            table.insert(definitions, widget)
        else
            table.insert(definitions, 1, widget)
        end
    end

    return definitions
end

function with_icon(icon, widget)
    return {
        icon,
        widget,
        layout = wibox.layout.fixed.horizontal,
    }
end

theme.taglist_shape = function (cr, width, height)
    return gears.shape.partially_rounded_rect(cr, width, height, false, false, true, true, theme.wibar_height / 4)
end

theme.tasklist_shape = function (cr, width, height)
    return gears.shape.partially_rounded_rect(cr, width, height, true, true, false, false, theme.wibar_height / 4)
end

theme.promptbox_shape = function (cr, width, height)
    return gears.shape.rounded_rect(cr, width, height, theme.wibar_height / 4)
end


function theme.at_screen_connect(s)
    -- If wallpaper is a function, call it with the screen
    local wallpaper = theme.wallpaper
    if type(wallpaper) == "function" then
        wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)

    -- Tags
    awful.tag(awful.util.tagnames, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt{prompt = " Run: "}
    s.mypromptbox:set_shape(theme.promptbox_shape)
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons)

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, awful.util.tasklist_buttons)

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, height = theme.wibar_height, bg = theme.bg_normal.."00", fg = theme.fg_normal })

    s.systray = wibox.widget.systray()
    s.systray.opacity = 0.1

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widget
            layout = wibox.layout.fixed.horizontal,
            {
                s.mytaglist,
                widget = wibox.container.margin,
                bottom = theme.wibar_margin_bottom,
            },
            {
                s.mypromptbox,
                widget = wibox.container.margin,
                top = 1,
                bottom = 1,
                left = 2,
                right = 2,
            },
        },
        { -- Middle widget
            s.mytasklist,
            widget = wibox.container.margin,
            top = theme.wibar_margin_bottom,
        },
        { -- Right widget
            {
                layout = wibox.layout.fixed.horizontal,
                powerline_bar {
                    direction = "left",
                    s.mylayoutbox,
                    widgets.keyboardlayout:new(),
                    {
                        s.systray,
                        clock.widget,
                        layout = wibox.layout.fixed.horizontal,
                    },
                    with_icon(baticon, bat.widget),
                    with_icon(fsicon, theme.fs.widget),
                    with_icon(tempicon, temp.widget),
                    with_icon(cpuicon, cpu.widget),
                    with_icon(memicon, mem.widget),
                    with_icon(neticon, net.widget),
                },
            },
            widget = wibox.container.margin,
            bottom = theme.wibar_margin_bottom,
        },
    }
end

return theme
