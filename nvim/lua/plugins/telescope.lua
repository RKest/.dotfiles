-- Fuzzy Finder (files, lsp, etc)

local dependencies = {
  'nvim-lua/plenary.nvim',
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make', -- Build fzf on instalation once
    cond = function() -- If make is available
      return vim.fn.executable 'make' == 1
    end,
  },
  { 'nvim-telescope/telescope-ui-select.nvim' },

  -- Pretty icons
  { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  -- Symbols
  { 'nvim-telescope/telescope-symbols.nvim' },
}

local M = {
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  branch = '0.1.x',
  dependencies = dependencies,
  config = function()
    require('telescope').setup {
	  defaults = {
	    -- file_ignore_patterns = { 'node_modules', 'venv', 'build' },
	    file_ignore_patterns = {},
	    mappings = {
	      i = {
		    ['<C-Down>'] = require('telescope.actions').cycle_history_next,
		    ['<C-Up>'] = require('telescope.actions').cycle_history_prev,
	      },
	    },
	  },
	  extensions = {
	    ['ui-select'] = {
	      require('telescope.themes').get_dropdown(),
	    },
	  },
	  pickers = {
	    find_files = {
	      hidden = true,
	    },
	  },
	}
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')

    local nkeyset = function (key, func, desc)
      vim.keymap.set('n', key, func, { desc = desc })
    end

    -- Telescope keymaps
    local builtin = require 'telescope.builtin' -- :help telescope.builtin
    nkeyset('<leader>sh', builtin.help_tags, '[S]earch [H]elp')
    -- nkeyset('<leader>sk', builtin.keymaps, '[S]earch [K]eymaps')
    -- nkeyset('<leader>sf', builtin.find_files, '[S]earch [F]iles')
    -- nkeyset('<leader>ss', builtin.builtin, '[S]earch [S]elect Telescope')
    nkeyset('<leader>sw', builtin.grep_string, '[S]earch current [W]ord')
    -- nkeyset('<leader>sg', builtin.live_grep, '[S]earch by [G]rep')
    nkeyset('<leader>sd', builtin.diagnostics, '[S]earch [D]iagnostics')
    nkeyset('<leader>sr', builtin.resume, '[S]earch [R]esume')
    nkeyset('<leader>s.', builtin.oldfiles, '[S]earch Recent Files ("." for repeat)')
    -- nkeyset('<leader><leader>', builtin.buffers, '[ ] Find existing buffers')
    -- nkeyset('<leader>sn', function() builtin.find_files { cwd = '~/.dotfiles' } end, '[S]earch [N]eovim files')
    -- nkeyset('<leader>sc', builtin.command_history, '[S]earch [C]ommands')

    vim.keymap.set('n', '<leader>sp', function()
      local projs_dir = '~/projs'

      require 'telescope.builtin'.find_files({
	  prompt_title = "Select Project Directory",
	  cwd = projs_dir,
	  find_command = { 'fd', '--type=d' ,'--maxdepth=1' },
	  attach_mappings = function(prompt_bufnr, map)
	      local actions = require('telescope.actions')
	      local action_state = require('telescope.actions.state')

	      local change_directory = function()
		  actions.close(prompt_bufnr)
		  local selection = action_state.get_selected_entry()
		  if selection then
		      local full_path = vim.fn.expand(selection[1])
		      vim.cmd('cd ' .. projs_dir .. '/' .. full_path)
		      vim.notify('Changed directory to: ' .. full_path, vim.log.levels.INFO)
		  end
	      end
	      map('i', '<CR>', change_directory)
	      map('n', '<CR>', change_directory)

	      return true
	  end
      })
    end, { desc = '[S]earch [P]rojects' })

 end,
}
return M
