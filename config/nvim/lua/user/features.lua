-- Toggles for developer tooling (language servers, treesitter parsers, etc.)
-- so this config can run on machines that don't have them installed.
--
-- Everything is enabled by default. To change that on a given machine, set
-- flags in ~/.config/nvim/lua/local/init.lua (loaded before plugins):
--
--   vim.g.dev_tools = false                  -- disable all developer tooling
--   vim.g.features = { treesitter = true }   -- ...then re-enable individual features
--
-- Or for a single session from the shell:
--
--   NVIM_DEV_TOOLS=0 nvim
--
-- Disabled plugins are not installed or loaded by lazy.nvim.

local function env_flag(name)
  local value = vim.env[name]
  if value == nil or value == "" then
    return nil
  end
  return not vim.tbl_contains({ "0", "false", "off", "no" }, value:lower())
end

local dev_tools = env_flag("NVIM_DEV_TOOLS")
if dev_tools == nil then
  dev_tools = vim.g.dev_tools ~= false
end

local defaults = {
  lsp = dev_tools, -- nvim-lspconfig, mason, language-specific LSP plugins
  treesitter = dev_tools, -- nvim-treesitter and its parsers
  formatting = dev_tools, -- conform.nvim + external formatters
  debugging = dev_tools, -- nvim-dap and adapters
  testing = dev_tools, -- neotest and adapters
  copilot = dev_tools and vim.g.copilot_enabled == true,
  claude = dev_tools and vim.fn.executable("claude") == 1, -- claudecode.nvim, needs the Claude Code CLI
}

local overrides = vim.g.features or {}

local M = {}
for name, default in pairs(defaults) do
  if overrides[name] ~= nil then
    M[name] = overrides[name]
  else
    M[name] = default
  end
end

-- neotest discovers tests using treesitter parsers
M.testing = M.testing and M.treesitter

return M
