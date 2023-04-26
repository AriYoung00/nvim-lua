local signs = {
  { name = "DiagnosticSignError", text = "" },
  { name = "DiagnosticSignWarn",  text = "" },
  { name = "DiagnosticSignHint",  text = "" },
  { name = "DiagnosticSignInfo",  text = "" },
}

for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

vim.diagnostic.config {
  float = { border = "rounded" },
  update_in_insert = true,
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = {
    prefix = "",
    spacing = 10,
  },
  signs = true,
  underline = true,
})

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
  vim.lsp.handlers.hover,
  {border = 'rounded'}
)

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  {border = 'rounded'}
)

-- Highlight the symbol and its references on a CursorHold event(cursor is idle)
vim.api.nvim_create_autocmd("CursorHold", { callback = function(ev)
    -- vim.lsp.buf.hover()
    vim.lsp.buf.document_highlight()
end })

vim.api.nvim_create_autocmd("CursorHoldI", { callback = function(ev)
    vim.lsp.buf.document_highlight()
end
})

vim.api.nvim_create_autocmd("CursorMoved", { callback = function(ev)
  vim.lsp.buf.clear_references()
  vim.cmd "noh"
end
})

local function update_codelens(_ev)
  if vim.lsp.buf.server_ready() then
    vim.lsp.codelens.refresh()
  end
end

vim.api.nvim_create_autocmd("BufWritePost", { callback = update_codelens })
vim.api.nvim_create_autocmd("BufEnter", { callback = update_codelens })
vim.api.nvim_create_autocmd("InsertLeave", { callback = update_codelens })
vim.api.nvim_create_autocmd('User', {
    pattern = 'LspAttached',
    once = true,
    callback = vim.lsp.codelens.refresh,
})
