local wezterm = require 'wezterm'

local config = wezterm.config_builder()

--config.window_background_opacity = 0.9
config.font = wezterm.font('JetBrainsMono')
config.font_size = 15

--config.color_scheme = 'Sakura'
config.color_scheme = 'Slate'

return config