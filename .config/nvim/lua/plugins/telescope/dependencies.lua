local M = {
  'nvim-lua/plenary.nvim',
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make', -- Build fzf on instalation once
    cond = function() -- If make is available
      return vim.fn.executable 'make' == 1
    end,
  },
  { 'nvim-telescope/telescope-ui-select.nvim' },

  -- Pretty icons
  { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  -- Symbols
  { 'nvim-telescope/telescope-symbols.nvim' },
}
return M
