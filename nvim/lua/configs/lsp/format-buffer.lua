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
        local ok, gofmt = pcall(require, "go.format")
        if not ok then
            vim.notify("Could not import go.format, using LSP formatter", vim.log.levels.ERROR)
            goto FALLBACK
        end

        ok, _ = pcall(gofmt.goimports)

        if not ok then
            vim.notify("Running of goimports failed, using LSP formatter", vim.log.levels.ERROR)
            goto FALLBACK
        end

        return
    end

    -- [[ Lua ]]
    if filetype == filetypes.lua then
        local ok, stylua = pcall(require, "stylua-nvim")

        if not ok then
            vim.notify("Stylua is not installed, using LSP formatter", vim.log.levels.WARN)
            goto FALLBACK
        end

        stylua.format_file()
        return
    end

    -- [[ JS/TS ]]
    if vim.tbl_contains(tsserver_types, filetype) then
        if vim.fn.executable("prettierd") ~= 1 then
            vim.notify("Prettierd is not installed, using LSP formatter", vim.log.levels.WARN)
            goto FALLBACK
        end

        vim.cmd("%!prettierd %")
        return
    end

    -- [[ Fallback ]]
    ::FALLBACK::
    vim.lsp.buf.format()
end
