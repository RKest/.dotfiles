-- Highlight, edit, and navigate code
local M = {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter.install').prefer_git = true
    require('nvim-treesitter.configs').setup {
      ensure_installed = { 'php', 'go', 'bash', 'c', 'cpp', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc', 'nix' },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'ruby', 'html' },
      },
      indent = { enable = true, disable = { 'ruby' } },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<BS>",
          node_incremental = "<BS>",
          scope_incremental = "<C-BS>",
          node_decremental = "<S-BS>",
        },
      },
    }
  end,
}

return M
