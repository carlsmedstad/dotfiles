vim.api.nvim_create_augroup("init", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = "init",
  pattern = "*",
  callback = function()
    vim.bo.expandtab = true
    vim.bo.shiftwidth = 2
    vim.bo.tabstop = 2
    vim.bo.textwidth = 79
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  group = "init",
  pattern = { "make" },
  callback = function()
    vim.bo.expandtab = false
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  group = "init",
  pattern = { "python" },
  callback = function()
    vim.bo.shiftwidth = 4
    vim.bo.tabstop = 4
  end,
})
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = "init",
  pattern = { "*PKGBUILD", "*PKGBUILD.in" },
  callback = function()
    vim.g.ale_sh_shellcheck_dialect = "bash"
    vim.g.ale_sh_shellcheck_exclusions = "2034,2128,2154,2155,2164"
  end,
})
