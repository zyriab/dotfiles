return {
    "jmbuhr/otter.nvim",
    dependencies = {
        "hrsh7th/nvim-cmp",
        "neovim/nvim-lspconfig",
        "nvim-treesitter/nvim-treesitter",
        "nvim-telescope/telescope.nvim",
    },
    config = function()
        local otter = require("otter")
        local filetypes = require("utils.filetypes")
        local telescope = require("telescope.builtin")
        local format_buffer = require("configs.lsp.format-buffer")

        otter.setup({
            lsp = {
                hover = {
                    border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
                },
                -- `:h events` that cause the diagnostics to update.
                diagnostic_update_events = { "BufWritePost", "InsertLeave", "TextChanged" },
            },
            buffers = {
                -- if set to true, the filetype of the otterbuffers will be set.
                -- otherwise only the autocommand of lspconfig that attaches
                -- the language server will be executed without setting the filetype
                set_filetype = false,
                -- write <path>.otter.<embedded language extension> files
                -- to disk on save of main buffer.
                -- usefule for some linters that require actual files
                -- otter files are deleted on quit or main buffer close
                write_to_disk = true,
            },
            strip_wrapping_quote_characters = { "'", "\"", "`" },
            -- Otter may not work the way you expect when entire code blocks are indented (eg. in Org files)
            -- When true, otter handles these cases fully. This is a (minor) performance hit
            handle_leading_whitespace = true,
        })

        -- Autoactivate Otter
        local augroup = vim.api.nvim_create_augroup("otter-activate", { clear = true })
        vim.api.nvim_create_autocmd("BufEnter", {
            group = augroup,
            callback = function()
                local filetype = vim.bo.filetype

                if filetype == filetypes.html or filetype == filetypes.webc then
                    vim.keymap.set("n", "K", otter.ask_hover, { desc = "Hover Documentation" })
                    vim.keymap.set("n", "<leader>rn", otter.ask_rename, { desc = "[R]e[n]ame" })

                    vim.keymap.set("n", "gd", function()
                        otter.ask_definition(telescope.lsp_definitions)
                    end, { desc = "[G]oto [D]efinition" })

                    vim.keymap.set("n", "gr", function()
                        otter.ask_references(telescope.lsp_references)
                    end, { desc = "[G]oto [R]eferences" })

                    vim.keymap.set("n", "<leader>D", function()
                        -- otter.ask_type_definition(telescope.lsp_type_definitions)
                        otter.ask_type_definition()
                    end, { desc = "Type [D]efinition" })

                    vim.keymap.set("n", "<leader>ds", function()
                        otter.ask_document_symbols(telescope.lsp_document_symbols)
                    end, { desc = "[D]ocument [S]ymbols" })

                    vim.keymap.set(
                        "n",
                        "<leader>fm",
                        format_buffer,
                        { desc = "[F]or[M]at the current buffer with LSP" }
                    )

                    otter.activate({ "javascript", "css", "html", "typescript" })
                else
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation" })
                    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "[R]e[n]ame" })
                    vim.keymap.set("n", "gd", telescope.lsp_definitions, { desc = "[G]oto [D]efinition" })
                    vim.keymap.set("n", "gr", telescope.lsp_references, { desc = "[G]oto [R]eferences" })
                    vim.keymap.set("n", "<leader>D", telescope.lsp_type_definitions, { desc = "Type [D]efinition" })
                    vim.keymap.set("n", "<leader>ds", telescope.lsp_document_symbols, { desc = "[D]ocument [S]ymbols" })

                    vim.keymap.set(
                        "n",
                        "<leader>fm",
                        format_buffer,
                        { desc = "[F]or[M]at the current buffer with LSP" }
                    )
                end
            end,
        })
    end,
}
