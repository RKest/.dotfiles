require 'config'
require 'keymaps'
require 'autocommands'
require 'install-lazy'

require('lazy').setup {
    'tpope/vim-sleuth', -- Auto tabstop and shiftwidth
    'github/copilot.vim', -- Copilot
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
    {
      "folke/lazydev.nvim",
      ft = "lua",
      opts = {
        library = {
          -- See the configuration section for more details
          -- Load luvit types when the `vim.uv` word is found
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      },
    },

    -- Lsp
    require 'lsp.cmp',
    require 'lsp.lsp',

    -- Themes
    require 'themes.tokyonight',

    -- Plugins
    require 'plugins.which-key',
    require 'plugins.lualine',
    require 'plugins.tree-sitter',
    require 'plugins.nerdy',
    require 'plugins.oil',
    require 'plugins.tailwind-tools',
    require 'plugins.img-clip',
    require 'plugins.snacks',
}

