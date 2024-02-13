local telescope = require("telescope")
return function()
    -- Enable telescope fzf native, if installed
    pcall(telescope.load_extension, "fzf")

    -- Enable live grep args, if installed
    pcall(telescope.load_extension, "live_grep_args")
end