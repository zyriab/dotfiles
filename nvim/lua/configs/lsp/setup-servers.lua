local neodev = require("neodev")
local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local cmp_nvim_lsp = require("cmp_nvim_lsp")
local lspconfig = require("lspconfig")
local on_attach = require("configs.lsp.on-attach")
local util = require("lspconfig.util")

-- Enable the following language servers
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.

--  If you want to override the default filetypes that your language server will attach to you can
--  define the property 'filetypes' to the map in question.
local servers = {
    clangd = {},
    sqlls = {},
    html = { filetypes = { "html" } },
    cssls = {},
    arduino_language_server = {},
    graphql = {},
    bashls = {},
    jsonls = {},
    marksman = {},
    taplo = {},
    yamlls = {},
    tailwindcss = {},
    terraformls = {},
    eslint = {},

    -- NOTE(Go): Replaced by Go.nvim until I settle on what I want in my env
    ---@url https://github.com/golang/tools/tree/master/gopls/doc
    -- gopls = {
    --     cmd = { "gopls", "--remote=auto" },
    --     settings = {
    --         gopls = {
    --             gofumpt = true,
    --         },
    --         completion = true,
    --     },
    --     analyses = {
    --         unusedwrite = true,
    --         useany = true,
    --         unusedvariable = true,
    --     },
    -- },

    tsserver = {
        implicitProjectConfiguration = {
            checkJs = true,
        },
    },

    lua_ls = {
        Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
            -- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
            -- diagnostics = { disable = { 'missing-fields' } },
        },
    },
}

local mason_tools_installs = vim.tbl_extend("keep", {}, vim.tbl_keys(servers))

return function()
    -- mason-lspconfig requires that these setup functions are called in this order
    -- before setting up the servers.
    mason.setup()
    mason_lspconfig.setup()

    neodev.setup()

    -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

    mason_lspconfig.setup({
        ensure_installed = mason_tools_installs,
    })

    mason_lspconfig.setup_handlers({
        function(server_name)
            lspconfig[server_name].setup({
                capabilities = capabilities,
                on_attach = on_attach,
                settings = servers[server_name],
                filetypes = (servers[server_name] or {}).filetypes,
                single_file_support = true,
            })
        end,
    })
end
