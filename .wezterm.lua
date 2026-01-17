-- Cyberdream WezTerm - FANCY EDITION
local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Cyberdream color palette
local c = {
    bg = "#16181a",
    bg_alt = "#1e2124",
    fg = "#ffffff",
    grey = "#7b8496",
    dark_grey = "#3c4048",
    red = "#ff6e5e",
    green = "#5eff6c",
    yellow = "#f1ff5e",
    blue = "#5ea1ff",
    magenta = "#bd5eff",
    cyan = "#5ef1ff",
    orange = "#ffbd5e",
    pink = "#ff5ea0",
}

-- Theme
config.colors = {
    foreground = c.fg,
    background = c.bg,
    cursor_bg = c.cyan,
    cursor_fg = c.bg,
    cursor_border = c.cyan,
    selection_fg = c.bg,
    selection_bg = c.blue,
    split = c.dark_grey,
    ansi = { c.bg, c.red, c.green, c.yellow, c.blue, c.magenta, c.cyan, c.fg },
    brights = { c.dark_grey, c.red, c.green, c.yellow, c.blue, c.magenta, c.cyan, c.fg },
    compose_cursor = c.orange,
    tab_bar = {
        background = c.bg,
        active_tab = { bg_color = c.cyan, fg_color = c.bg, intensity = "Bold" },
        inactive_tab = { bg_color = c.dark_grey, fg_color = c.grey },
        inactive_tab_hover = { bg_color = c.bg_alt, fg_color = c.cyan, italic = true },
        new_tab = { bg_color = c.bg, fg_color = c.grey },
        new_tab_hover = { bg_color = c.dark_grey, fg_color = c.cyan },
    },
}

-- Shell
config.default_prog = { "c:\\Program Files\\nu\\bin\\nu.exe", "-l" }
config.initial_cols = 130
config.initial_rows = 32

-- Fancy Font with ligatures
config.font = wezterm.font_with_fallback({
    { family = "JetBrains Mono", weight = "Medium", harfbuzz_features = { "calt=1", "clig=1", "liga=1" } },
    { family = "Cascadia Code" },
    { family = "Fira Code" },
    "Consolas",
})
config.font_size = 11

-- Cursor candy - blinking cyan bar
config.default_cursor_style = "BlinkingBar"
config.cursor_blink_rate = 500
config.cursor_blink_ease_in = "EaseIn"
config.cursor_blink_ease_out = "EaseOut"

-- Window chrome
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.integrated_title_button_style = "Windows"
config.integrated_title_button_alignment = "Right"
config.window_padding = { left = 16, right = 16, top = 12, bottom = 12 }

-- Transparency & blur
config.window_background_opacity = 0.92
config.win32_system_backdrop = "Acrylic"

-- Tab bar
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = false
config.use_fancy_tab_bar = false
config.tab_max_width = 40
config.show_tab_index_in_tab_bar = true

-- Fancy tab format
wezterm.on("format-tab-title", function(tab)
    local title = tab.active_pane.title or "nu"
    title = title:gsub("^.*\\", ""):gsub("%.exe$", "")
    if #title > 20 then title = title:sub(1, 18) .. ".." end
    local icon = tab.is_active and " " or " "
    return string.format(" %s%d %s ", icon, tab.tab_index + 1, title)
end)

-- Right status with fancy info
wezterm.on("update-right-status", function(window)
    local date = wezterm.strftime("%H:%M")
    local bat = ""
    for _, b in ipairs(wezterm.battery_info()) do
        local icon = b.state_of_charge > 0.5 and "" or (b.state_of_charge > 0.2 and "" or "")
        bat = string.format("%s %.0f%% ", icon, b.state_of_charge * 100)
    end
    window:set_right_status(wezterm.format({
        { Foreground = { Color = c.grey } },
        { Text = bat },
        { Foreground = { Color = c.cyan } },
        { Text = " " .. date .. " " },
    }))
end)

-- Performance
config.animation_fps = 120
config.max_fps = 120
config.front_end = "WebGpu"
config.webgpu_power_preference = "HighPerformance"
config.scrollback_lines = 10000

-- Visual bell (flash instead of beep)
config.audible_bell = "Disabled"
config.visual_bell = {
    fade_in_function = "EaseIn",
    fade_in_duration_ms = 75,
    fade_out_function = "EaseOut",
    fade_out_duration_ms = 150,
}

-- Misc
config.check_for_updates = false
config.automatically_reload_config = true

-- Keybindings
config.keys = {
    -- Splits
    { key = "d", mods = "CTRL|SHIFT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
    { key = "e", mods = "CTRL|SHIFT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
    { key = "w", mods = "CTRL|SHIFT", action = wezterm.action.CloseCurrentPane({ confirm = true }) },

    -- Navigate panes (vim)
    { key = "h", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Left") },
    { key = "l", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Right") },
    { key = "k", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Up") },
    { key = "j", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Down") },

    -- Resize panes
    { key = "LeftArrow", mods = "CTRL|SHIFT|ALT", action = wezterm.action.AdjustPaneSize({ "Left", 3 }) },
    { key = "RightArrow", mods = "CTRL|SHIFT|ALT", action = wezterm.action.AdjustPaneSize({ "Right", 3 }) },
    { key = "UpArrow", mods = "CTRL|SHIFT|ALT", action = wezterm.action.AdjustPaneSize({ "Up", 3 }) },
    { key = "DownArrow", mods = "CTRL|SHIFT|ALT", action = wezterm.action.AdjustPaneSize({ "Down", 3 }) },

    -- Tabs
    { key = "t", mods = "CTRL|SHIFT", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
    { key = "Tab", mods = "CTRL", action = wezterm.action.ActivateTabRelative(1) },
    { key = "Tab", mods = "CTRL|SHIFT", action = wezterm.action.ActivateTabRelative(-1) },

    -- Font size
    { key = "=", mods = "CTRL", action = wezterm.action.IncreaseFontSize },
    { key = "-", mods = "CTRL", action = wezterm.action.DecreaseFontSize },
    { key = "0", mods = "CTRL", action = wezterm.action.ResetFontSize },

    -- Quick select (highlight & copy URLs, paths, etc.)
    { key = "Space", mods = "CTRL|SHIFT", action = wezterm.action.QuickSelect },

    -- Copy mode (like tmux)
    { key = "x", mods = "CTRL|SHIFT", action = wezterm.action.ActivateCopyMode },

    -- Fullscreen
    { key = "F11", action = wezterm.action.ToggleFullScreen },

    -- Command palette
    { key = "p", mods = "CTRL|SHIFT", action = wezterm.action.ActivateCommandPalette },
}

-- Mouse bindings
config.mouse_bindings = {
    -- Right click paste
    { event = { Down = { streak = 1, button = "Right" } }, mods = "NONE", action = wezterm.action.PasteFrom("Clipboard") },
    -- Ctrl+Click open link
    { event = { Up = { streak = 1, button = "Left" } }, mods = "CTRL", action = wezterm.action.OpenLinkAtMouseCursor },
}

-- Quick select patterns
config.quick_select_patterns = {
    "[0-9a-f]{7,40}",  -- git hashes
    "https?://\\S+",   -- URLs
}

return config
