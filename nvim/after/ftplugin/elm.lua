vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = { '*.elm' },
  group = vim.api.nvim_create_augroup('rkest-elm-fmt', { clear = true }),
  callback = function()
	vim.cmd 'silent !elm-format % --yes'
  end,
})
