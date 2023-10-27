local lsp = require("lsp-zero")
local cmp = require("cmp")
local neodev = require("neodev")
-- local lspconfig = require("lspconfig")

lsp.preset("recommended")

-- Fixes undefined global "vim"
-- lsp.nvim_workspace()
neodev.setup()

lsp.ensure_installed({
    "tsserver", -- TS/JS
    "arduino_language_server",
    -- "asm_lsp",
    "bashls",
    "clangd", -- C
    "cssls",
    "eslint",
    "gopls",
    "graphql",
    "html",
    "jsonls",
    "lua_ls",
    "marksman", -- Markdown
    "sqlls",
    "taplo",    -- TOML
    "yamlls",
    "tailwindcss",
    "terraformls",
})

lsp.highlight = { enable = true }
lsp.indent = { enable = true }
lsp.incremental_selection = {
    enable = true,
    keymaps = {
        init_selection = "<C-space>",
        node_incremental = "<C-space>",
        scope_incremental = false,
        node_decremental = "<bs>",
    },
}

local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
    ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
})


vim.api.nvim_create_autocmd("FileType", {
    pattern = { "sql", "mysql", "plsql" },
    callback = function()
        cmp.setup.buffer({
            sources = {
                { name = "vim-dadbod-completion" }
            }
        })
    end
})

-- HACK: seems to be the only way to
-- successfully map the completion trigger
vim.keymap.set("n", "<C-Space>", function()
    cmp.mapping.complete()
end)

cmp_mappings["<Tab>"] = nil
cmp_mappings["<S-Tab>"] = nil


lsp.setup_nvim_cmp({
    mapping = cmp_mappings
})

lsp.set_preferences({
    suggest_lsp_servers = false,
})

lsp.on_attach(function(_, bufnr)
    local opts = { buffer = bufnr, remap = false }

    -- Some are actual remaps but it"s mostly to be used as a reference

    -- Hover
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)

    -- Go to definition
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)

    -- Go to declaration
    vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)

    -- Go to type definition
    vim.keymap.set("n", "go", function() vim.lsp.buf.type_definition() end, opts)

    -- List all the implementations in quickfix window
    vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, opts)

    -- View all code references in quickfix window (also `gr`)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)

    -- Show workspace symbols in quickfix window
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)

    -- View diagnostics (also `gl`)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)

    -- Display documentation if any (also `gs`)
    vim.keymap.set("n", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

    -- Go to next diagnostic
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)

    -- Go to previous diagnostic
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)

    -- Rename
    -- vim.keymap.set("n", "<F2>", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)

    -- Format file -- See `formatter.lua` (`<leader>fm`) for custom formatting
    -- vim.keymap.set("n", "<F3>", function() vim.lsp.buf.format() end, opts)
    vim.keymap.set("n", "<F3>", function()
        vim.notify("Use <leader>fm to properly format files!", vim.log.levels.WARN, {
            title = "Format",
        })
    end, opts)

    -- View code actions (also <F4>)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)


    -- Autocompletion
    -- <Ctrl-y>: Confirms selection.
    -- <Ctrl-e>: Cancel completion.
    -- <Down>: Navigate to the next item on the list.
    -- <Up>: Navigate to previous item on the list.
    -- <Ctrl-n>: If the completion menu is visible, go to the next item.
    -- <Ctrl-p>: If the completion menu is visible, go to the previous item.
    -- <Ctrl-d>: Scroll down the documentation window.
    -- <Ctrl-u>: Scroll up the documentation window.
end)

lsp.setup()

vim.diagnostic.config({
    virtual_text = true
})
