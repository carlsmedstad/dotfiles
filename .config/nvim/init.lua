-- luacheck: globals vim
-- luacheck: max_line_length 200

-- Bootstrap packer.nvim
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({ "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path })
  vim.api.nvim_command("packadd packer.nvim")
end

-- Plugins
require("packer").startup(function()
  -- luacheck: push globals use
  use({
    "wbthomason/packer.nvim",
    config = function()
      vim.cmd([[
        augroup packerUserConfig
          autocmd!
          autocmd BufWritePost init.lua source <afile> | PackerCompile
        augroup end
      ]])
    end,
  })

  use("tpope/vim-commentary") -- mappings for commenting code
  use("tpope/vim-fugitive") -- git plugin
  use("tpope/vim-surround") -- mappings for paranthesis, brackets etc.
  use("tpope/vim-repeat") -- make . work for plugins
  use("farmergreg/vim-lastplace") -- save cursor pos between sessions

  use("editorconfig/editorconfig-vim") -- Editorconfig support

  -- VCS info
  use({
    "mhinz/vim-signify",
    config = function()
      -- move through git hunks
      vim.api.nvim_set_keymap("n", "<M-j>", "<plug>(signify-next-hunk)", {})
      vim.api.nvim_set_keymap("n", "<M-k>", "<plug>(signify-prev-hunk)", {})
    end,
  })

  -- colorizer
  use({
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({ "*" }, { names = false })
    end,
  })

  -- measure start-up time
  use({
    "henriquehbr/nvim-startup.lua",
    config = function()
      require("nvim-startup").setup()
    end,
  })

  -- fancier statusline
  use({
    "vim-airline/vim-airline",
    config = function()
      vim.g.airline_theme = "solarized"

      if vim.env.DISPLAY ~= nil then
        vim.g.airline_powerline_fonts = 1
      else
        vim.g.airline_symbols_ascii = 1
      end

      vim.api.nvim_set_var("airline#extensions#tabline#enabled", 1)
      vim.api.nvim_set_var("airline#extensions#ale#enabled", 1)
      vim.g.airline_section_z = "%3p%% %4l:%3v" -- line/column number section
    end,
  })
  use("vim-airline/vim-airline-themes")

  -- colorscheme
  use({
    "lifepillar/vim-solarized8",
    config = function()
      vim.cmd("colorscheme solarized8")
    end,
  })

  -- async syntax checker
  use({
    "dense-analysis/ale",
    config = function()
      vim.g.ale_rust_rls_executable = "rust-analyzer"
      vim.g.ale_linters = {
        cpp = {
          "clangd",
        },
      }
      vim.g.ale_fixers = {
        PKGBUILD = { "shfmt" },
        cmake = { "cmakeformat" },
        cpp = { "clang-format" },
        go = { "gofmt" },
        lua = { "stylua" },
        python = { "black" },
        rust = { "rustfmt" },
        sh = { "shfmt" },
        swift = { "swiftformat" },
        ["*"] = { "remove_trailing_lines", "trim_whitespace" },
      }
      vim.g.ale_lint_on_text_changed = 0
      vim.g.ale_echo_msg_format = "[%linter%] %code:% %s"

      -- walk through errors
      vim.api.nvim_set_keymap("n", "<C-k>", "<Plug>(ale_previous_wrap)", {})
      vim.api.nvim_set_keymap("n", "<C-j>", "<Plug>(ale_next_wrap)", {})

      -- go to definition
      vim.api.nvim_set_keymap("x", "<leader>g", ":ALEGoToDefinition<CR>", {})
      vim.api.nvim_set_keymap("n", "<leader>g", ":ALEGoToDefinition<CR>", {})

      -- run linter
      vim.api.nvim_set_keymap("n", "<leader>l", ":ALELint<CR>", {})
      vim.api.nvim_set_keymap("n", "<leader>l", ":ALELint<CR>", {})

      -- run linter
      vim.api.nvim_set_keymap("n", "<leader>f", ":ALEFix<CR>", {})
      vim.api.nvim_set_keymap("n", "<leader>f", ":ALEFix<CR>", {})
    end,
  })

  -- ctags auto-generation
  use({
    "craigemery/vim-autotag",
    config = function()
      vim.g.autotagTagsFile = ".tags"
    end,
  })

  -- syntax highlighting
  use({
    "sheerun/vim-polyglot",
    setup = function()
      vim.g.polyglot_disabled = { "markdown", "sh" }
    end,
  })

  use({
    "ibhagwan/fzf-lua",
    requires = { "kyazdani42/nvim-web-devicons" },
    setup = function()
      vim.api.nvim_set_keymap("n", "<M-c>", "<cmd>lua require('fzf-lua').files()<CR>", { noremap = true, silent = true })
    end,
  })

  -- luacheck: pop
end)

vim.g.mapleader = ","
vim.g.markdown_fenced_languages = { "json", "yaml", "sh", "bash=sh", "python", "ini=dosini", "vim", "lua" }

if vim.env.COLORTERM == "truecolor" then
  vim.opt.termguicolors = true
end

vim.o.clipboard = "unnamedplus" -- enables copy/paste from/to vim
vim.o.undofile = true -- saves undo-history between sessions
vim.o.mouse = "a" -- Enable scrolling with mouse-wheel

vim.o.hidden = true -- buffer stays open when window is closed
vim.o.equalalways = false -- splitting won't default to a 50/50 ratio

vim.opt.sessionoptions:remove("tabpages") -- only save current tab in session
vim.opt.sessionoptions:remove("help") -- don't save help windows in session

vim.o.autoindent = true
vim.o.smartindent = true -- autoindenting when starting a new line
vim.o.wildmode = "longest,full" -- tab-completion
vim.o.ignorecase = true
vim.o.smartcase = true -- ignore case except if uppercase in search phrase

vim.o.foldenable = true -- folds enabled by default
vim.o.foldmethod = "marker" -- define folds in code with {{{}}}

vim.o.number = true
vim.o.numberwidth = 5 -- line-number-bar, with width = 3 digits + padding
vim.o.cursorline = true -- highlight the line under the cursor
vim.o.colorcolumn = "+2,+4" -- highlighted columns to show too long lines

vim.o.list = true
vim.o.showbreak = "↪"
vim.o.listchars = "nbsp:␣,trail:•,extends:⟩,precedes:⟨,tab:  ,"
vim.o.expandtab = true
vim.o.tw = 79
vim.o.sw = 2
vim.o.ts = 4

vim.o.tags = "./.tags;/" -- look for tags file from pwd to root

-- set options for different languages
vim.api.nvim_command("augroup languageSpecific")
vim.api.nvim_command("autocmd!")
vim.api.nvim_command("autocmd FileType swift set tw=119 sw=4 ts=4")
vim.api.nvim_command("autocmd FileType python,java,sql,rust set tw=79 sw=4 ts=4")
vim.api.nvim_command("autocmd FileType go set tw=79 sw=4 ts=4 noet")
vim.api.nvim_command("autocmd FileType c,cc,h set et tw=79 sw=2 ts=2")
vim.api.nvim_command("autocmd FileType asciidoc setlocal commentstring=//\\ %s")
vim.api.nvim_command("autocmd FileType html set tw=120")
vim.api.nvim_command("augroup END")

vim.api.nvim_command("augroup fileDetection")
vim.api.nvim_command("autocmd BufNewFile,BufRead .mrconfig set filetype=cfg tw=0")
vim.api.nvim_command("autocmd BufNewFile,BufRead PKGBUILD set filetype=PKGBUILD tw=0 syntax=sh")
vim.api.nvim_command("augroup END")

-- toggle spell checking
vim.api.nvim_set_keymap("n", "<leader>s", ":set spell!<CR>", { noremap = true, silent = true })

-- bufswitch remaps for consistency with vimium
vim.api.nvim_set_keymap("n", "<C-n>", "<S-j>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-m>", "<S-k>", { noremap = true })
vim.api.nvim_set_keymap("n", "<S-j>", ":bprev<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<S-k>", ":bnext<CR>", { noremap = true, silent = true })

-- move through display lines instead of actual lines
vim.api.nvim_set_keymap("n", "j", [[v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj']], { noremap = true, expr = true })
vim.api.nvim_set_keymap("n", "k", [[v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk']], { noremap = true, expr = true })
vim.api.nvim_set_keymap("n", "j", [[v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj']], { noremap = true, expr = true })
vim.api.nvim_set_keymap("n", "k", [[v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk']], { noremap = true, expr = true })

-- exit intsert mode in terminal with Esc
vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", {})

-- get syntax higlight group under pointer
vim.api.nvim_set_keymap("n", "<leader>h", ':echo synIDattr(synID(line("."),col("."),1),"name")<CR>', { noremap = true, silent = true })
