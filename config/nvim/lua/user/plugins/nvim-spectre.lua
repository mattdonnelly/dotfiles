return {
  "nvim-pack/nvim-spectre",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  cmd = { "Spectre" },
  keys = function()
    -- stylua: ignore
    return {
      { "<leader>SS", function() require("spectre").toggle() end, desc = "Toggle Spectre" },
      { "<leader>Sw", function() require("spectre").open_visual({ select_word = true }) end, desc = "Search the current word" },
      { "<leader>Sv", function() require("spectre").open_visual() end, desc = "Search the visual selection" },
      { "<leader>Sf", function() require("spectre").open_file_search() end, desc = "Search in file" },
    }
  end,
}
