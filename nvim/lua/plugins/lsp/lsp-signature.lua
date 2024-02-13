return {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {
        bind = true, -- This is mandatory, otherwise border config won't get registered.
        hint_prefix = "🦊 ",
        doc_lines = 0,
        handler_opts = { border = "rounded" },
        hi_parameter = "LspSignatureActiveParameter",
    },
}
