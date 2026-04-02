vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    vim.lsp.buf.format({
      timeout_ms = 200,
      filter = function(client)
        return client.supports_method("textDocument/formatting")
      end,
    })
  end,
})
