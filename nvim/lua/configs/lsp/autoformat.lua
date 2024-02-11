-- Use language server to automatically format code on save.
-- Adds additional commands as well to manage the behavior
-- Call `setup` somewhere in LSP's config function

-- Commands:
--  Use :FormatToggle to toggle autoformatting on or off

local M = {}

local function run_client_extra_formatting(client)
    local name = client.name

    -- [[ Lua ]]
    if name == "lua_ls" then
        local ok, stylua = pcall(require, "stylua-nvim")
        if ok then
            stylua.format_file()
        end
    end

    -- [[ JS/TS ]]
    if name == "tsserver" then
        if vim.fn.executable("prettierd") == 1 then
            vim.cmd("%!prettierd %")
        end

        -- Need to reload the file if using ESLint 💩
        -- local eslint_path = vim.fn.glob('./node_modules/.bin/eslint')

        -- if eslint_path ~= '' then
        --     vim.cmd('%!npx eslint --fix %')
        -- elseif vim.fn.executable('eslint') == 1 then
        --     vim.cmd('%!eslint --fix %')
        -- end

        -- vim.cmd('e!')
    end
end

M.setup = function()
    local format_is_enabled = true

    vim.api.nvim_create_user_command("FormatToggle", function()
        format_is_enabled = not format_is_enabled
        vim.notify("Setting autoformatting to: " .. tostring(format_is_enabled))
    end, {})

    -- Create an augroup that is used for managing our formatting autocmds.
    --      We need one augroup per client to make sure that multiple clients
    --      can attach to the same buffer without interfering with each other.
    local _augroups = {}
    local get_augroup = function(client)
        if not _augroups[client.id] then
            local group_name = "custom-lsp-format-" .. client.name
            local id = vim.api.nvim_create_augroup(group_name, { clear = true })
            _augroups[client.id] = id
        end

        return _augroups[client.id]
    end

    -- Whenever an LSP attaches to a buffer, we will run this function.
    -- See `:help LspAttach` for more information about this autocmd event.
    vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("custom-lsp-attach-format", { clear = true }),
        -- This is where we attach the autoformatting for reasonable clients
        callback = function(args)
            local client_id = args.data.client_id
            local client = vim.lsp.get_client_by_id(client_id)
            local bufnr = args.buf

            -- Only attach to clients that support document formatting
            if not client.server_capabilities.documentFormattingProvider then
                return
            end

            -- Create an autocmd that will run *before* we save the buffer.
            --  Run the formatting command for the LSP that has just attached.
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = get_augroup(client),
                buffer = bufnr,
                callback = function()
                    if not format_is_enabled then
                        return
                    end

                    vim.lsp.buf.format({
                        async = false,
                        filter = function(c)
                            return c.id == client.id
                        end,
                    })

                    run_client_extra_formatting(client)
                end,
            })
        end,
    })
end

return M
