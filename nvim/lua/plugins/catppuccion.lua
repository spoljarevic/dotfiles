return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  opts = {
    flavour                = "macchiato",
    transparent_background = true,
    integrations = {
      telescope   = true,
      nvimtree    = true,
      which_key   = true,
      cmp         = true,
      lsp_trouble = true,
      mason       = true,
      notify      = true,
      mini        = true,
    },
  },
  config = function(_, opts)
    require("catppuccin").setup(opts)
    vim.cmd.colorscheme("catppuccin")

    local groups = {
      "Normal", "NormalFloat", "FloatBorder",
      "SignColumn", "CursorLine", "EndOfBuffer",
    }
    for _, g in ipairs(groups) do
      vim.api.nvim_set_hl(0, g, { bg = "NONE" })
    end
  end,
}
