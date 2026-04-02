local function setup_lsp(server_name, config)
  if vim.fn.executable(config.cmd[1]) ~= 1 then return end
  vim.lsp.start({
    name         = server_name,
    cmd          = config.cmd,
    root_dir     = config.root_dir or vim.loop.cwd(),
    settings     = config.settings or {},
    init_options = config.init_options or {},
    on_attach    = config.on_attach,
    capabilities = config.capabilities,
  })
end

return {
  "neovim/nvim-lspconfig",
  config = function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    local on_attach = function(_, bufnr)
      local opts = { noremap = true, silent = true }
      local map  = function(lhs, rhs)
        vim.api.nvim_buf_set_keymap(bufnr, "n", lhs, rhs, opts)
      end
      map("gd",          "<cmd>lua vim.lsp.buf.definition()<CR>")
      map("K",           "<cmd>lua vim.lsp.buf.hover()<CR>")
      map("gr",          "<cmd>lua vim.lsp.buf.references()<CR>")
      map("<leader>rn",  "<cmd>lua vim.lsp.buf.rename()<CR>")
    end

    setup_lsp("pyright", {
      cmd          = { "pyright-langserver", "--stdio" },
      on_attach    = on_attach,
      capabilities = capabilities,
    })
    setup_lsp("ts_ls", {
      cmd          = { "typescript-language-server", "--stdio" },
      on_attach    = on_attach,
      capabilities = capabilities,
    })
    setup_lsp("bashls", {
      cmd          = { "bash-language-server", "start" },
      on_attach    = on_attach,
      capabilities = capabilities,
    })
  end,
}
