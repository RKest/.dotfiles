require 'config'
require 'keymaps'
require 'autocommands'
require 'install-lazy'

require('lazy').setup {
    'tpope/vim-sleuth', -- Auto tabstop and shiftwidth
    'github/copilot.vim',

    { '2kabhishek/nerdy.nvim',
        dependencies = {
            'stevearc/dressing.nvim',
            'nvim-telescope/telescope.nvim',
        },
        cmd = 'Nerdy',
    },

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
