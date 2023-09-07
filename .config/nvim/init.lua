-- luacheck: globals vim
-- luacheck: max_line_length 120

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
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      vim.keymap.set("n", "<leader>c", ":ColorizerToggle<CR>", { silent = true })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "awk",
          "bash",
          "bicep",
          "c",
          "cmake",
          "comment",
          "cpp",
          "diff",
          "dockerfile",
          "dot",
          "git_config",
          "git_rebase",
          "gitattributes",
          "gitcommit",
          "gitignore",
          "go",
          "html",
          "http",
          "hurl",
          "ini",
          "javascript",
          "jq",
          "json",
          "lua",
          "luadoc",
          "make",
          "markdown",
          "markdown_inline",
          "meson",
          "python",
          "regex",
          "rst",
          "sql",
          "toml",
          "typescript",
          "vim",
          "vimdoc",
          "vue",
          "yaml",
        },
        highlight = { enable = true, additional_vim_regex_highlighting = false },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
          },
        },
        indent = { enable = true },
      })
      vim.keymap.set(
        "n",
        "<leader>t",
        ":lua print(require('nvim-treesitter.ts_utils').get_node_at_cursor())<CR>",
        { silent = true }
      )
    end,
  },

  { "tpope/vim-commentary" }, -- mappings for commenting code
  { "tpope/vim-fugitive" }, -- git plugin
  { "tpope/vim-surround" }, -- mappings for paranthesis, brackets etc.
  { "tpope/vim-repeat" }, -- make . work for plugins
  { "farmergreg/vim-lastplace" }, -- save cursor pos between sessions

  -- VCS info
  {
    "mhinz/vim-signify",
    config = function()
      -- move through git hunks
      vim.keymap.set("n", "<M-j>", "<plug>(signify-next-hunk)", {})
      vim.keymap.set("n", "<M-k>", "<plug>(signify-prev-hunk)", {})
    end,
  },

  -- fancier statusline
  {
    "vim-airline/vim-airline",
    config = function()
      vim.g.airline_theme = "catppuccin"

      if vim.env.DISPLAY ~= nil then
        -- Looks horrible with ttf-nerd-fonts-symbols-mono installed
        -- vim.g.airline_powerline_fonts = 1
        vim.g.airline_symbols_ascii = 1
      else
        vim.g.airline_symbols_ascii = 1
      end

      vim.api.nvim_set_var("airline#extensions#tabline#enabled", 1)
      vim.api.nvim_set_var("airline#extensions#ale#enabled", 1)
      vim.g.airline_section_z = "%3p%% %4l:%3v" -- line/column number section
    end,
  },

  { "vim-airline/vim-airline-themes" },

  -- colorscheme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },

  -- async syntax checker
  {
    "dense-analysis/ale",
    config = function()
      vim.g.ale_linters = {
        PKGBUILD = {
          "shellcheck",
        },
        c = {
          "clangd",
        },
        cpp = {
          "clangd",
          "cppcheck",
        },
        bicep = {
          "az_bicep",
        },
        go = {
          "golangci-lint",
        },
        typescript = {
          "eslint",
          "tsserver",
        },
      }
      vim.g.ale_fixers = {
        PKGBUILD = { "shfmt" },
        cmake = { "cmakeformat" },
        cpp = { "clang-format" },
        css = { "prettier" },
        go = { "gofmt" },
        html = { "prettier" },
        javascript = { "prettier" },
        json = { "jq" },
        lua = { "stylua" },
        python = { "black", "isort" },
        rust = { "rustfmt" },
        sh = { "shfmt" },
        sql = { "sqlfluff" },
        swift = { "swiftformat" },
        typescript = { "prettier" },
        vue = { "prettier" },
        ["*"] = { "remove_trailing_lines", "trim_whitespace" },
      }

      vim.g.ale_use_neovim_diagnostics_api = 1
      vim.g.ale_rust_rls_executable = "rust-analyzer"

      vim.g.ale_c_build_dir = "build"
      vim.g.ale_c_clangd_options = "--clang-tidy"

      vim.g.ale_sh_shellcheck_change_directory = 0
      vim.g.ale_sh_shfmt_options = "--binary-next-line --space-redirects --indent 2"

      vim.g.ale_lint_on_text_changed = 0
      vim.g.ale_echo_msg_format = "[%linter%] %code:% %s"

      -- walk through errors
      vim.keymap.set("n", "<C-k>", "<Plug>(ale_previous_wrap)")
      vim.keymap.set("n", "<C-j>", "<Plug>(ale_next_wrap)")

      -- go to definition
      vim.keymap.set("x", "<leader>g", ":ALEGoToDefinition<CR>")
      vim.keymap.set("n", "<leader>g", ":ALEGoToDefinition<CR>")

      -- run linter
      vim.keymap.set("n", "<leader>l", ":ALELint<CR>")
      vim.keymap.set("n", "<leader>l", ":ALELint<CR>")

      -- run linter
      vim.keymap.set("n", "<leader>f", ":ALEFix<CR>")
      vim.keymap.set("n", "<leader>f", ":ALEFix<CR>")
    end,
  },

  -- fuzzy finding
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      vim.keymap.set("n", "<M-c>", function()
        require("fzf-lua").files()
      end, { silent = true })
    end,
  },

  -- copilot
  { "github/copilot.vim" },

  -- chatgpt
  {
    "jackMort/ChatGPT.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("chatgpt").setup()
    end,
  },
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
    props = "xml",
    service = "systemd",
    vifm = "vim",
  },
})

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
vim.o.colorcolumn = "+2,+4" -- highlighted columns to show too long lines

vim.o.list = true
vim.o.showbreak = "↪"
vim.o.listchars = "nbsp:␣,trail:•,extends:⟩,precedes:⟨,tab:  ,"
vim.o.expandtab = true
vim.o.textwidth = 79
vim.o.shiftwidth = 2
vim.o.tabstop = 2

vim.o.tags = "./.tags;/" -- look for tags file from pwd to root

vim.api.nvim_create_augroup("init", {})
vim.api.nvim_create_autocmd("FileType", {
  group = "init",
  pattern = "python,java,rust,go",
  callback = function()
    vim.bo.shiftwidth = 4
    vim.bo.tabstop = 4
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  group = "init",
  pattern = "sql",
  callback = function()
    vim.bo.commentstring = "-- %s"
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  group = "init",
  pattern = "go",
  callback = function()
    vim.bo.expandtab = false
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  group = "init",
  pattern = "asciidoc",
  callback = function()
    vim.bo.commentstring = "//\\ %s"
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  group = "init",
  pattern = "markdown",
  callback = function()
    vim.wo.spell = true
    vim.bo.tabstop = 2
    vim.bo.shiftwidth = 2
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  group = "init",
  pattern = "gitcommit",
  callback = function()
    vim.wo.spell = true
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  group = "init",
  pattern = "PKGBUILD",
  callback = function()
    vim.g.ale_sh_shellcheck_dialect = "bash"
    vim.g.ale_sh_shellcheck_exclusions = "2034,2128,2154,2164"
  end,
})

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
