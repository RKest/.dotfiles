require 'config'
require 'keymaps'
require 'autocommands'
require 'install-lazy'

require('lazy').setup {
    'tpope/vim-sleuth', -- Auto tabstop and shiftwidth
    -- 'github/copilot.vim', -- Copilot
    'direnv/direnv.vim', -- Direnv
    { 'supermaven-inc/supermaven-nvim', opts = {} },
    { 'chomosuke/typst-preview.nvim', lazy = false, version = '1.*', opts =
        {
            debug = true,
            open_cmd = "brave %s",
            dependencies_bin = {
              ['tinymist'] = "/home/max/.nix-profile/bin/tinymist",
              ['websocat'] = "/home/max/.nix-profile/bin/websocat"
            },
        },
    },

    -- Lsp
    require 'lsp.cmp',
    require 'lsp.lsp',

    -- Themes
    require 'themes.tokyonight',
    -- require 'themes.calvera',

    -- Plugins
    require 'plugins.which-key',
    -- require 'plugins.noice',
    require 'plugins.lualine',
    require 'plugins.tree-sitter',
    require 'plugins.nerdy',
    require 'plugins.oil',
    require 'plugins.tailwind-tools',
    require 'plugins.img-clip',
    require 'plugins.fzf-lua',
    require 'plugins.snacks',
}

