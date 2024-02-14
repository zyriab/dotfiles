return {
    {
        "kkoomen/vim-doge",
        event = "BufRead",
        build = ":call doge#install()",
        config = function()
            -- FIXME(vim-doge): this part does not work
            -- Disabling default mappings
            vim.g.doge_enable_mappings = 0
            vim.g.doge_mapping = "<leader>g"
        end,
    },
    {
        "danymat/neogen",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        version = "*", -- Uses only stable versions
        config = function()
            local filetype = vim.bo.filetype

            -- FIXME(generators): does not work w/ lua, not tested w/ js
            local generators = {
                {
                    language = "lua",
                    cmd = "Neogen",
                },
                {
                    language = "javascript",
                    cmd = "call doge#generate()",
                },
            }

            local has_generated = false
            local function generate_annotations()
                for _, generator in ipairs(generators) do
                    if filetype == generator.language then
                        vim.cmd(generator.cmd)
                        has_generated = true
                    end
                end

                return has_generated
            end

            vim.keymap.set("n", "<leader>g", function()
                generate_annotations()

                if has_generated == false then
                    vim.notify("No generator for filetype " .. filetype, vim.log.levels.INFO)
                end
            end, { desc = "[G]enerate type annotations (JS/Lua)", silent = true })
        end,
    },
}
