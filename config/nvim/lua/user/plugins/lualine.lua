local signs = require("user.plugins.lsp.diagnostics").signs

return {
  "nvim-lualine/lualine.nvim",
  event = "VimEnter",
  dependencies = {
    "folke/tokyonight.nvim",
    "SmiteshP/nvim-navic",
    "nvim-tree/nvim-web-devicons",
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
          color = { fg = "#ff9e64" },
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
