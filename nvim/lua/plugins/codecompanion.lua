return {
  "olimorris/codecompanion.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd  = { "CodeCompanion", "CodeCompanionChat" },
  keys = {
    { "<leader>cc", "<cmd>CodeCompanionChat<cr>",    desc = "CodeCompanion Chat" },
    { "<leader>ca", "<cmd>CodeCompanionActions<cr>", desc = "CodeCompanion Actions" },
  },
  config = function()
    require("codecompanion").setup({})
  end,
}
