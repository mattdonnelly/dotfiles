return {
  "nvim-neo-tree/neo-tree.nvim",
  cmd = "Neotree",
  version = "v3.x",
  dependencies = {
    "antosha417/nvim-lsp-file-operations",
  },
  keys = {
    { "<leader>n", "<cmd>Neotree toggle<cr>", "NeoTree" },
  },
  config = function()
    local signs = require("user.plugins.lsp.diagnostics").signs

    require("neo-tree").setup({
      default_component_configs = {
        diagnostics = {
          symbols = {
            error = signs.Error,
            warn = signs.Warning,
            info = signs.Information,
            hint = signs.Hint,
          },
        },
      },
      filesystem = {
        follow_current_file = {
          enabled = true,
        },
        hijack_netrw_behavior = "open_current",
        filtered_items = {
          hide_dotfiles = false,
        },
      },
      event_handlers = {
        {
          event = "file_opened",
          handler = function()
            require("neo-tree").close_all()
          end,
        },
      },
      window = {
        mappings = {
          ["<tab>"] = function(state)
            local node = state.tree:get_node()
            if require("neo-tree.utils").is_expandable(node) then
              state.commands["toggle_node"](state)
            else
              state.commands["open"](state)
              vim.cmd("Neotree reveal")
            end
          end,
        },
      },
    })
  end,
}
