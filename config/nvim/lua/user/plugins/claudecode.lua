return {
  "coder/claudecode.nvim",
  enabled = require("user.features").claude,
  cmd = {
    "ClaudeCode",
    "ClaudeCodeFocus",
    "ClaudeCodeSelectModel",
    "ClaudeCodeAdd",
    "ClaudeCodeSend",
    "ClaudeCodeTreeAdd",
    "ClaudeCodeStatus",
    "ClaudeCodeStart",
    "ClaudeCodeStop",
    "ClaudeCodeOpen",
    "ClaudeCodeClose",
    "ClaudeCodeDiffAccept",
    "ClaudeCodeDiffDeny",
    "ClaudeCodeCloseAllDiffs",
  },
  keys = {
    { "<leader>ac", "<cmd>ClaudeCode<CR>",            desc = "Toggle Claude" },
    { "<leader>af", "<cmd>ClaudeCodeFocus<CR>",       desc = "Focus Claude" },
    { "<leader>ar", "<cmd>ClaudeCode --resume<CR>",   desc = "Resume Claude" },
    { "<leader>aC", "<cmd>ClaudeCode --continue<CR>", desc = "Continue Claude" },
    { "<leader>am", "<cmd>ClaudeCodeSelectModel<CR>", desc = "Select Claude model" },
    { "<leader>ab", "<cmd>ClaudeCodeAdd %<CR>",       desc = "Add current buffer" },
    { "<leader>as", "<cmd>ClaudeCodeSend<CR>",        mode = "v",                  desc = "Send to Claude" },
    { "<leader>as", "<cmd>ClaudeCodeTreeAdd<CR>",     desc = "Add file",           ft = { "neo-tree", "oil" } },
    { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<CR>",  desc = "Accept diff" },
    { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<CR>",    desc = "Deny diff" },
  },
  opts = {
    terminal = {
      provider = "native",
      split_side = "right",
      split_width_percentage = 0.35,
    },
  },
  init = function()
    -- The native provider (unlike snacks) doesn't map <S-CR>, so Claude receives a
    -- plain Enter. Remap it to <M-CR>, which Claude Code treats as a newline. Being a
    -- key (not raw bytes), it's encoded for the job the same way a real Alt+Enter is.
    vim.api.nvim_create_autocmd("TermOpen", {
      pattern = "term://*claude*",
      callback = function(ev)
        vim.keymap.set("t", "<S-CR>", "<M-CR>", { buffer = ev.buf, desc = "New line in Claude" })
      end,
    })
  end,
}
