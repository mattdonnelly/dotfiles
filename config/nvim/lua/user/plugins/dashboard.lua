return {
  "glepnir/dashboard-nvim",
  event = "VimEnter",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("dashboard").setup({
      theme = "doom",
      config = {
        center = {
          { desc = "󰚰 Update", group = "@property", action = "Lazy update", key = "u" },
          {
            desc = "󰱼 File",
            group = "Label",
            action = "Telescope find_files",
            key = "f",
          },
          {
            desc = "󱎸 Search",
            group = "DiagnosticHint",
            action = "Telescope live_grep",
            key = "/",
          },
          {
            desc = " New",
            group = "String",
            action = "enew",
            key = "n",
          },
          {
            desc = " Settings",
            group = "Number",
            action = "edit $MYVIMRC",
            key = "e",
          },
        },
      },
    })
  end,
}
