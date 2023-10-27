local formatter = require("formatter")
-- local util = require("formatter.util")

local function fallback()
    vim.lsp.buf.format()
end

local function prettier()
    return {
        exe = "prettier",
        args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0) },
        stdin = true
    }
end

local function go_format()
    return {
        -- gofmt
        function()
            return {
                exe = "gofmt",
                args = { vim.api.nvim_buf_get_name(0) },
                stdin = true
            }
        end,
        -- goimports
        function()
            return {
                exe = "goimports",
                args = { vim.api.nvim_buf_get_name(0) },
                stdin = true
            }
        end,
        -- golines
        function()
            return {
                exe = "golines",
                args = { "-m", "80", vim.api.nvim_buf_get_name(0) },
                stdin = true
            }
        end
    }
end

local function organize_imports()
    local filetype = vim.bo.filetype

    if filetype == "typescript" or filetype == "typescriptreact"
    then
        vim.lsp.buf.execute_command({
            command = "_typescript.organizeImports",
            arguments = { vim.api.nvim_buf_get_name(0) },
            title = ""
        })
    elseif filetype == "go" then
        vim.cmd("!goimports -w " .. vim.api.nvim_buf_get_name(0))
    end
end

vim.keymap.set("n", "<leader>fm", function() vim.cmd("Format") end)
vim.keymap.set("n", "<leader>imp", organize_imports)

-- Format on save
vim.api.nvim_create_augroup('format_autogroup', { clear = true })

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    group = "format_autogroup",
    command = "FormatWrite",
})


formatter.setup({
    logging = true,
    log_level = vim.log.levels.WARN,

    filetype = {
        typescript = {
            prettier
        },
        typescriptreact = {
            prettier
        },
        ['typescript.tsx'] = {
            prettier
        },
        javascript = {
            prettier
        },
        go = go_format(),
        ["*"] = {
            fallback
        }
    }
})
