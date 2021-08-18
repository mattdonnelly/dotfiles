if not pcall(require, 'feline') then
  return
end

local tokyonight_colors = require('tokyonight.colors').setup({})
local vi_mode_utils = require('feline.providers.vi_mode')
local cursor = require('feline.providers.cursor')

local colors = {
  bg = tokyonight_colors.bg_dark,
  fg = tokyonight_colors.fg,
  yellow = tokyonight_colors.yellow,
  cyan = tokyonight_colors.cyan,
  darkblue = tokyonight_colors.blue0,
  green = tokyonight_colors.green,
  orange = tokyonight_colors.orange,
  violet = tokyonight_colors.purple,
  magenta = tokyonight_colors.magenta,
  blue = tokyonight_colors.blue,
  red = tokyonight_colors.red,
  light_bg = tokyonight_colors.bg_highlight,
  primary_blue = tokyonight_colors.blue5,
}

local vi_mode_colors = {
  NORMAL = colors.primary_blue,
  OP = colors.primary_blue,
  INSERT = colors.yellow,
  VISUAL = colors.magenta,
  LINES = colors.magenta,
  BLOCK = colors.magenta,
  REPLACE = colors.red,
  ['V-REPLACE'] = colors.red,
  ENTER = colors.cyan,
  MORE = colors.cyan,
  SELECT = colors.orange,
  COMMAND = colors.blue,
  SHELL = colors.green,
  TERM = colors.green,
  NONE = colors.green,
}

local vi_mode_utils = require('feline.providers.vi_mode')
local lsp = require('feline.providers.lsp')

local comps = {
  vi_mode = {
    left = {
      provider = function()
        return '  ' .. vi_mode_utils.get_vim_mode() .. ' '
      end,
      hl = function()
        local val = {
          name = vi_mode_utils.get_mode_highlight_name(),
          bg = vi_mode_utils.get_mode_color(),
          fg = colors.bg
        }
        return val
      end,
    },
  },
  file = {
    info = {
      provider = 'file_info',
      type = 'unique',
      file_modified_icon = '',
      hl = {
        fg = colors.fg,
        bg = colors.light_bg,
      },
      left_sep = {
        {str = ' ', hl = {bg = colors.light_bg, fg = 'NONE'}}
      },
    },
    size = {
      provider = 'file_size',
      hl = {
        fg = colors.fg,
        bg = colors.light_bg,
      },
      right_sep = {
        {
          str = ' ',
          hl = { bg = colors.light_bg }
        }
      },
      left_sep = {
        {
          str = ' ',
          hl = { bg = colors.light_bg }
        }
      },
    },
    end_subsection = {
      provider = ' ',
      hl = {
        bg = colors.bg,
      }
    },
  },
  scroll_bar = {
    provider = 'scroll_bar',
    left_sep = ' ',
    hl = {
      fg = colors.blue,
    }
  },
  line_percentage = {
    provider = 'line_percentage',
    left_sep = ' ',
    right_sep = ' ',
  },
  position = {
    provider = function()
      pos = cursor.position()
      return ' '..pos..' '
    end,
    left_sep = ' ',
    hl = function()
      local val = {
        name = vi_mode_utils.get_mode_highlight_name(),
        fg = colors.bg,
        bg = vi_mode_utils.get_mode_color(),
      }
      return val
    end
  },
  git = {
    branch = {
      provider = 'git_branch',
      icon = ' ',
      hl = {
        fg = colors.fg,
      },
      left_sep = '  ',
      right_sep = ' ',
    },
    add = {
      provider = 'git_diff_added',
      icon = ' ',
      hl = {
        fg = colors.green
      },
      left_sep = ' ',
    },
    change = {
      provider = 'git_diff_changed',
      icon = " ",
      hl = {
        fg = colors.orange
      },
      left_sep = ' ',
    },
    remove = {
      provider = 'git_diff_removed',
      icon = " ",
      hl = {
        fg = colors.red
      },
      left_sep = ' ',
    }
  },
  diagnostics = {
    errors = {
      provider = 'diagnostic_errors',
      enabled = function()
        return lsp.diagnostics_exist('Error')
      end,
      hl = { fg = colors.red },
      left_sep = ' '
    },
    warnings = {
      provider = 'diagnostic_warnings',
      enabled = function()
        return lsp.diagnostics_exist('Warn')
      end,
      hl = { fg = colors.yellow },
      left_sep = ' '
    },
    hints = {
      provider = 'diagnostic_hints',
      enabled = function()
        return lsp.diagnostics_exist('Hint')
      end,
      hl = { fg = colors.cyan },
      left_sep = ' '
    },
    info = {
      provider = 'diagnostic_info',
      enabled = function()
        return lsp.diagnostics_exist('Info')
      end,
      hl = { fg = colors.blue },
      left_sep = ' '
    }
  }
}

local components = {
  active = {},
  inactive = {},
}

table.insert(components.active, {})
table.insert(components.active, {})
table.insert(components.inactive, {})
table.insert(components.inactive, {})

table.insert(components.active[1], comps.vi_mode.left)

table.insert(components.active[1], comps.file.info)
table.insert(components.active[1], comps.file.size)
table.insert(components.active[1], comps.file.end_subsection)

table.insert(components.active[1], comps.diagnostics.errors)
table.insert(components.active[1], comps.diagnostics.warnings)
table.insert(components.active[1], comps.diagnostics.hints)
table.insert(components.active[1], comps.diagnostics.info)

table.insert(components.inactive[1], comps.vi_mode.left)
table.insert(components.inactive[1], comps.file.info)

table.insert(components.active[2], comps.git.add)
table.insert(components.active[2], comps.git.change)
table.insert(components.active[2], comps.git.remove)
table.insert(components.active[2], comps.git.branch)

table.insert(components.active[2], comps.scroll_bar)
table.insert(components.active[2], comps.line_percentage)
table.insert(components.active[2], comps.position)

require('feline').setup({
  colors = { bg = colors.bg, fg = colors.fg },
  components = components,
  vi_mode_colors = vi_mode_colors,
  force_inactive = {
    filetypes = {
      'NvimTree',
      'dashboard',
      'dbui',
      'packer',
      'startify',
      'fugitive',
      'fugitiveblame'
    },
    buftypes = {'terminal'},
    bufnames = {}
  }
})
