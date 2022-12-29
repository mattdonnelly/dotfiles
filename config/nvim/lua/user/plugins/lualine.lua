local signs = require("user.plugins.lsp.diagnostics").signs
local lsp_fg = "#ff9e64"

return {
  "nvim-lualine/lualine.nvim",
  event = "VimEnter",
  dependencies = {
    "folke/tokyonight.nvim",
    "SmiteshP/nvim-navic",
    "nvim-tree/nvim-web-devicons",
    "arkav/lualine-lsp-progress",
  },
  config = {
    options = {
      theme = "auto",
      section_separators = {},
      component_separators = {},
      icons_enabled = true,
      globalstatus = true,
      disabled_filetypes = {
        statusline = {
          "dashboard",
          "lazy",
          "NvimTree",
          "dashboard",
          "dbui",
          "packer",
          "startify",
          "fugitive",
          "fugitiveblame",
          "neo-tree",
        },
      },
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch" },
      lualine_c = {
        {
          "diff",
          symbols = {
            added = " ",
            modified = " ",
            removed = " ",
          },
        },
        { "filetype", icon_only = true, padding = { left = 1, right = 0 } },
        { "filename", path = 1, symbols = { modified = "", unnamed = "", readonly = "" } },
        {
          "lsp_progress",
          display_components = { "lsp_client_name", "spinner" },
          spinner_symbols = { "⠋", "⠙", "⠸", "⠴", "⠦", "⠇" },
          colors = {
            lsp_client_name = lsp_fg,
            spinner = lsp_fg,
            use = true,
          },
        },
        {
          function()
            local navic = require("nvim-navic")
            local ret = navic.get_location()
            return ret:len() > 2000 and "navic error" or ret
          end,
          cond = function()
            if package.loaded["nvim-navic"] then
              local navic = require("nvim-navic")
              return navic.is_available()
            end
          end,
          color = { fg = lsp_fg },
        },
      },
      lualine_x = {
        {
          "diagnostics",
          sources = { "nvim_diagnostic" },
          symbols = {
            error = signs.Error,
            warn = signs.Warning,
            info = signs.Information,
            hint = signs.Hint,
          },
        },
      },
      lualine_y = { "location", "progress" },
      lualine_z = {},
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
    extensions = {
      "neo-tree",
      "nvim-dap-ui",
      "quickfix",
      "toggleterm",
    },
  },
}
