-- local os_utils = require("utils.os")

-- if os_utils.is_linux() then
-- xiyaowong/transparent.nvim
vim.cmd("TransparentEnable")
vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "none" })
-- end
