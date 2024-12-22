vim.bo.makeprg = 'dotnet run'
vim.bo.errorformat = '%f(%l\\,%c): %trror %m'
vim.bo.commentstring = '// %s'

vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = { '*.fs' },
  group = vim.api.nvim_create_augroup('rkest-fsharp-fmt', { clear = true }),
  callback = function()
      vim.lsp.buf.format()
  end,
})
