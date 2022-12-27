return {
  'ggandor/lightspeed.nvim',
  config = function()
    require('lightspeed').setup({
      match_only_the_start_of_same_char_seqs = true,
      limit_ft_matches = 5,
    })
  end
}
