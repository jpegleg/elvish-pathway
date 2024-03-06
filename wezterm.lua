-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = 'Mathias'
config.window_background_opacity = 0.9
config.window_background_gradient = {
  colors = { '#000066', '000003' },
  -- Specifices a Linear gradient starting in the top left corner.
  orientation = { Linear = { angle = -45.0 } },
}
-- and finally, return the configuration to wezterm
return config
