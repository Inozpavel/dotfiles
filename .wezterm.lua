local wezterm = require 'wezterm'
local act = wezterm.action

wezterm.add_to_config_reload_watch_list('/home/inozpavel/.cache/wal/wezterm-wal.toml')

local config = wezterm.config_builder()

config.window_background_opacity = 0.9
config.enable_wayland = true

-- config.font = wezterm.font_with_fallback{
-- 'JetBrainsMono',
-- 'Fira Code',
-- }

config.font = wezterm.font {
    family='JetBrainsMono Nerd Font',
    weight= "Regular",
--  https://github.com/JetBrains/JetBrainsMono
    harfbuzz_features={ "zero", "cv16" }
}
-- config.font = wezterm.font {
--     family='FiraCode Nerd Font',
--     weight= "Light",
--  https://github.com/tonsky/FiraCode/wiki/How-to-enable-stylistic-sets
--     harfbuzz_features = { "cv12" , "cv14", "ss05", "ss03", "cv31", "cv29", "cv30", "cv21", "cv22", "cv23", "ss09", "ss07" }
-- }
config.font_size = 15
config.warn_about_missing_glyphs = false
config.hide_tab_bar_if_only_one_tab = true
-- config.color_scheme = 'Slate'

config.color_scheme_dirs = { '/home/inozpavel/.cache/wal' }
config.color_scheme = 'wezterm-wal'
-- config.color_scheme = 'Sakura'
-- config.color_scheme = 'Catppuccin Mocha'
-- config.color_scheme = 'Catppuccin Macchiato'
-- config.color_scheme = 'Catppuccin Frappe'
-- config.color_scheme = 'Catppuccin Latte'

config.default_prog = { '/usr/bin/zsh' }

config.initial_cols = 130
config.initial_rows = 35

config.mouse_bindings = {
  -- Scrolling up while holding CTRL increases the font size
  {
    event = { Down = { streak = 1, button = { WheelUp = 1 } } },
    mods = 'CTRL',
    action = act.IncreaseFontSize,
  },

  -- Scrolling down while holding CTRL decreases the font size
  {
    event = { Down = { streak = 1, button = { WheelDown = 1 } } },
    mods = 'CTRL',
    action = act.DecreaseFontSize,
  },
}


return config
