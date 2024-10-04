local M = {}

-- Executes the given command or print the error if it failed
-- Use this instead of `vim.cmd("%!foo %")`
--
--- @param cmd (string[]) Command to execute w/ arguments
--- @return boolean success Whether the operation succeeded or not
M.run_command_on_buffer = function(cmd)
    local buf_content = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    local opts = {
        stdin = buf_content,
        text = true,
    }

    local ok, result = pcall(function()
        return vim.system(cmd, opts):wait()
    end)

    if not ok then
        vim.notify_once("Error running " .. cmd[1] .. ": " .. result, vim.log.levels.ERROR)

        return false
    end

    if result.code ~= 0 then
        local out = result.stderr
        if out == "" and result.stdout ~= "" then
            out = result.stdout
        end

        vim.notify_once("Could not format file: " .. out, vim.log.levels.ERROR)

        return false
    end

    local formatted = vim.split(result.stdout, "\n")

    -- Removing the empty line at the end
    if formatted[#formatted] == "" then
        table.remove(formatted, #formatted)
    end

    vim.api.nvim_buf_set_lines(0, 0, -1, false, formatted)

    return true
end

-- Format the current buffer using the LSP formatter.
-- Skips the frontmatter if present. (starts and ends with "---[a-zA-Z]*")
M.lsp_format_skip_frontmatter = function()
    local lines = vim.api.nvim_buf_get_lines(0, 0, -2, false)
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
