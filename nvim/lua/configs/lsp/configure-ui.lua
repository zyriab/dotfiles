return function()
    -- [[ Borders ]]
    local _border = "rounded"

    vim.diagnostic.config({
        float = { border = _border },
        virtual_text = false, -- LSP_lines is used instead
    })

    -- This part is actually taken care of by Noice!
    -- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = _border })
    -- vim.lsp.handlers["textDocument/signatureHelp"] =
    --     vim.lsp.with(vim.lsp.handlers.signature_help, { border = _border })

    require("lspconfig.ui.windows").default_options = {
        border = _border,
    }
end
