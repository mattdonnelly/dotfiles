return {
  "nvim-telescope/telescope.nvim",
  version = "0.1.0",
  cmd = { "Telescope" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-lua/plenary.nvim",
    "BurntSushi/ripgrep",
    "sharkdp/fd",
    "nvim-telescope/telescope-dap.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
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
          vim.cmd(":edit! " .. filename .. "|" .. lnum)
        end)
      else
        -- if does not have multi selection, open single file
        actions.file_edit(prompt_bufnr)
      end
    end

    require("telescope").setup({
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
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
        pickers = {
          lsp_code_actions = {
            theme = "cursor",
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
        file_ignore_patterns = { "node_modules", "%.out" },
        prompt_prefix = " 🔭  ",
        selection_caret = "  ",
        entry_prefix = "  ",
        winblend = 0,
        border = {},
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        color_devicons = true,
      },
    })

    require("telescope").load_extension("fzf")
    require("telescope").load_extension("dap")
  end,
}
