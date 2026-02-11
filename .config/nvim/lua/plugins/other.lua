return {
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    init = function()
      vim.g.startuptime_tries = 10
    end,
  },

  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      vim.keymap.set("n", "<leader>c", ":ColorizerToggle<CR>", { silent = true })
    end,
  },

  { "tpope/vim-surround" },
  { "tpope/vim-repeat" },
  { "farmergreg/vim-lastplace" },

  {
    "tpope/vim-fugitive",
    lazy = true,
    cmd = { "Git" },
  },

  {
    "mhinz/vim-signify",
    config = function()
      -- move through git hunks
      vim.keymap.set("n", "<M-j>", "<plug>(signify-next-hunk)", {})
      vim.keymap.set("n", "<M-k>", "<plug>(signify-prev-hunk)", {})
    end,
  },

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

  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },

  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      vim.keymap.set("n", "<M-c>", function()
        require("fzf-lua").files()
      end, { silent = true })
    end,
  },

  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = {
          auto_trigger = true,
          keymap = {
            accept = "<C-f>",
            next = "<M-f>",
          },
        },
      })
    end,
  },

  { "towolf/vim-helm" },
}
