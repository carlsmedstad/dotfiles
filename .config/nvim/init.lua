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

vim.filetype.add({
  filename = {
    [".clang-tidy"] = "yaml",
    [".envrc"] = "sh",
    [".sqlfluff"] = "ini",
    ["vifmrc"] = "vim",
  },
  extension = {
    h = "c",
    mail = "mail",
    props = "xml",
    service = "systemd",
    vifm = "vim",
  },
})

require("options")
require("keymaps")
require("autocommands")
