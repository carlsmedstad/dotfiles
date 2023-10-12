-- async syntax checker
return {
  {
    "dense-analysis/ale",
    config = function()
      vim.g.ale_linters = {
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
        cmake = { "cmakeformat" },
        cpp = { "clang-format" },
        css = { "prettier" },
        go = { "gofmt" },
        html = { "prettier" },
        javascript = { "prettier" },
        json = { "jq" },
        lua = { "stylua" },
        python = { "black", "ruff" },
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
}
