local M = {}

M.insert_epitech_header = function()
    local filename = vim.fn.expand("%:t")
    local current_year = os.date("%Y")
    local description = vim.fn.input("File description: ")
    local header = string.format([[
/*
** EPITECH PROJECT, %s
** %s
** File description: 
** %s
*/
]], current_year, filename, description)
    vim.api.nvim_buf_set_lines(0, 0, 0, false, vim.split(header, "\n"))
end

function M.setup()
    vim.api.nvim_set_keymap("n", "<Leader>h", ":lua require'epitech.header'.insert_epitech_header()<CR>", { noremap = true, silent = true })
end

return M

