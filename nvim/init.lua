require 'config'
require 'keymaps'
require 'autocommands'
require 'install-lazy'

require('lazy').setup {
    'tpope/vim-sleuth', -- Auto tabstop and shiftwidth
    'github/copilot.vim',
    { 'mrcjkb/rustaceanvim', version = '^5', lazy = false },

    require 'themes.tokyonight',
    require 'plugins.neo-tree',
    require 'plugins.telescope',
    require 'plugins.which-key',
    require 'plugins.noice',
    require 'plugins.lualine',
    require 'lsp.cmp',
    require 'lsp.lsp',
    require 'plugins.tmux-navigator',
    require 'plugins.tree-sitter'
}
