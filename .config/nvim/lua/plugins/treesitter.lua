return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup({})

      -- Install parsers (replaces ensure_installed)
      local installed = require("nvim-treesitter.config").get_installed()
      local wanted = {
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
        "gomod",
        "gosum",
        "helm",
        "html",
        "http",
        "hurl",
        "ini",
        "javascript",
        "jq",
        "json",
        "jsonnet",
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
      }
      local to_install = vim.iter(wanted)
        :filter(function(p)
          return not vim.tbl_contains(installed, p)
        end)
        :totable()
      if #to_install > 0 then
        require("nvim-treesitter").install(to_install)
      end
    end,
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          pcall(vim.treesitter.start)
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },
}
