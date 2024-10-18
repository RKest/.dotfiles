require 'config'
require 'keymaps'
require 'autocommands'
require 'install-lazy'

require('lazy').setup {
    'tpope/vim-sleuth', -- Auto tabstop and shiftwidth

    require 'themes.tokyonight',
    require 'plugins.neo-tree',
    require 'plugins.telescope',
    require 'lsp.cmp',
    require 'lsp.lsp',
}
