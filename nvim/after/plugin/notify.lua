local notify = require("notify")

-- Overriding vim's notification system
vim.notify = notify

vim.keymap.set("n", "<leader><leader>", function()
    notify.dismiss()
end)

-- TODO: implement full on notify useage
-- See: https://github.com/rcarriga/nvim-notify/wiki/Usage-Recipes#progress-updates

notify.setup({
    background_colour = "#000000",
    render = "compact"
})
