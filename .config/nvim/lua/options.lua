if vim.env.COLORTERM == "truecolor" then
  vim.opt.termguicolors = true
end

vim.o.clipboard = "unnamedplus" -- enables copy/paste from/to vim
vim.o.undofile = true -- saves undo-history between sessions

vim.o.equalalways = false -- splitting won't default to a 50/50 ratio

vim.opt.sessionoptions:remove("tabpages") -- only save current tab in session
vim.opt.sessionoptions:remove("help") -- don't save help windows in session

vim.o.smartindent = true -- auto-indenting when starting a new line
vim.o.wildmode = "longest,full" -- tab-completion
vim.o.ignorecase = true
vim.o.smartcase = true -- ignore case except if uppercase in search phrase

vim.o.number = true
vim.o.numberwidth = 5 -- line-number-bar, with width = 3 digits + padding
vim.o.cursorline = true -- highlight the line under the cursor
vim.o.colorcolumn = "+1,+3" -- highlighted columns to show too long lines

vim.o.list = true
vim.o.showbreak = "↪"
vim.o.listchars = "nbsp:␣,trail:•,extends:⟩,precedes:⟨,tab:  ,"
vim.o.expandtab = true
vim.o.textwidth = 79
vim.o.shiftwidth = 2
vim.o.tabstop = 2
