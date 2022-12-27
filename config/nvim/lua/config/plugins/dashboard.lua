return {
  'glepnir/dashboard-nvim',
  event = 'BufWinEnter',
  config = function()
    local db = require('dashboard')

    db.custom_header = {
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

    db.custom_center = {
      { icon = '  ', desc = 'Find file                   ', shortcut = 'SPC f f', action = 'Telescope find_files' },
      { icon = '  ', desc = 'Recent files                ', shortcut = 'SPC f o', action = 'Telescope oldfiles' },
      { icon = '  ', desc = 'Find word                   ', shortcut = 'SPC f /', action = 'Telescope live_grep' },
      { icon = '  ', desc = 'New file                    ', shortcut = 'SPC f n', action = 'enew' },
      { icon = '  ', desc = 'Settings                 ', shortcut = 'e $MYVIMRC', action = 'edit $MYVIMRC' }
    }
  end
}
