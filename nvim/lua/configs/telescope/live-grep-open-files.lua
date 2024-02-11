local builtin = require("telescope.builtin")

local function telescope_live_grep_open_files()
    builtin.live_grep({
        grep_open_files = true,
        prompt_title = "Live Grep in Open Files",
    })
end

return telescope_live_grep_open_files
