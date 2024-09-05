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

        ux.call_with_preserved_cursor_position(function()
            vim.cmd("%!clang-format")
        end)
        return
    end

    -- [[ Go ]]
    if filetype == filetypes.go then
        if vim.fn.executable("golines") ~= 1 then
            vim.notify("golines is not installed, using LSP formatter", vim.log.levels.ERROR)
            goto FALLBACK
        end

        ux.call_with_preserved_cursor_position(function()
            vim.cmd(
                "%!golines",
                "--write-output",
                "--max-len=80",
                "--ignore-generated",
                "--ignored-dirs=vendor,node_modules"
            )
        end)
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

        ux.call_with_preserved_cursor_position(function()
            vim.cmd("%!prettierd %")
        end)
        return
    end

    -- [[ WebC/Markdown ]]
    if filetype == filetypes.webc or filetype == filetypes.markdown then
        local formatters = require("utils.formatters")

        formatters.lsp_format_skip_frontmatter()
        return
    end

    -- [[ templ ]]
    if filetype == filetypes.templ then
        if vim.fn.executable("templ") ~= 1 then
            vim.notify("templ is not installed, using LSP formatter", vim.log.levels.ERROR)
            goto FALLBACK
        end

        ux.call_with_preserved_cursor_position(function()
            vim.cmd("%!templ fmt")
        end)
        return
    end

    -- [[ Fallback ]]
    ::FALLBACK::
    vim.lsp.buf.format()
end
