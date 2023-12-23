local quickfix_utils = require("utils.quickfix")

vim.g.mapleader = " "

-- Opens file explorer -- See nvim-tree.lua
-- vim.keymap.set("n", "<leader>ft", vim.cmd.Ex)

-- Saves
vim.keymap.set("n", "<C-s>", function() vim.cmd("w") end)
vim.keymap.set("v", "<C-s>", function() vim.cmd("w") end)
vim.keymap.set("i", "<C-s>", function() vim.cmd("w") end)

-- Toggles quickfix
vim.keymap.set("n", "<leader>qf", function() quickfix_utils.toggle() end, { silent = true })

-- Quickfix navigation
vim.keymap.set("n", "]q", function() vim.cmd("cn") end, { silent = true })
vim.keymap.set("n", "[q", function() vim.cmd("cp") end, { silent = true })
vim.keymap.set("n", "]Q", function() vim.cmd("cfirst") end, { silent = true })
vim.keymap.set("n", "[Q", function() vim.cmd("clast") end, { silent = true })

-- Heavenly switcharoo
vim.keymap.set("n", "0", "^", { noremap = true })
vim.keymap.set("n", "^", "0", { noremap = true })

-- Moving lines around
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true })

-- Cursor centering
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Paste over selection without losing buffer contents
vim.keymap.set("x", "<leader>p", "\"_dP")

-- Yank into OS clipboard
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")
vim.keymap.set("n", "<leader>yy", "\"+yy")

-- Delete without losing buffer content
vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")

-- Automagically calls `/%s` with currently hovered word pre-entered
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- `chmod +x` current file
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
