-- nicer lsp notifications using nvim-notify
return {
    -- "mrded/nvim-lsp-notify",
    dir = "$HOME/Developer/nvim-plugins/nvim-lsp-notify",
    dependencies = { "rcarriga/nvim-notify" },
    opts = {
        -- Keeps on spamming when editing Neovim config
        excludes = { "lua_ls" },
    },
}
