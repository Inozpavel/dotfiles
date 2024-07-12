local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.window_background_opacity = 0.9

-- config.font = wezterm.font_with_fallback{
-- 'JetBrainsMono',
-- 'Fira Code',
-- }

config.font = wezterm.font {
    family='JetBrainsMono Nerd Font',
    weight= "Regular",
}
-- config.font = wezterm.font {
--     family='FiraCode Nerd Font',
--     weight= "Light",
--  https://github.com/tonsky/FiraCode/wiki/How-to-enable-stylistic-sets
--     harfbuzz_features = { "cv12" , "cv14", "ss05", "ss03", "cv31", "cv29", "cv30", "cv21", "cv22", "cv23", "ss09", "ss07" }
-- }
config.font_size = 15
config.warn_about_missing_glyphs = false
config.enable_tab_bar = true

--config.color_scheme = 'Sakura'
config.color_scheme = 'Slate'

config.default_prog = { '/usr/bin/zsh' }

config.initial_cols = 130
config.initial_rows = 35

return config
