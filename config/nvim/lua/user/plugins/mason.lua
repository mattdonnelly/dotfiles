local M = {
  'williamboman/mason.nvim',
  dependencies = {
    'williamboman/mason-lspconfig.nvim'
  }
}

local servers = {
  'ember-language-server',
  'solargraph',
  'html-lsp',
  'css-lsp',
  'bash-language-server',
  'lua-language-server',
  'vim-language-server',
  'typescript-language-server',
}

local check = function()
  local mr = require('mason-registry')
  for _, server in ipairs(servers) do
    local p = mr.get_package(server)
    if not p:is_installed() then
      p:install()
    end
  end
end

M.config = function()
  require('mason').setup()
  check()
  require('mason-lspconfig').setup({
    automatic_installation = true,
  })
end

return M
