local actions = require('telescope.actions')
local action_state = require("telescope.actions.state")
local fg_bg = require("utils").fg_bg

function fzf_multi_select(prompt_bufnr)
  local picker = action_state.get_current_picker(prompt_bufnr)
  local num_selections = table.getn(picker:get_multi_selection())

  if num_selections > 1 then
    actions.send_selected_to_qflist(prompt_bufnr)
    actions.open_qflist()
    actions.select_default(prompt_bufnr)
  else
    actions.file_edit(prompt_bufnr)
  end
end

require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<tab>"] = actions.toggle_selection + actions.move_selection_next,
        ["<s-tab>"] = actions.toggle_selection + actions.move_selection_previous,
        ["<cr>"] = fzf_multi_select
      },
      n = {
        ["<tab>"] = actions.toggle_selection + actions.move_selection_next,
        ["<s-tab>"] = actions.toggle_selection + actions.move_selection_previous,
        ["<cr>"] = fzf_multi_select
      }
    },
    pickers = {
      lsp_code_actions = {
        theme = 'cursor'
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
    file_ignore_patterns = {"node_modules","%.out"},
    prompt_prefix = " 🔭  ",
    selection_caret = "  ",
    entry_prefix = "  ",
    winblend = 0,
    border = {},
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    color_devicons = true,
  }
}

local colors = require('tokyonight.colors').setup({})

fg_bg("TelescopeBorder", colors.bg_dark, colors.bg_dark)
fg_bg("TelescopePromptBorder", colors.bg, colors.bg)

fg_bg("TelescopePromptNormal", colors.fg, colors.bg)
fg_bg("TelescopePromptPrefix", colors.red, colors.bg)

fg_bg("TelescopeNormal", colors.fg, colors.bg_dark)

fg_bg("TelescopePreviewTitle", colors.bg, colors.green)
fg_bg("TelescopePromptTitle", colors.black, colors.red)
fg_bg("TelescopeResultsTitle", colors.bg_dark, colors.bg_dark)
