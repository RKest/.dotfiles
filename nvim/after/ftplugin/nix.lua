vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = { '*.nix' },
  group = vim.api.nvim_create_augroup('rkest-nix-fmt', { clear = true }),
  callback = function()
		vim.cmd 'silent !alejandra -qq %'
  end,
});

vim.bo.tabstop = 2
vim.bo.shiftwidth = 2
