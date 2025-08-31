local M = {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,

  config = function ()
    require('snacks').setup {
      dashboard = { enabled = true },
      indent = { enabled = true },
      lazygit = {
        enabled = true,
        configure = true,
      },
      picker = {
        enabled = true,

        actions = {
          stopinsert = function (picker)
            picker:norm(function() end)
          end,
        },

        win = {
          input = {
            keys = {
              ["<esc>"] = { "close", mode = { "n", "i" } },
              ["<c-c>"] = { "stopinsert", mode = { "i" } },
            }
          }
        }
      },
    }

    vim.keymap.set('n', '<leader>g', require('snacks').lazygit.open, { desc = "Open Lazy[G]it" })
    vim.keymap.set('n', '<leader>f', require('snacks').picker.files, { desc = "[S]earch [F]iles" })
    vim.keymap.set('n', '<leader>sn', function() require('snacks').picker.files {
      finder = "files",
      format = "file",
      supports_live = true,
      cwd = "~/.dotfiles",
    } end , { desc = "[S]earch [N]eovim Files" })
    vim.keymap.set('n', '<leader><leader>', function () require('snacks').picker.buffers { current = false } end, { desc = '[ ] Find existing buffers' })
    vim.keymap.set('n', '<leader>sc', require('snacks').picker.command_history, { desc = '[S]earch [C]ommands' })
    vim.keymap.set('n', '<leader>sg', function () require('snacks').picker.grep { need_search = false } end, { desc = '[S]earch [G]rep' })
    vim.keymap.set('n', '<leader>sh', require('snacks').picker.help, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>ds', require('snacks').picker.lsp_symbols, { desc = 'Search [D]ocument [S]ymbols' })
    vim.keymap.set('n', '<leader>ss', require('snacks').picker.pickers, { desc = '[S]earch [S]search' })
    vim.keymap.set('n', '<leader>s.', require('snacks').picker.recent, { desc = "[S]earch recent" })
    vim.keymap.set('n', 'gd', require('snacks').picker.lsp_definitions, { desc = '[G]o to [D]efinition' })
    vim.keymap.set('n', 'gr', require('snacks').picker.lsp_references, { desc = '[G]oto [R]eferences' })
    vim.keymap.set('n', 'gI', require('snacks').picker.lsp_implementations, { desc = '[G]oto [I]implementations' })
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = '[C]ode [A]ctions' })
  end
}

return M
