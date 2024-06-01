return {
  "nvim-telescope/telescope.nvim",
  version = "0.1.4",
  cmd = { "Telescope" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-lua/plenary.nvim",
    "BurntSushi/ripgrep",
    "sharkdp/fd",
    "nvim-telescope/telescope-dap.nvim",
    "natecraddock/telescope-zf-native.nvim",
  },
  config = function()
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")
    local action_utils = require("telescope.actions.utils")

    local function single_or_multi_select(prompt_bufnr)
      local current_picker = action_state.get_current_picker(prompt_bufnr)
      local has_multi_selection = (next(current_picker:get_multi_selection()) ~= nil)

      if has_multi_selection then
        -- apply function to each selection
        action_utils.map_selections(prompt_bufnr, function(selection)
          local filename = selection.filename
          local lnum = vim.F.if_nil(selection.lnum, 1)
          if filename ~= nil then
            vim.cmd(":edit! " .. filename .. "|" .. lnum)
          end
        end)
      else
        -- if does not have multi selection, open single file
        actions.select_default(prompt_bufnr)
      end
    end

    require("telescope").setup({
      ["zf-native"] = {
        file = {
          enable = true,
          highlight_results = true,
          match_filename = true,
        },
        generic = {
          enable = true,
          highlight_results = true,
          match_filename = false,
        },
      },
      pickers = {
        find_files = {
          hidden = true,
        },
        lsp_code_actions = {
          theme = "cursor",
        },
      },
      defaults = {
        mappings = {
          i = {
            ["<esc>"] = actions.close,
            ["<tab>"] = actions.toggle_selection,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<s-tab>"] = actions.toggle_selection + actions.move_selection_previous,
            ["<cr>"] = single_or_multi_select,
          },
          n = {
            ["<tab>"] = actions.toggle_selection,
            ["<s-tab>"] = actions.toggle_selection,
            ["<cr>"] = single_or_multi_select,
          },
        },
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
            results_width = 0.8,
          },
          vertical = {
            mirror = false,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
        path_display = { "smart" },
        file_ignore_patterns = { ".git/", "node_modules", "%.out" },
        prompt_prefix = " >  ",
        selection_caret = "  ",
        entry_prefix = "  ",
        winblend = 0,
        border = {},
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        color_devicons = true,
      },
    })

    require("telescope").load_extension("zf-native")
    require("telescope").load_extension("dap")
  end,
}
