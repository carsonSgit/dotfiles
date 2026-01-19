-- WezTerm config with theme switcher
local wezterm = require("wezterm")
local config = wezterm.config_builder()
local io = require("io")

-- Theme definitions
local themes = {
    cyberdream = {
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
    },
    ocean = {
        bg = "#093748",
        bg_alt = "#0d4a5f",
        fg = "#a4b5b6",
        grey = "#4e5d5e",
        dark_grey = "#1a4d5e",
        red = "#cb4b16",
        green = "#16a085",
        yellow = "#cb4b16",
        blue = "#268bd2",
        magenta = "#6c71c4",
        cyan = "#2aa198",
        orange = "#cb4b16",
        pink = "#d33682",
    },
    onedark = {
        bg = "#282c34",
        bg_alt = "#2c323c",
        fg = "#abb2bf",
        grey = "#5c6370",
        dark_grey = "#3e4452",
        red = "#e06c75",
        green = "#98c379",
        yellow = "#e5c07b",
        blue = "#61afef",
        magenta = "#c678dd",
        cyan = "#56b6c2",
        orange = "#d19a66",
        pink = "#e06c75",
    },
    ["tomorrow-night"] = {
        bg = "#1d1f21",
        bg_alt = "#282a2e",
        fg = "#c5c8c6",
        grey = "#969896",
        dark_grey = "#373b41",
        red = "#cc6666",
        green = "#b5bd68",
        yellow = "#f0c674",
        blue = "#81a2be",
        magenta = "#b294bb",
        cyan = "#8abeb7",
        orange = "#de935f",
        pink = "#cc6666",
    },
    ["two-firewatch"] = {
        bg = "#1d2021",
        bg_alt = "#282828",
        fg = "#dfdfe0",
        grey = "#4d5057",
        dark_grey = "#3c3836",
        red = "#e06c75",
        green = "#acb765",
        yellow = "#e5a95b",
        blue = "#6e94b9",
        magenta = "#e07798",
        cyan = "#74aea8",
        orange = "#e5a95b",
        pink = "#e07798",
    },
    circus = {
        bg = "#191919",
        bg_alt = "#202020",
        fg = "#a7a7a7",
        grey = "#5f5a60",
        dark_grey = "#303030",
        red = "#dc657d",
        green = "#84b97c",
        yellow = "#c3ba63",
        blue = "#639ee4",
        magenta = "#b888e2",
        cyan = "#4bb1a7",
        orange = "#c3ba63",
        pink = "#dc657d",
    },
    teerb = {
        bg = "#232323",
        bg_alt = "#2a2a2a",
        fg = "#eeeeee",
        grey = "#1c1c1c",
        dark_grey = "#333333",
        red = "#d75f5f",
        green = "#68c256",
        yellow = "#bfc256",
        blue = "#6096bf",
        magenta = "#bf6096",
        cyan = "#56c2a8",
        orange = "#bfc256",
        pink = "#bf6096",
    },
    ["snow-dark"] = {
        bg = "#1c1e22",
        bg_alt = "#22252a",
        fg = "#a0a4ae",
        grey = "#535c65",
        dark_grey = "#2c3038",
        red = "#be6069",
        green = "#4d9375",
        yellow = "#c4a86c",
        blue = "#6a9fb5",
        magenta = "#b57da5",
        cyan = "#5d9e97",
        orange = "#c4a86c",
        pink = "#b57da5",
    },
}

-- Theme file path (shared with Nushell)
local theme_file = "C:\\Users\\carso\\AppData\\Roaming\\nushell\\.current_theme"

-- Read current theme from file
local function get_current_theme()
    local f = io.open(theme_file, "r")
    if f then
        local name = f:read("*l")
        f:close()
        if name and themes[name] then
            return name
        end
    end
    return "cyberdream"
end

-- Save theme to file
local function save_theme(name)
    local f = io.open(theme_file, "w")
    if f then
        f:write(name)
        f:close()
    end
end

-- Get current theme colors
local current_theme = get_current_theme()
local c = themes[current_theme]

-- Apply theme colors
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
config.default_prog = { "cmd.exe", "/c", "C:\\Users\\carso\\AppData\\Local\\Programs\\nu\\bin\\nu.exe" }
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
config.front_end = "OpenGL"
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
config.set_environment_variables = {
    TERM = "xterm-256color",
}
config.term = "xterm-256color"
config.allow_win32_input_mode = false

-- Build theme choices for InputSelector
local theme_choices = {}
for name, _ in pairs(themes) do
    table.insert(theme_choices, { label = name, id = name })
end
table.sort(theme_choices, function(a, b) return a.label < b.label end)

-- Keybindings
config.keys = {
    -- Theme picker
    {
        key = "t",
        mods = "CTRL|ALT",
        action = wezterm.action.InputSelector({
            title = "Select Theme",
            choices = theme_choices,
            action = wezterm.action_callback(function(window, pane, id, label)
                if id then
                    save_theme(id)
                    wezterm.reload_configuration()
                end
            end),
        }),
    },

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
