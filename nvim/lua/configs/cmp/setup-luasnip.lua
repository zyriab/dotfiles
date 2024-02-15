local luasnip = require("luasnip")
local loader_vscode = require("luasnip.loaders.from_vscode")

-- NOTE: additional snippets are added by Go.nvim
return function()
    vim.keymap.set({ "i", "s" }, "<C-k>", function()
        if luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
        end
    end, { desc = "[c-K] Expand snippet or jump to next field", silent = true })

    vim.keymap.set({ "i", "s" }, "<C-j>", function()
        if luasnip.jumpable(-1) then
            luasnip.jump(-1)
        end
    end, { desc = "[c-J] Jump to previous snippet field", silent = true })

    vim.keymap.set("i", "<C-o>", function()
        if luasnip.choice_active() then
            luasnip.change_choice(1)
        end
    end, { desc = "[c-O] Cycle snippet's [O]ptions", silent = true })

    loader_vscode.lazy_load()

    require("luasnip.loaders.from_vscode").lazy_load()
    luasnip.config.setup({
        keep_roots = true,
        link_roots = true,
        link_children = true,
        update_events = { "TextChanged", "TextChangedI" },
        enable_autosnippets = true,
    })
end
