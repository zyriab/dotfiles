local M = {}

local function get_git_diff(buf)
    local icons = { removed = "", changed = "", added = "" }
    local signs = vim.b[buf].gitsigns_status_dict
    local labels = {}
    if signs == nil then
        return labels
    end
    for name, icon in pairs(icons) do
        if tonumber(signs[name]) and signs[name] > 0 then
            table.insert(labels, { " " .. icon .. signs[name] .. " ", group = "Diff" .. name })
        end
    end
    if #labels > 0 then
        table.insert(labels, { "┊ " })
    end
    return labels
end

local function get_diagnostic_label(buf)
    local icons = { error = "", warn = "", info = "", hint = "󱧡" }
    local label = {}

    for severity, icon in pairs(icons) do
        local n = #vim.diagnostic.get(buf, { severity = vim.diagnostic.severity[string.upper(severity)] })
        if n > 0 then
            table.insert(label, { icon .. n .. " ", group = "DiagnosticSign" .. severity })
        end
    end
    if #label > 0 then
        table.insert(label, { "┊" })
    end
    return label
end

M.get = function(props)
    local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
    local ft_icon, ft_color = require("nvim-web-devicons").get_icon_color(filename)
    local text_styling = vim.bo[props.buf].modified and "bold,italic" or "bold"

    local diag_label = get_diagnostic_label(props.buf)
    local git_diff = get_git_diff(props.buf)
    local icon = { (ft_icon or ""), " ", guifg = ft_color, guibg = "none" }
    local name = { filename, gui = text_styling }

    return {
        " ",
        diag_label,
        git_diff,
        icon,
        name,
        " ",
    }
end
return M