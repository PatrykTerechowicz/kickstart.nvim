local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local map = vim.keymap.set
local e_opts = { expr = true }
local s_opts = { silent = true }
local se_opts = { silent = true, expr = true }

local M = {}

M.ultisnips = function()
  -- Disable snipmate plugins to avoid duplicate snippets
  vim.g.UltiSnipsSnippedDirectories = { "UltiSnips" }
  vim.g.UltiSnipsEnableSnipMate = 0
  vim.g.UltiSnipsRemoveSelectModeMappings = 0
  vim.g.UltiSnipsExpandTrigger = '<Tab>'
  vim.g.UltiSnipsJumpForwardTrigger = '<Tab>'
  vim.g.UltiSnipsJumpBackwardTrigger = '<S-Tab>'
end

return M
