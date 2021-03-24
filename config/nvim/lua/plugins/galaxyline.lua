local gl = require("galaxyline")
local gls = gl.section
gl.short_line_list = {'defx', 'packager', 'vista', 'NvimTree', 'coc-explorer'}

local colors = {
    bg = "#282c34",
    line_bg = "#282c34",
    fg = "#D8DEE9",
    fg_green = "#65a380",
    yellow = "#A3BE8C",
    cyan = "#22262C",
    darkblue = "#61afef",
    green = "#BBE67E",
    orange = "#FF8800",
    purple = "#252930",
    magenta = "#c678dd",
    blue = "#22262C",
    red = "#DF8890",
    lightbg = "#3C4048",
    nord = "#81A1C1",
    greenYel = "#EBCB8B"
}

local mode_color = function()
  local mode_colors = {
    n = colors.nord,
    i = colors.green,
    c = colors.greenYel,
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
    FirstElement = {
        provider = function()
            vim.api.nvim_command('hi GalaxyFirstElement guibg='..mode_color())
            return " "
        end,
    }
}

gls.left[2] = {
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
          vim.api.nvim_command('hi GalaxyViMode guibg='..mode_color())
          return "  " ..alias[vim.fn.mode()]..' '
        end,
        highlight = {colors.bg, colors.nord},
        separator = " ",
        separator_highlight = {colors.lightbg, colors.lightbg}
    }
}

gls.left[3] = {
    FileIcon = {
        provider = "FileIcon",
        condition = buffer_not_empty,
        highlight = {require("galaxyline.provider_fileinfo").get_file_icon_color, colors.lightbg}
    }
}

gls.left[4] = {
    FileName = {
        provider = {"FileName", "FileSize"},
        condition = buffer_not_empty,
        highlight = {colors.fg, colors.lightbg}
    }
}

gls.left[5] = {
    FileInfoEnd = {
        provider = function()
            return ""
        end,
        separator = " ",
        separator_highlight = {colors.line_bg, colors.line_bg},
        highlight = {colors.line_bg, colors.line_bg}
    }
}

gls.left[11] = {
    LeftEnd = {
        provider = function()
            return " "
        end,
        separator = " ",
        separator_highlight = {colors.line_bg, colors.line_bg},
        highlight = {colors.line_bg, colors.line_bg}
    }
}

gls.left[12] = {
    DiagnosticError = {
        provider = "DiagnosticError",
        icon = "  ",
        highlight = {colors.red, colors.bg}
    }
}

gls.left[13] = {
    Space = {
        provider = function()
            return " "
        end,
        highlight = {colors.line_bg, colors.line_bg}
    }
}

gls.left[14] = {
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
        highlight = {colors.green, colors.line_bg}
    }
}

gls.right[2] = {
    DiffModified = {
        provider = "DiffModified",
        icon = " ",
        highlight = {colors.orange, colors.line_bg}
    }
}

gls.right[3] = {
    DiffRemove = {
        provider = "DiffRemove",
        condition = checkwidth,
        icon = " ",
        highlight = {colors.red, colors.line_bg}
    }
}

gls.right[4] = {
    GitIcon = {
        provider = function()
            return "   "
        end,
        condition = require("galaxyline.provider_vcs").check_git_workspace,
        highlight = {colors.greenYel, colors.line_bg}
    }
}

gls.right[5] = {
    GitBranch = {
        provider = "GitBranch",
        condition = require("galaxyline.provider_vcs").check_git_workspace,
        highlight = {colors.greenYel, colors.line_bg}
    }
}

gls.right[6] = {
  ScrollBar = {
    provider = 'ScrollBar',
    highlight = {colors.darkblue, colors.bg},
  }
}

gls.right[7] = {
    PerCent = {
        provider = "LinePercent",
        separator = " ",
        separator_highlight = {colors.red, colors.line_bg},
        highlight = {colors.bg, colors.fg}
    }
}

