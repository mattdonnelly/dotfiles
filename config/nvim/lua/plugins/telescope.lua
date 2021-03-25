local keymap = vim.api.nvim_set_keymap

keymap("n", "<leader>f", ":Telescope find_files<CR>", {})
keymap("n", "<leader>/", ":Telescope live_grep<CR>", {})
keymap("n", "<leader>h", ":Telescope oldfiles<CR>", {})
keymap("n", "<leader>b", ":Telescope find_files<CR>", {})

local actions = require('telescope.actions')
require('telescope').setup{
  defaults = {
    vimgrep_arguments = {'rg', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case'},
    prompt_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "descending",
    file_sorter = require'telescope.sorters'.get_fuzzy_file,
    generic_sorter = require'telescope.sorters'.get_generic_fuzzy_sorter,
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<esc>"] = actions.close
      },
    },
  }
}
