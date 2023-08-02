return {
  {
    'NMAC427/guess-indent.nvim',
    event = {
      'BufReadPost',
      'BufNewFile',
    },
    config = true,
  },
  {
    'numToStr/Comment.nvim',
    opts = {
      pre_hook = function()
        require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()
      end,
    },
    keys = {
      { 'gc', mode = { 'n', 'x' }, desc = 'Line-comment keymap' },
      { 'gb', mode = { 'n', 'x' }, desc = 'Block-comment keymap' },
    },
  },
  {
    -- TODO: configure keymappings
    'ggandor/leap.nvim',
    keys = {
      { 's', mode = { 'n', 'x', 'o' }, desc = 'Leap forward to' },
      { 'S', mode = { 'n', 'x', 'o' }, desc = 'Leap backward to' },
      { 'gs', mode = { 'n', 'x', 'o' }, desc = 'Leap from windows' },
    },
    config = function()
      require('leap').add_default_mappings(true)
    end,
  },
  {
    'cschierig/twins.nvim',
    cond = util.frontend.vscode_disable(),
    event = {
      'BufReadPost',
      'BufNewFile',
    },
    config = true,
  },
}
