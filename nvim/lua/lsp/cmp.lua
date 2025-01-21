local M = { -- Autocompletion
  'saghen/blink.cmp',
  -- 'hrsh7th/nvim-cmp',
  dependencies = { 'rafamadriz/friendly-snippets' },
  build = 'cargo +nightly build --release',

  opts = {
    keymap = { preset = 'enter' },
    sources = {
      default = { 'lsp', 'path', 'snippets' },
      cmdline = {},
    },
  },
  opts_extend = { "sources.default" }
}

return M
