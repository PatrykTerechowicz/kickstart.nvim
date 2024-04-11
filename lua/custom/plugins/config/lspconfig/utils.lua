local M = {}

-- Snippet, autocompletion support
M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem = {
  documentationFormat = { 'markdown', 'plaintext' },
  snippetSupport = true,
  resolveSupport = {
    properties = {
      'documentation',
      'detail',
      'additionalTextEdits',
    },
  },
}
M.capabilities = require('cmp_nvim_lsp').default_capabilities(M.capabilities)

-- Use the following when ls attches to a buffer
M.on_attach = function(client, bufnr)
  -- Mappings
  -- Diagnostic keymaps
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
  vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
  vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

  vim.keymap.set('n', 'gl', function()
    local float_opts = {
      focusable = false,
      close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter', 'FocusLost' },
      border = 'single',
      source = 'if_many',
      prefix = '',
    }
    vim.diagnostic.open_float(nil, float_opts)
  end, { buffer = bufnr, silent = true, desc = "Diagnostic [L]ist" })
  local map = function(keys, func, desc)
    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = 'LSP: ' .. desc, silent = true })
  end

  map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
  map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
  map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
  map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
  map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
  map('K', vim.lsp.buf.hover, 'Hover Documentation')
  map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  -- vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, opts)

  -- Format on save if formatting is available
  if client.server_capabilities.documentFormattingProvider or client.server_capabilities.documentRangeFormattingProvider then
    local group = vim.api.nvim_create_augroup('lsp_format_onsave', { clear = false })
    vim.api.nvim_clear_autocmds { buffer = bufnr, group = group }
    vim.api.nvim_create_autocmd('BufWritePre', {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format { timeout_ms = 2000 }
      end,
      desc = 'Format using lsp/null-ls on save.',
      group = group,
    })
  end
end

return M
