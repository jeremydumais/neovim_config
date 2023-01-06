vim.opt.termguicolors = true
require("bufferline").setup {
    options = { 
        color_icons = true,
        separator_style = "thin",
        always_show_bufferline = true,
        diagnostics = "nvim_lsp",
    
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
            local s = " "
            for e, n in pairs(diagnostics_dict) do
                local sym = e == "error" and " "
                or (e == "warning" and " " or "" )
                s = s .. n .. sym
            end
            return s
        end
    }
}

vim.keymap.set("n", "<C-Left>", "<cmd>BufferLineCyclePrev<cr>")
vim.keymap.set("n", "<C-Right>", "<cmd>BufferLineCycleNext<cr>")
