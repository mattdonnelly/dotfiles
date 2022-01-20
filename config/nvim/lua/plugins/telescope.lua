local actions = require('telescope.actions')
local action_state = require("telescope.actions.state")

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
    file_ignore_patterns = {"node_modules","%.out"},
    prompt_prefix = " 🔍  ",
  }
}
