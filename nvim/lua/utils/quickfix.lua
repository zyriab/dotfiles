local M = {}

M.toggle = function()
    if vim.fn.empty(vim.fn.filter(vim.fn.getwininfo(), "v:val.quickfix")) == 1
    then
        vim.cmd("copen")
    else
        vim.cmd("cclose")
    end
end

return M
