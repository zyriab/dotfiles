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
        -- gofumpt + goimports + golines
        ---@diagnostic disable-next-line: param-type-mismatch
        local ok, _ = pcall(vim.cmd.GoFmt)

        if ok then
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
    end

    -- [[ JS/TS ]]
    if vim.tbl_get(tsserver_types, filetype) then
        if vim.fn.executable("prettierd") == 1 then
            vim.cmd([[ %!prettierd % ]])
            return
        end
    end

    -- [[ Fallback ]]
    vim.lsp.buf.format()
end
