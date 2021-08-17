local gl = require("galaxyline")
local tokyonight_colors = require("tokyonight.colors").setup({})
local gls = gl.section
gl.short_line_list = {'defx', 'packager', 'vista', 'NvimTree', 'coc-explorer'}

local colors = {
    bg = tokyonight_colors.bg_dark,
    fg = tokyonight_colors.fg,
    yellow = tokyonight_colors.yellow,
    cyan = tokyonight_colors.cyan,
    dark_blue = tokyonight_colors.blue0,
    green = tokyonight_colors.green,
    orange = tokyonight_colors.orange,
    purple = tokyonight_colors.purple,
    magenta = tokyonight_colors.magenta,
    blue = tokyonight_colors.blue,
    red = tokyonight_colors.red,
    light_bg = tokyonight_colors.bg_highlight,
    primary_blue = tokyonight_colors.blue5,
}

local mode_color = function()
  local mode_colors = {
    n = colors.primary_blue,
    i = colors.green,
    c = colors.yellow,
    V = colors.magenta,
    [''] = colors.magenta,
    v = colors.magenta,
    R = colors.red,
  }

  return mode_colors[vim.fn.mode()]
end

local checkwidth = function()
    local squeeze_width = vim.fn.winwidth(0) / 2
    if squeeze_width > 40 then
        return true
    end
    return false
end

gls.left[1] = {
    ViMode = {
        provider = function()
          local alias = {
            n = 'NORMAL',
            i = 'INSERT',
            c = 'COMMAND',
            V = 'VISUAL',
            [''] = 'VISUAL',
            v = 'VISUAL',
            R = 'REPLACE',
          }
          local color = mode_color()
          if color ~= nil then
            vim.api.nvim_command('hi GalaxyViMode guibg='..color)
            return "   " ..alias[vim.fn.mode()]..' '
          end
          return "   "
        end,
        highlight = {colors.bg, colors.primary_blue},
        separator = " ",
        separator_highlight = {colors.light_bg, colors.light_bg}
    }
}

gls.left[2] = {
    FileIcon = {
        provider = "FileIcon",
        condition = buffer_not_empty,
        highlight = {require("galaxyline.provider_fileinfo").get_file_icon_color, colors.light_bg}
    }
}

gls.left[3] = {
    FileName = {
        provider = {"FileName", "FileSize"},
        condition = buffer_not_empty,
        highlight = {colors.fg, colors.light_bg}
    }
}

gls.left[4] = {
    FileInfoEnd = {
        provider = function()
            return ""
        end,
        separator = " ",
        separator_highlight = {colors.bg, colors.bg},
        highlight = {colors.bg, colors.bg}
    }
}

gls.left[5] = {
    LeftEnd = {
        provider = function()
            return " "
        end,
        separator = " ",
        separator_highlight = {colors.bg, colors.bg},
        highlight = {colors.bg, colors.bg}
    }
}

gls.left[6] = {
    DiagnosticError = {
        provider = "DiagnosticError",
        icon = "  ",
        highlight = {colors.red, colors.bg}
    }
}

gls.left[7] = {
    Space = {
        provider = function()
            return " "
        end,
        highlight = {colors.bg, colors.bg}
    }
}

gls.left[8] = {
    DiagnosticWarn = {
        provider = "DiagnosticWarn",
        icon = "  ",
        highlight = {colors.blue, colors.bg}
    }
}

gls.right[1] = {
    DiffAdd = {
        provider = "DiffAdd",
        condition = checkwidth,
        icon = "   ",
        highlight = {colors.green, colors.bg}
    }
}

gls.right[2] = {
    DiffModified = {
        provider = "DiffModified",
        icon = " ",
        highlight = {colors.orange, colors.bg}
    }
}

gls.right[3] = {
    DiffRemove = {
        provider = "DiffRemove",
        condition = checkwidth,
        icon = " ",
        highlight = {colors.red, colors.bg}
    }
}

gls.right[4] = {
    GitIcon = {
        provider = function()
            return "   "
        end,
        condition = require("galaxyline.provider_vcs").check_git_workspace,
        highlight = {colors.pale_yellow, colors.bg}
    }
}

gls.right[5] = {
    GitBranch = {
        provider = "GitBranch",
        condition = require("galaxyline.provider_vcs").check_git_workspace,
        highlight = {colors.pale_yellow, colors.bg}
    }
}

gls.right[6] = {
    ScrollBarSpace = {
        provider = function()
            return " "
        end,
        highlight = {colors.bg, colors.bg}
    }
}

gls.right[7] = {
  ScrollBar = {
    provider = 'ScrollBar',
    highlight = {colors.dark_blue, colors.bg},
  }
}

gls.right[8] = {
    PerCent = {
        provider = "LinePercent",
        separator = " ",
        separator_highlight = {colors.red, colors.bg},
        highlight = {colors.bg, colors.fg}
    }
}
