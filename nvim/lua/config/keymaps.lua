local map = vim.keymap.set

-- File explorer
map("n", "<leader>e",  ":NvimTreeToggle<CR>",  { desc = "Toggle file explorer" })

-- Telescope
map("n", "<leader>ff", ":Telescope find_files<CR>",  { desc = "Find files" })
map("n", "<leader>fg", ":Telescope live_grep<CR>",   { desc = "Live grep" })
map("n", "<leader>fb", ":Telescope buffers<CR>",     { desc = "Buffers" })
map("n", "<leader>fh", ":Telescope help_tags<CR>",   { desc = "Help tags" })

-- Git
map("n", "<leader>gs", ":Gitsigns preview_hunk<CR>",              { desc = "Git hunk preview" })
map("n", "<leader>gc", ":Gitsigns toggle_current_line_blame<CR>", { desc = "Git blame line" })

-- CodeCompanion
map("n", "<leader>cc", "<cmd>CodeCompanionChat<CR>",    { desc = "AI Chat (CodeCompanion)" })
map("n", "<leader>ca", "<cmd>CodeCompanionActions<CR>", { desc = "AI Actions (contextual)" })
map("v", "<leader>ca", "<cmd>CodeCompanionActions<CR>", { desc = "AI Actions (selection)" })
map("n", "<leader>ce", "<cmd>CodeCompanionExplain<CR>", { desc = "Explain code" })
map("n", "<leader>cf", "<cmd>CodeCompanionFix<CR>",     { desc = "Fix code" })
map("n", "<leader>ct", "<cmd>CodeCompanionTests<CR>",   { desc = "Generate tests" })

-- Claude Code
map("n", "<leader>ac", "<cmd>ClaudeCode<CR>",             { desc = "Toggle Claude" })
map("n", "<leader>af", "<cmd>ClaudeCodeFocus<CR>",        { desc = "Focus Claude" })
map("n", "<leader>ar", "<cmd>ClaudeCode --resume<CR>",    { desc = "Resume Claude" })
map("n", "<leader>aC", "<cmd>ClaudeCode --continue<CR>",  { desc = "Continue Claude" })
map("n", "<leader>am", "<cmd>ClaudeCodeSelectModel<CR>",  { desc = "Select Claude model" })
map("n", "<leader>ab", "<cmd>ClaudeCodeAdd %<CR>",        { desc = "Add current buffer" })
map("v", "<leader>as", "<cmd>ClaudeCodeSend<CR>",         { desc = "Send to Claude" })
map("n", "<leader>as", "<cmd>ClaudeCodeTreeAdd<CR>",      { desc = "Add file" })
map("n", "<leader>aa", "<cmd>ClaudeCodeDiffAccept<CR>",   { desc = "Accept diff" })
map("n", "<leader>ad", "<cmd>ClaudeCodeDiffDeny<CR>",     { desc = "Deny diff" })

-- Tabs
map("n", "<leader>tc", "<cmd>tabclose<CR>",    { desc = "Close tab" })
map("n", "<leader>to", "<cmd>tabonly<CR>",     { desc = "Close other tabs" })
map("n", "<leader>tl", "<cmd>tabnext<CR>",     { desc = "Next tab" })
map("n", "<leader>th", "<cmd>tabprevious<CR>", { desc = "Previous tab" })
