return {
    "ofirgall/goto-breakpoints.nvim",
    config = function()
        local goto_breakpoints = require("goto-breakpoints")
        vim.keymap.set("n", "]b", goto_breakpoints.next, {})
        vim.keymap.set("n", "[b", goto_breakpoints.prev, {})
        vim.keymap.set("n", "]s", goto_breakpoints.stopped, {})
    end,
}
