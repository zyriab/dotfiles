return function(bufnr)
	local format_buffer = require("configs.lsp.format-buffer")

	local nmap = function(keys, func, desc)
		if desc then
			desc = "LSP: " .. desc
		end

		vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
	end

	nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
	nmap("<leader>ca", function()
		vim.lsp.buf.code_action({ context = { only = { "quickfix", "refactor", "source" } } })
	end, "[C]ode [A]ction")

	nmap("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
	nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
	nmap("gi", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
	nmap("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
	nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
	nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

	-- See `:help K` for why this keymap
	nmap("K", vim.lsp.buf.hover, "Hover Documentation")
	-- nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

	-- Lesser used LSP functionality
	nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
	nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
	nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
	nmap("<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, "[W]orkspace [L]ist Folders")

	-- [[ Diagnostic ]]
	nmap("[d", vim.diagnostic.goto_prev, "Go to previous [[] [D]iagnostic message")
	nmap("]d", vim.diagnostic.goto_next, "Go to next []] [D]agnostic message")
	nmap("<leader>df", vim.diagnostic.open_float, "Open [D]iagnostic [F]loating window")
	nmap("<leader>dl", vim.diagnostic.setqflist, "Open [D]iagnostics [L]ist")

	-- [[ Format ]]
	nmap("<leader>fm", format_buffer, "[F]or[M]at the current buffer with LSP")

	-- [[ Go (through `go.nvim`) ]]

	-- Linting/vetting
	nmap("<leader>glt", function()
		vim.cmd("GoLint")
	end, "Go: [L]in[T] buffer with golangci-lint")
	nmap("<leader>gvt", function()
		vim.cmd("GoVet")
	end, "Go: [V]e[T] current buffer")

	-- Autofills
	nmap("<leader>gfst", function()
		vim.cmd("GoFillStruct")
	end, "Go: [F]ill [S][T]ruct")
	nmap("<leader>gfsw", function()
		vim.cmd("GoFillSwitch")
	end, "Go: [F]ill [S][W]itch")
	nmap("<leader>gfie", function()
		vim.cmd("GoIfErr")
	end, "Go: Insert [I]f [E]rr return err")

	-- Testing
	nmap("<leader>gtfn", function()
		vim.cmd("GoTestFunc")
	end, "Go: [T]est current [F]u[N]ction")
	nmap("<leader>gtfl", function()
		vim.cmd("GoTestFile")
	end, "Go: [T]est current [F]i[l]e")
	nmap("<leader>gtpk", function()
		vim.cmd("GoTestPkg")
	end, "Go: [T]est [P]a[K]age/folder")
	nmap("<leader>gaft", function()
		vim.cmd("GoAddTest")
	end, "Go: [A]dd current [F]unction [T]est")
	nmap("<leader>gaet", function()
		vim.cmd("GoAddExpTest")
	end, "Go: [A]dd [E]xported functions [T]ests")
	nmap("<leader>gaat", function()
		vim.cmd("GoAddAllTest")
	end, "Go: [A]dd [A]ll functions [T]ests")
	nmap("<leader>gts", function()
		vim.cmd("GoAltV")
	end, "Go: Open [T]est alternative file in [S]plit")
	nmap("<leader>gtS", function()
		vim.cmd("GoAltV!")
	end, "Go: Open [T]est alternative file in [S]plit (keep focus)")

	-- Tags
	nmap("<leader>gat", function()
		vim.cmd("GoAddTag")
	end, "Go: [A]dd  [T]ags")
	nmap("<leader>gct", function()
		vim.cmd("GoClearTag")
	end, "Go: [C]lear [T]ags")

	-- Misc.
	nmap("<leader>ggt", function()
		vim.cmd("GoGet")
	end, "Go: [G]e[T] package on current line")
	nmap("<leader>gip", function()
		local input = vim.fn.input("Target: ")
		vim.cmd(string.format("GoImpl %s", input))
	end, "Go: [I]m[P]lement struct/interface")

	-- Doc
	nmap("<leader>gdc", function()
		local input = vim.fn.input("API: ")
		vim.cmd(string.format("GoDoc %s", input))
	end, "Go: Open [D]o[C]umentation")
	nmap("<leader>gcs", function()
		local input = vim.fn.input("API: ")
		local buf = vim.api.nvim_create_buf(false, true)

		vim.cmd("vsplit")
		vim.api.nvim_win_set_buf(vim.api.nvim_get_current_win(), buf)

		local cmd = string.format('curl -s "cht.sh/go/%s?T"', input)
		local content = vim.fn.systemlist(cmd)

		if content == nil then
			vim.notify("Could not fetch cheatsheet (nil response)", vim.log.levels.ERROR)
			return
		end

		-- use `set_option_value`
		-- vim.api.set_
		vim.api.nvim_set_option_value("filetype", "go", { buf = buf })
		vim.api.nvim_buf_set_lines(buf, 0, -1, false, content)
	end, "Go: Open [C]heat[S]eet")
end
