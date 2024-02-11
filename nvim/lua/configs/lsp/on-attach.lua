local keymaps = require("configs.lsp.keymaps")

--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(client, bufnr)
    keymaps.setup(bufnr)

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
        vim.lsp.buf.format()
    end, { desc = "Format current buffer with LSP" })
end

return on_attach
