local filetypes = require("utils.filetypes")

local tsserver_types = {
    filetypes.javascript,
    filetypes.typescript,
    filetypes.jsx,
    filetypes.tsx,
}

--- Format current buffer based on filetype. Fallbacks to nvim-lsp formatter.
return function()
    local filetype = vim.bo.filetype

    -- [[ Go ]]
    if filetype == filetypes.go then
        -- It seems that `:GoFmt` does not always run goimport
        local ok, _ = pcall(vim.cmd.GoImport)

        if not ok then
            vim.notify("Running of :GoImport failed", vim.log.levels.ERROR)
        end

        -- gofumpt + goimports + golines
        ok, _ = pcall(vim.cmd.GoFmt)

        if not ok then
            vim.notify("Running of :GoFmt failed, using LSP formatter", vim.log.levels.ERROR)
        else
            return
        end
    end

    -- [[ Lua ]]
    if filetype == filetypes.lua then
        local ok, stylua = pcall(require, "stylua-nvim")

        if ok then
            stylua.format_file()
            return
        end

        vim.notify("Stylua is not installed, using LSP formatter", vim.log.levels.WARN)
    end

    -- [[ JS/TS ]]
    if vim.tbl_get(tsserver_types, filetype) then
        if vim.fn.executable("prettierd") == 1 then
            vim.cmd([[ %!prettierd % ]])
            return
        end

        vim.notify("Prettierd is not installed, using LSP formatter", vim.log.levels.WARN)
    end

    -- [[ Fallback ]]
    vim.lsp.buf.format()
end
