-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- Plugins
require("lazy").setup({
  spec = { { import = "plugins" } },
})

require("options")
require("keymaps")

vim.filetype.add({
  filename = {
    [".clang-tidy"] = "yaml",
    [".envrc"] = "sh",
    [".sqlfluff"] = "ini",
    ["vifmrc"] = "vim",
  },
  extension = {
    h = "c",
    props = "xml",
    service = "systemd",
    vifm = "vim",
  },
})

vim.api.nvim_create_augroup("init", {})
vim.api.nvim_create_autocmd("FileType", {
  group = "init",
  pattern = { "markdown", "gitcommit", "asciidoc" },
  callback = function()
    vim.bo.shiftwidth = 2
    vim.bo.tabstop = 2
    vim.wo.spell = true
  end,
})
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = "init",
  pattern = "*PKGBUILD",
  callback = function()
    vim.g.ale_sh_shellcheck_dialect = "bash"
    vim.g.ale_sh_shellcheck_exclusions = "2034,2128,2154,2164"
  end,
})
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = "init",
  pattern = "lua",
  callback = function()
    vim.bo.shiftwidth = 2
    vim.bo.tabstop = 2
  end,
})
