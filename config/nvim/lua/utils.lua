local M = {}

M.fg_bg = function(group, fgcol, bgcol)
 vim.cmd("hi " .. group .. " guifg=" .. fgcol .. " guibg=" .. bgcol)
end

return M
