return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  opts = {
    ensure_installed = {
      "bash", "lua", "python", "yaml", "json",
      "markdown", "go", "rust", "c", "cpp",
    },
    highlight = { enable = true },
    indent    = { enable = true },
  },
}
