---@diagnostic disable: param-type-mismatch
return {
    "rmagatti/auto-session",
    lazy = true,
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
        local auto_session = require("auto-session")
        local session_lens = require("auto-session.session-lens")
        local telescope = require("telescope")
        local lualine = require("lualine")
        local dapui = require("dapui")
        local filetypes = require("utils.filetypes")

        ---@diagnostic disable-next-line: missing-fields
        auto_session.setup({
            auto_restore_enabled = false,
            -- refresh lualine so the new session name is displayed in the status bar
            post_cwd_changed_hook = lualine.refresh,
            -- Closes dapui before saving the session
            pre_save_cmds = {
                "cclose",
                function()
                    pcall(dapui.close)
                    pcall(vim.cmd, "NvimTreeClose")
                    pcall(vim.cmd, "OutlineClose")
                end,
            },
            bypass_session_save_filetypes = {
                filetypes.noice,
                filetypes.notify,
                filetypes.nvimtree,
            },
        })

        telescope.load_extension("session-lens")

        vim.keymap.set("n", "<leader>ss", function()
            session_lens.search_session({
                path_display = { "shorten" },
                previewer = false,
                prompt_title = "Restore Session",
                initial_mode = "normal",
            })
        end, { desc = "[S]earch [S]essions" })
    end,
    init = function()
        ---@url https://github.com/rmagatti/auto-session/issues/223#issuecomment-1666658887
        local autocmd = vim.api.nvim_create_autocmd

        local lazy_did_show_install_view = false

        local function auto_session_restore()
            -- important! without vim.schedule other necessary plugins might not load (eg treesitter) after restoring the session
            vim.schedule(function()
                require("auto-session").AutoRestoreSession()
            end)
        end

        autocmd("User", {
            pattern = "VeryLazy",
            callback = function()
                local lazy_view = require("lazy.view")

                if lazy_view.visible() then
                    -- if lazy view is visible do nothing with auto-session
                    lazy_did_show_install_view = true
                else
                    -- otherwise load (by require'ing) and restore session
                    auto_session_restore()
                end
            end,
        })

        autocmd("WinClosed", {
            pattern = "*",
            callback = function(ev)
                local lazy_view = require("lazy.view")

                -- if lazy view is currently visible and was shown at startup
                if lazy_view.visible() and lazy_did_show_install_view then
                    -- if the window to be closed is actually the lazy view window
                    if ev.match == tostring(lazy_view.view.win) then
                        lazy_did_show_install_view = false
                        auto_session_restore()
                    end
                end
            end,
        })
    end,
}
