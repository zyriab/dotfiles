local M = {}

-- Format the current buffer using the LSP formatter.
-- Skips the frontmatter if present. (starts and ends with "---[a-zA-Z]*")
M.lsp_format_skip_frontmatter = function()
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    local in_frontmatter = false
    local start_line, end_line

    for i, line in ipairs(lines) do
        if line:match("^%-%-%-[%w]*$") then
            if not in_frontmatter then
                in_frontmatter = true
                start_line = i
            else
                end_line = i
                break
            end
        end
    end

    if start_line and end_line then
        -- Format everything except the frontmatter
        vim.lsp.buf.format({
            range = {
                ["start"] = { 1, 0 },
                ["end"] = { start_line - 1, 0 },
            },
        })
        vim.lsp.buf.format({
            range = {
                ["start"] = { end_line + 1, 0 },
                ["end"] = { #lines, 0 },
            },
        })
    else
        -- If no frontmatter, format the whole file
        vim.lsp.buf.format()
    end
end

return M
