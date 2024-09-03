-- Fuzzy Finder (files, lsp, etc)
local M = {
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  branch = '0.1.x',
  dependencies = require 'plugins.telescope.dependencies',
  config = function()
    -- Keymaps to use while in Telescope to show available options:
    --  - Insert mode: <c-/>
    --  - Normal mode: ?
    require('telescope').setup(require 'plugins.telescope.setup')

    -- Enable Telescope extensions if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')

    require 'plugins.telescope.keymap'
  end,
}
return M
