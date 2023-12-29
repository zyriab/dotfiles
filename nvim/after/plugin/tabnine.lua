local tabnine = require("tabnine")
local status = require("tabnine.status")

tabnine.setup({
  disable_auto_comment=false,
  accept_keymap="<Tab>",
  dismiss_keymap = "<C-]>",
  debounce_ms = 800,
  suggestion_color = {gui = "#808080", cterm = 244},
  exclude_filetypes = {"TelescopePrompt"},
  log_file_path = nil, -- absolute path to Tabnine log file
})

status.status()
