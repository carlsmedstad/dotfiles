return {
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      vim.keymap.set("n", "<leader>c", ":ColorizerToggle<CR>", { silent = true })
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
}
