return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-lua/plenary.nvim",
    "BurntSushi/ripgrep",
    "sharkdp/fd",
    "nvim-telescope/telescope-dap.nvim",
    "natecraddock/telescope-zf-native.nvim",
  },
  cmd = { "Telescope" },
  keys = function()
    -- stylua: ignore
    return {
      { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find files" },
      { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Buffers" },
      { "<leader>f/", "<cmd>Telescope live_grep<CR>", desc = "Live search" },
      { "<leader>fo", function() require("telescope.builtin").oldfiles({ only_cwd = true }) end, desc = "Recent files" },

      { "<leader>gl", "<cmd>Telescope git_commits<CR>", desc = "Git commit log" },
      { "<leader>gb", "<cmd>Telescope git_branches<CR>", desc = "Git branches" },
      { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "Git status" },

      { "<leader>P", function() require("telescope").extensions.yank_history.yank_history({}) end, desc = "Open Yank History" },

      { "<leader>dlb", function() require("telescope").extensions.dap.list_breakpoints({}) end, desc = "List breakpoints" },
      { "<leader>dlv", function() require("telescope").extensions.dap.variables({}) end, desc = "List variables" },
      { "<leader>dlf", function() require("telescope").extensions.dap.frames({}) end, desc = "List frames" },
    }
  end,
  config = function()
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")
    local action_utils = require("telescope.actions.utils")

    local function single_or_multi_select(prompt_bufnr)
      local current_picker = action_state.get_current_picker(prompt_bufnr)
      local has_multi_selection = (next(current_picker:get_multi_selection()) ~= nil)

      if has_multi_selection then
        action_utils.map_selections(prompt_bufnr, function(selection)
          local filename = selection.filename
          local lnum = vim.F.if_nil(selection.lnum, 1)
          if filename ~= nil then
            vim.cmd(":edit! " .. filename .. "|" .. lnum)
          end
        end)
      else
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
        prompt_prefix = " 🔎  ",
        selection_caret = "  ",
      },
    })

    require("telescope").load_extension("zf-native")
    require("telescope").load_extension("dap")
  end,
}
