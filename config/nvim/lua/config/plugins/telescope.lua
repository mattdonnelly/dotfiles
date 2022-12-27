return {
  'nvim-telescope/telescope.nvim',
  version = '0.1.0',
  cmd = { 'Telescope' },
  keys = {
    { '<leader>ff', '<cmd>Telescope find_files<CR>', desc = 'Find files' },
    { '<leader>fb', '<cmd>Telescope buffers<CR>', desc = 'Buffers' },
    { '<leader>f/', '<cmd>Telescope live_grep<CR>', desc = 'Live search' },
    { '<leader>fo', [[<cmd>lua require('telescope.builtin').oldfiles({ only_cwd = true })<CR>]], desc = 'Recent files' },
    { '<leader>fc', '<cmd>Telescope lsp_code_actions<CR>', desc = 'Code actions' },
  },
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-lua/plenary.nvim',
    'BurntSushi/ripgrep',
    'sharkdp/fd',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },
  config = function()
    local actions = require('telescope.actions')
    local action_state = require('telescope.actions.state')

    local custom_actions = {}

    function custom_actions.fzf_multi_select(prompt_bufnr)
      local picker = action_state.get_current_picker(prompt_bufnr)
      local num_selections = #(picker:get_multi_selection())

      if num_selections > 1 then
        actions.send_selected_to_qflist(prompt_bufnr)
        actions.open_qflist(prompt_bufnr)
      elseif picker.cwd ~= nil then
        actions.select_default(prompt_bufnr)
      else
        actions.file_edit(prompt_bufnr)
      end
    end

    require('telescope').setup({
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
        }
      },
      defaults = {
        mappings = {
          i = {
            ['<esc>'] = actions.close,
            ['<tab>'] = actions.toggle_selection + actions.move_selection_next,
            ['<s-tab>'] = actions.toggle_selection + actions.move_selection_previous,
            ['<cr>'] = custom_actions.fzf_multi_select
          },
          n = {
            ['<tab>'] = actions.toggle_selection + actions.move_selection_next,
            ['<s-tab>'] = actions.toggle_selection + actions.move_selection_previous,
            ['<cr>'] = custom_actions.fzf_multi_select
          }
        },
        pickers = {
          lsp_code_actions = {
            theme = 'cursor'
          },
        },
        sorting_strategy = 'ascending',
        layout_strategy = 'horizontal',
        layout_config = {
          horizontal = {
            prompt_position = 'top',
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
        path_display = { 'smart' },
        file_ignore_patterns = { 'node_modules', '%.out' },
        prompt_prefix = ' 🔭  ',
        selection_caret = '  ',
        entry_prefix = '  ',
        winblend = 0,
        border = {},
        borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
        color_devicons = true,
      }
    })

    require('telescope').load_extension('fzf')
  end
}
