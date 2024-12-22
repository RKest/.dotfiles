return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons", "rktjmp/lush.nvim" },
  config = function()
    -- calling `setup` is optional for customization
    require("fzf-lua").setup {
      files = {
        fd_opts = "--type f --type d --hidden --exclude .git --no-follow",
        find_opts = "-L",
      },
    }

    vim.keymap.set('n', '<leader>sf', require('fzf-lua').files, { desc = "[S]earch [F]iles" });
    vim.keymap.set('n', '<leader>sn', function() require('fzf-lua').files { cwd = '~/.dotfiles' } end, { desc = '[S]earch [N]eovim files'})
    vim.keymap.set('n', '<leader><leader>', require('fzf-lua').buffers, { desc = '[ ] Find existing buffers'})
    vim.keymap.set('n', '<leader>sc', require('fzf-lua').command_history, { desc = '[S]earch [C]ommands'})
    vim.keymap.set('n', '<leader>sg', require('fzf-lua').grep_project, { desc = '[S]earch [G]rep'})
    vim.keymap.set('n', '<leader>ss', require('fzf-lua').builtin, { desc = '[S]earch [G]rep'})

    vim.keymap.set('n', '<leader>sp', function ()
      local path = require('fzf-lua.path')
      local projs_dir = "~/projs"
      require('fzf-lua').files {
        cmd = "ls -d */",
        cwd = projs_dir,
        actions = {
          ["default"] = function (selected)
            local file = path.entry_to_file(selected[1])
            local full_path = projs_dir .. '/' .. file.path
            vim.cmd('cd ' .. full_path)
            vim.notify('Changed directory to: ' .. full_path, vim.log.levels.INFO)
            require('fzf-lua').files { cwd = full_path }
          end
        },
      }
    end, { desc = "[S]witch [P]roject" })
  end
}
