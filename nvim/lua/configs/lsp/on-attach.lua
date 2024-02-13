local set_keymaps = require("configs.lsp.set-keymaps")

--  This function gets run when an LSP connects to a particular buffer.
return function(_, bufnr)
    set_keymaps()

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
        vim.lsp.buf.format()
    end, { desc = "Format current buffer with LSP" })
end
