local filetypes = require("utils.filetypes")
local ux = require("utils.ux")

local clang_types = {
    filetypes.c,
    filetypes.cpp,
    filetypes.arduino,
}

local prettier_types = {
    filetypes.javascript,
    filetypes.typescript,
    filetypes.jsx,
    filetypes.tsx,
    filetypes.json,
    filetypes.css,
}

--- Format current buffer based on filetype. Fallbacks to nvim-lsp formatter.
return function()
    local filetype = vim.bo.filetype

    -- [[ C/C++/Arduino ]]
    if vim.tbl_contains(clang_types, filetype) then
        if vim.fn.executable("clang-format") ~= 1 then
            vim.notify("clang-format is not installed, using LSP formatter", vim.log.levels.ERROR)
            goto FALLBACK
        end

        vim.cmd("%!clang-format")
        return
    end

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
            vim.notify("Stylua is not installed, using LSP formatter", vim.log.levels.ERROR)
            goto FALLBACK
        end

        stylua.format_file()
        return
    end

    -- [[ JS/TS/Json/CSS ]]
    if vim.tbl_contains(prettier_types, filetype) then
        if vim.fn.executable("prettierd") ~= 1 then
            vim.notify("Prettierd is not installed, using LSP formatter", vim.log.levels.ERROR)
            goto FALLBACK
        end

        ux.call_with_preserved_cursor(function()
            vim.cmd("%!prettierd %")
        end)
        return
    end

    -- [[ templ ]]
    if filetype == filetypes.templ then
        if vim.fn.executable("templ fmt") ~= 1 then
            vim.notify("templfmt is not installed, using LSP formatter", vim.log.levels.ERROR)
            goto FALLBACK
        end

        vim.cmd("%!templ fmt")
        return
    end

    -- [[ Fallback ]]
    ::FALLBACK::
    vim.lsp.buf.format()
end
