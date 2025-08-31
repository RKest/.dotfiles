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
          -- scope_incremental = "<BS>",
          -- node_decremental = "<S-BS>",
        },
      },
    }

    local next = function ()
      local node_text = function (node)
        if node == nil then return "nil" end
        local sr, sc, er, ec = node:range()
        return table.concat(vim.api.nvim_buf_get_text(vim.api.nvim_get_current_buf(), sr, sc, er, ec, {}), "\n")
      end

      local ts_utils = require('nvim-treesitter.ts_utils')
      local curr_node = ts_utils.get_node_at_cursor(0)
      if curr_node == nil then return end
      local sr, sc, er, ec = curr_node:range()

      local curr_node_text = table.concat(vim.api.nvim_buf_get_text(vim.api.nvim_get_current_buf(), sr, sc, er, ec, {}), "\n")
      local info = "curr_node: " .. curr_node_text .. "\n"

      for i = 1,curr_node:child_count() do
        info = info .. "child[".. i .. "]: " .. node_text(curr_node:child(i - 1)) .. "\n"
      end

      -- local next_node = curr_node:child_count()
      -- if next_node == nil then return end
      -- sr, sc, er, ec = next_node:range()
      -- local next_node_text = table.concat(vim.api.nvim_buf_get_text(vim.api.nvim_get_current_buf(), sr, sc, er, ec, {}), "\n")

      print(info)
    end

    vim.keymap.set("n", "<M-n>", next, { desc = "[N]ext sibling" })

  end,
}

return M
