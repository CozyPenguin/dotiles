local wt = require('wezterm')

return {
  -- Linux
  enable_wayland = false,
  -- Font configuration
  font = wt.font('Fira Code'),
  font_size = 10,
  -- Theming
  color_schemes = {
    ['Seasons Winter'] = {
      ansi = {
        'hsl(220, 15%, 10%)',
        'hsl(354, 52%, 45%)',
        'hsl(141, 71%, 45%)',
        'hsl(60, 55%, 45%)',
        'hsl(220, 70%, 45%)',
        'hsl(290, 45%, 45%)',
        'hsl(193, 76%, 45%)',
        'hsl(220, 40%, 95%)',
      },
      brights = {
        'hsl(220, 15%, 40%)',
        'hsl(354, 52%, 65%)',
        'hsl(141, 71%, 65%)',
        'hsl(60, 55%, 65%)',
        'hsl(220, 70%, 65%)',
        'hsl(290, 45%, 65%)',
        'hsl(193, 76%, 65%)',
        '#ffffff',
      },
      background = 'hsl(220, 15%, 10%)',
      foreground = 'hsl(220, 40%, 95%)',
      cursor_bg = 'hsl(220, 40%, 75%)',
      cursor_border = 'hsl(220, 40%, 75%)',
      cursor_fg = 'hsl(220, 15%, 10%)',
      selection_bg = 'hsl(220, 15%, 20%)',
      selection_fg = 'hsl(220, 40%, 85%)',
      scrollbar_thumb = 'hsl(220, 15%, 20%)',
      split = 'hsl(220, 15%, 30%)',
      tab_bar = {
      },
    },
  },
  color_scheme = 'Seasons Winter',
  -- enable_scroll_bar = true,
  -- window_background_opacity = 0.95,

  window_frame = {
    -- Tab bar
    active_titlebar_bg = 'hsl(220, 15%, 20%)',
    inactive_titlebar_bg = 'hsl(220, 15%, 20%)',
  }
}
