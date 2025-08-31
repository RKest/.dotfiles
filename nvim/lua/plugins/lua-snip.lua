return {
	"L3MON4D3/LuaSnip",
	-- follow latest release.
	version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
	-- install jsregexp (optional!).
	build = "make install_jsregexp",

  init = function ()
    vim.keymap.set({'i'}, '<C-e>', function () require('luasnip').expand() end, { desc = "Expand", silent = true  })
    vim.keymap.set({'i', 's'}, '<C-j>', function () require('luasnip').jump(1) end, { desc = "Next snippet insert", silent = true  })
    vim.keymap.set({'i', 's'}, '<C-k>', function () require('luasnip').jump(-1) end, { desc = "Previous snippet insert", silent = true })

    require('luasnip').setup { enable_autosnippets = true }
    require('luasnip.loaders.from_lua').load { paths = '~/.dotfiles/nvim/lua/snippets/' }
  end,
}
