local M = {}

M.insert_epitech_header = function()
    local filename = vim.fn.expand("%:t")
    local filename_no_ext = vim.fn.expand("%:t:r")
    local filetype = vim.bo.filetype
    local current_year = os.date("%Y")
    local description = vim.fn.input("File description: ", filename_no_ext)
    local comment_styles = {
        c = {"/*", "**", "*/"},
        cpp = {"/*", "**", "*/"},
        haskell = {"{-", "--", "-}"},
        python = {"##", "##", "##"},
        asm = {";", ";;", ";"},
        makefile = {"##", "##", "##"},
    }

    -- Setup the base header
    local style = comment_styles[filetype] or {"/*", "**", "*/"}
    local header = string.format("%s\n%s EPITECH PROJECT, %s\n%s %s\n%s File description:\n%s %s\n%s",
        style[1], style[2], current_year, style[2], filename, style[2], style[2], description, style[3])

    -- Setup the Preprocessor directive
    local is_header = filename:match("%.h$") or filename:match("%.hpp$")

    if is_header then
        local default_guard = "__" .. string.upper(filename_no_ext) .. "_H__"
        local guard_name = vim.fn.input("Preprocessor directive name: ", default_guard)
        if guard_name == "" then
            guard_name = default_guard
        end
        header = header .. "\n\n#ifndef " .. guard_name .. "\n    #define " .. guard_name .. "\n\n\n\n#endif /* !" .. guard_name .. " */"
    end

    vim.api.nvim_buf_set_lines(0, 0, 0, false, vim.split(header, "\n"))
end

M.setup = function(opts)
    opts = opts or {}
    vim.api.nvim_set_keymap("n", "<Leader>h", ":lua require'header'.insert_epitech_header()<CR>", { noremap = true, silent = true })
end

return M
