local builtin = require("telescope.builtin")
local find_git_root = require("configs.telescope.find-git-root")

-- Custom live_grep function to search in git root
local function live_grep_git_root()
    local git_root = find_git_root()
    if git_root then
        builtin.live_grep({
            search_dirs = { git_root },
        })
    end
end

return live_grep_git_root
