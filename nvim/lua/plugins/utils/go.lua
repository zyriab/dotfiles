return {
    "ray-x/go.nvim",
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ":lua require(\"go.install\").update_all_sync()",
    dependencies = {
        "neovim/nvim-lspconfig",
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        local go = require("go")
        local set_keymaps = require("configs.lsp.set-keymaps")

        go.setup({
            disable_defaults = false, -- true|false when true set false to all boolean settings and replace all table
            -- settings with {}
            go = "go", -- go command, can be go[default] or go1.18beta1
            goimport = "golines", -- goimport command, can be gopls[default] or either goimport or golines if need to split long lines
            fillstruct = "gopls", -- default, can also use fillstruct
            gofmt = "gofumpt", --gofmt cmd,
            max_line_len = 80, -- max line length in golines format, Target maximum line length for golines
            tag_transform = "snakecase", -- can be transform option("snakecase", "camelcase", etc) check gomodifytags for details and more options
            tag_options = "json=omitempty", -- sets options sent to gomodifytags, i.e., json=omitempty
            icons = false, -- setup to `false` to disable icons setup
            gotests_template = "", -- sets gotests -template parameter (check gotests for details)
            gotests_template_dir = "", -- sets gotests -template_dir parameter (check gotests for details)
            comment_placeholder = "", -- comment_placeholder your cool placeholder e.g. 󰟓       
            verbose = false, -- output loginf in messages
            lsp_cfg = true, -- true: use non-default gopls setup specified in go/lsp.lua
            lsp_gofumpt = true, -- true: set default gofmt in gopls format to gofumpt
            lsp_keymaps = false, -- set to false to disable gopls/lsp keymap
            lsp_codelens = false, -- set to false to disable codelens, true by default, you can use a function
            diagnostic = false,
            lsp_document_formatting = true,
            lsp_inlay_hints = { enable = false },
            gopls_remote_auto = true, -- add -remote=auto to gopls
            gocoverage_sign = "█",
            sign_priority = 5, -- change to a higher number to override other signs
            dap_debug = true, -- set to false to disable dap
            dap_debug_keymap = false, -- true: use keymap for debugger defined in go/dap.lua
            dap_debug_gui = false, -- bool|table put your dap-ui setup here set to false to disable
            dap_debug_vt = { enabled_commands = false, all_frames = false }, -- bool|table put your dap-virtual-text setup here set to false to disable

            dap_port = 38697, -- can be set to a number, if set to -1 go.nvim will pick up a random port
            -- dap_timeout = 15, --  see dap option initialize_timeout_sec = 15,
            -- dap_retries = 20, -- see dap option max_retries
            -- build_tags = "tag1,tag2", -- set default build tags
            textobjects = true, -- enable default text objects through treesittter-text-objects
            test_runner = "go", -- one of {`go`, `richgo`, `dlv`, `ginkgo`, `gotestsum`}
            verbose_tests = true, -- set to add verbose flag to tests deprecated, see '-v' option
            run_in_floaterm = false, -- set to true to run in a float window. :GoTermClose closes the floatterm
            -- float term recommend if you use richgo/ginkgo with terminal color

            trouble = false, -- true: use trouble to open quickfix
            test_efm = false, -- errorfomat for quickfix, default mix mode, set to true will be efm only
            luasnip = true, -- enable included luasnip snippets. you can also disable while add lua/snips folder to luasnip load
            --  Do not enable this if you already added the path, that will duplicate the entries
            iferr_vertical_shift = 4, -- defines where the cursor will end up vertically from the begining of if err statement
        })

        set_keymaps(nil)
    end,
}
