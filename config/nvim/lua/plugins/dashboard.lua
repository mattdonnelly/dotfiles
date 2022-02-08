local g = vim.g

g.dashboard_disable_at_vimenter = 0
g.dashboard_disable_statusline = 1
g.dashboard_default_executive = "telescope"
g.dashboard_custom_header = {
  "                                        ",
  " g@@@@@@@@@@@@@@@@@@@@@@@@b_            ",
  "0@@@@@@@@@@@@@@@@@@@@@@@@@@@k           ",
  "0@@@@@@@@@@@@@^^#@@@@@@@@@@@@L          ",
  " #@@@@@@@@@@'   J@@@@@@@@@@@@@          ",
  "               J@@@@@@@@@@@@@@b         ",
  "              d@@@@@##@@@@@@@@@L        ",
  "             d@@@@#   ^@@@@@@@@Q        ",
  "            d@@@@@@r    #@@@@@@@[       ",
  "           d@@@@@@@[     #@@@@@@@r      ",
  "          0@@@@@@@P       0@@@@@@%      ",
  "         0@@@@P            0@@@@@@L     ",
  "        0@@@@^              0@@@@@@     ",
  "       #@@@F                 0@@@@@b    ",
  "      1@@@^                   `@@@@@L   ",
  "                               ^@@@@@   ",
  "                                ^@@@@[  ",
  "                                  ##P   ",
  "                                        ",
}

g.dashboard_custom_section = {
   a = { description = { "  Find File                 SPC f f" }, command = "Telescope find_files" },
   b = { description = { "  Recents                   SPC f o" }, command = "Telescope oldfiles" },
   c = { description = { "  Find Word                 SPC f /" }, command = "Telescope live_grep" },
   d = { description = { "洛 New File                  SPC f n" }, command = "DashboardNewFile" },
   f = { description = { "  Load Last Session         SPC l  " }, command = "SessionLoad" },
}

vim.api.nvim_set_keymap("n", "<leader>fn", "<cmd>DashboardNewFile<CR>",
  {silent = true, noremap = true}
)

vim.api.nvim_set_keymap("n", "<leader>l", "<cmd>SessionLoad<CR>",
  {silent = true, noremap = true}
)
