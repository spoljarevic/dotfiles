return {
  "goolord/alpha-nvim",
  lazy = false,
  config = function()
    local dashboard = require("alpha.themes.dashboard")

    local banner = {}
    local path   = vim.fn.expand("~/.config/nvim/ascii/ascii-w2i.txt")
    local fd     = io.open(path, "r")
    if fd then
      for line in fd:lines() do table.insert(banner, line) end
      fd:close()
    else
      banner = { "Neovim" }
    end

    dashboard.section.header.val     = banner
    dashboard.section.header.opts.hl = "AlphaHeader"

    dashboard.section.buttons.val = {
      dashboard.button("f", "  Find file",    ":Telescope find_files<CR>"),
      dashboard.button("r", "  Recent files", ":Telescope oldfiles<CR>"),
      dashboard.button("n", "  New file",     ":enew<CR>"),
      dashboard.button("c", "  Config",       ":e $MYVIMRC<CR>"),
      dashboard.button("q", "  Quit",         ":qa<CR>"),
    }

    vim.api.nvim_set_hl(0, "AlphaHeader", {
      fg   = require("catppuccin.palettes").get_palette("macchiato").blue,
      bold = true,
    })

    require("alpha").setup(dashboard.opts)
  end,
}
