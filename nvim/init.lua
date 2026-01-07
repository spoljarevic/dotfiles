-- 1️⃣  Bootstrap lazy.nvim -------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- 2️⃣  Core options ---------------------------------------------------------
vim.o.termguicolors   = true
vim.o.number          = true
vim.o.relativenumber  = true
vim.o.mouse           = "a"
vim.o.hidden          = true
vim.o.splitright      = true
vim.o.splitbelow      = true
vim.o.updatetime      = 300
vim.o.signcolumn      = "yes"
vim.o.expandtab       = true
vim.o.shiftwidth      = 2
vim.o.tabstop         = 2

-- 3️⃣  Helper to start LSP servers with the new API -----------------------
local function setup_lsp(server_name, config)
  local default_cfg = {
    name = server_name,
    cmd = config.cmd,
    root_dir = config.root_dir or vim.loop.cwd(),
    settings = config.settings or {},
    init_options = config.init_options or {},
    on_attach = config.on_attach,
    capabilities = config.capabilities,
  }
  vim.lsp.start_client(default_cfg)
end

-- 4️⃣  Plugin list (lazy.nvim) ---------------------------------------------
require("lazy").setup({

  -----------------------------------------------------------------
  -- Theme: Catppuccin (fixed flavour field)
  -----------------------------------------------------------------

    {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = { flavour = "macchiato" },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme "catppuccin"
    end,
  },

  -----------------------------------------------------------------
  -- Core utilities
  -----------------------------------------------------------------
  { "nvim-lua/plenary.nvim" },
  { "nvim-lua/popup.nvim" },
  { "kyazdani42/nvim-web-devicons", lazy = true },

  -----------------------------------------------------------------
  -- File explorer
  -----------------------------------------------------------------
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup{
        view = { width = 30, side = "left" },
        filters = { dotfiles = false },
        git = { enable = true, ignore = false },
      }
    end,
  },

  -----------------------------------------------------------------
  -- Status line
  -----------------------------------------------------------------
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-web-devicons" },
    opts = {
      options = {
        theme = "catppuccin",
        component_separators = "|",
        section_separators = "",
      },
    },
  },

  -----------------------------------------------------------------
  -- Telescope (fuzzy finder)
  -----------------------------------------------------------------
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup{
        defaults = {
          layout_strategy = "horizontal",
          layout_config = { preview_width = 0.55 },
        },
      }
    end,
  },

  -----------------------------------------------------------------
  -- Treesitter (syntax + folding)
  -----------------------------------------------------------------
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "bash", "lua", "python", "yaml", "json",
        "markdown", "go", "rust", "c", "cpp",
      },
      highlight = { enable = true },
      indent = { enable = true },
    },
  },

  -----------------------------------------------------------------
  -- LSP & Completion (new API)
  -----------------------------------------------------------------
  {
    "neovim/nvim-lspconfig",    
    config = function()
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.completion = {
        completionItem = {
          snippetSupport = true,
        },
      }

      local on_attach = function(client, bufnr)
        local buf_set_keymap = function(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
        local opts = { noremap = true, silent = true }

        buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
        buf_set_keymap("n", "K",  "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
        buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
        buf_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
      end

      -- ==== Server configurations ====
      setup_lsp("pyright", {
        cmd = { "pyright-langserver", "--stdio" },
        on_attach = on_attach,
        capabilities = capabilities,
      })

      -- TypeScript – ts_ls (new name)
      setup_lsp("ts_ls", {
        cmd = { "typescript-language-server", "--stdio" },
        on_attach = on_attach,
        capabilities = capabilities,
      })

      -- Bash – bashls (unchanged)
      setup_lsp("bashls", {
        cmd = { "bash-language-server", "start" },
        on_attach = on_attach,
        capabilities = capabilities,
      })
    end,
  },

  -----------------------------------------------------------------
  -- Completion engine (nvim‑cmp) + snippets
  -----------------------------------------------------------------
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup{
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"]      = cmp.mapping.confirm({ select = true }),
          ["<Tab>"]     = cmp.mapping.select_next_item(),
          ["<S-Tab>"]   = cmp.mapping.select_prev_item(),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "path" },
        })
      }
    end,
  },

  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },

  -----------------------------------------------------------------
  -- Git signs
  -----------------------------------------------------------------
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add          = { text = "▎" },
        change       = { text = "▎" },
        delete       = { text = "契" },
        topdelete    = { text = "契" },
        changedelete = { text = "▎" },
      },
    },
  },

  -----------------------------------------------------------------
  -- Neogit
  -----------------------------------------------------------------
{
  "NeogitOrg/neogit",
  lazy = true,
  dependencies = {
    "nvim-lua/plenary.nvim",         -- required
    "sindrets/diffview.nvim",        -- optional - Diff integration

    -- Only one of these is needed.
    "nvim-telescope/telescope.nvim", -- optional
    "ibhagwan/fzf-lua",              -- optional
    "nvim-mini/mini.pick",           -- optional
    "folke/snacks.nvim",             -- optional
  },
  cmd = "Neogit",
  keys = {
    { "<leader>gg", "<cmd>Neogit<cr>", desc = "Show Neogit UI" },
  },
},

  -----------------------------------------------------------------
  -- Comment toggler
  -----------------------------------------------------------------
  { "numToStr/Comment.nvim", opts = {} },

  -----------------------------------------------------------------
  -- Which‑key (discoverability)
  -----------------------------------------------------------------
  { "folke/which-key.nvim", opts = {} },

}) -- end lazy.setup()

-- 5️⃣  Global keymaps --------------------------------------------------------
local map = vim.keymap.set
map("n", "<leader>e",  ":NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
map("n", "<leader>ff", ":Telescope find_files<CR>", { desc = "Find files" })
map("n", "<leader>fg", ":Telescope live_grep<CR>", { desc = "Live grep" })
map("n", "<leader>fb", ":Telescope buffers<CR>", { desc = "Buffers" })
map("n", "<leader>fh", ":Telescope help_tags<CR>", { desc = "Help tags" })
map("n", "<leader>gs", ":Gitsigns preview_hunk<CR>", { desc = "Git hunk preview" })
map("n", "<leader>gc", ":Gitsigns toggle_current_line_blame<CR>", { desc = "Git blame line" })

-- 6️⃣  Autocommands (auto‑format on save) ------------------------------------
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    vim.lsp.buf.formatting_sync(nil, 200)
  end,
})
