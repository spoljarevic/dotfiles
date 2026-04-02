return {
  "nanozuki/tabby.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VimEnter",
  config = function()
    require("tabby").setup({
      preset = "active_wins_at_tail",
      option = {
        theme = {
          fill        = "TabLineFill",
          head        = "TabLine",
          current_tab = "TabLineSel",
          tab         = "TabLine",
          win         = "TabLine",
          tail        = "TabLine",
        },
      },
    })
  end,
}
