return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile", "InsertEnter" },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
    }

    local cwd = vim.loop.cwd()
    local maybe_config_path = vim.fn.fnamemodify(cwd .. "/eslint.config.mjs", ":p")
    local has_flat_config = vim.fn.filereadable(maybe_config_path) == 1

    if has_flat_config then
      local eslint_d = lint.linters.eslint_d
      eslint_d.args = vim.tbl_extend("force", {
        "--config",
        function()
          return vim.fn.getcwd() .. "/eslint.config.mjs"
        end,
      }, eslint_d.args)
      eslint_d.env = {
        ["ESLINT_USE_FLAT_CONFIG"] = "true",
        ["CORE_D_TITLE"] = "eslint_d_flat",
        ["CORE_D_DOTFILE"] = ".eslint_d_flat",
        ["PWD"] = cwd,
        ["SHELL"] = os.getenv("SHELL"),
        ["TMPDIR"] = os.getenv("TMPDIR"),
        ["HOME"] = os.getenv("HOME"),
      }
    end

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
    vim.api.nvim_create_autocmd({ "TextChanged", "InsertLeave", "BufEnter" }, {
      group = lint_augroup,
      callback = function()
        require("lint").try_lint()
      end,
    })

    vim.api.nvim_create_user_command("CheckEslintFlatConfig", function()
      local root = vim.uv.cwd()

      if
        vim.fn.filereadable(root .. "/eslint.config.js") == 1
        or vim.fn.filereadable(root .. "/eslint.config.mjs") == 1
        or vim.fn.filereadable(root .. "/eslint.config.cjs") == 1
        or vim.fn.filereadable(root .. "/eslint.config.ts") == 1
        or vim.fn.filereadable(root .. "/eslint.config.mts") == 1
        or vim.fn.filereadable(root .. "/eslint.config.cts") == 1
      then
        vim.cmd(":!ESLINT_USE_FLAT_CONFIG=true eslint_d restart")
        vim.cmd.e()
      else
        vim.cmd(":!ESLINT_USE_FLAT_CONFIG= eslint_d restart")
        vim.cmd.e()
      end
    end, {})
  end,
}
