local M = {}

-- Format the current buffer using the LSP formatter.
-- Skips the frontmatter if present. (starts and ends with "---[a-zA-Z]*")
M.lsp_format_skip_frontmatter = function()
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    local in_frontmatter = false
    local frontmatter_start_line, frontmatter_end_line

    for i, line in ipairs(lines) do
        if line:match("^%-%-%-[%w]*$") then
            if not in_frontmatter then
                in_frontmatter = true
                frontmatter_start_line = i
            else
                frontmatter_end_line = i
                break
            end
        end
    end

    if frontmatter_start_line and frontmatter_end_line then
        -- Format everything except the frontmatter

        vim.lsp.buf.format({
            range = {
                ["start"] = { frontmatter_end_line + 1, 0 },
                ["end"] = { #lines + 1, 0 },
            },
        })
    else
        -- If no frontmatter, format the whole file
        vim.lsp.buf.format()
    end
end

return M
