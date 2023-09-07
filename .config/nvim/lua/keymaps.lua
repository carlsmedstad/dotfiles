-- bufswitch remaps for consistency with vimium
vim.keymap.set("n", "<C-n>", "<S-j>")
vim.keymap.set("n", "<C-m>", "<S-k>")
vim.keymap.set("n", "<S-j>", ":bprev<CR>", { silent = true })
vim.keymap.set("n", "<S-k>", ":bnext<CR>", { silent = true })

-- move through display lines instead of actual lines
vim.keymap.set("n", "j", [[v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj']], { expr = true })
vim.keymap.set("n", "k", [[v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk']], { expr = true })
vim.keymap.set("n", "j", [[v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj']], { expr = true })
vim.keymap.set("n", "k", [[v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk']], { expr = true })

-- exit insert mode in terminal with Esc
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

-- get syntax higlight group under pointer
vim.keymap.set("n", "<leader>h", ':echo synIDattr(synID(line("."),col("."),1),"name")<CR>', { silent = true })

-- remove duplicate newlines
vim.keymap.set("v", "<leader>s", ":s/\\n\\n/\\r<CR> :noh<CR>", { silent = true })

-- one word per line
vim.keymap.set("v", "<leader>w", ":s/\\s\\+/\\r/g<CR> :noh<CR>", { silent = true })

-- toggle spell checking
vim.keymap.set("n", "<leader>s", function()
  vim.o.spell = not vim.o.spell
end, { silent = true })

-- sort buffer or marked
vim.keymap.set("n", "<leader>o", "ggVG:'<,'>sort<CR>", { silent = true })
vim.keymap.set("v", "<leader>o", ":'<,'>sort<CR>", { silent = true })
