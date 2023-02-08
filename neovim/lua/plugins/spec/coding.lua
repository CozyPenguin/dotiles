local vim = vim
local map = util.map

return {
  {
    'NMAC427/guess-indent.nvim',
    event = {
      'BufReadPost',
      'BufNewFile'
    },
    config = true
  },
  {
    'numToStr/Comment.nvim',
    opts = {
      pre_hook = function()
        require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()
      end
    },
    keys = {
      { 'gc', mode={ 'n', 'x' }, desc='Line-comment keymap' },
      { 'gc', mode={ 'n', 'x' }, desc='Block-comment keymap' }
    }
  }
}
