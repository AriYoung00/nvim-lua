require('bufferline').setup {
    options = {
        diagnostics = 'coc',
        offsets = {
            {
                filetype = "NvimTree",
                text = "File Explorer",
                highlight = "Directory",
                text_align = "center",
                separator = true
            }
        },
        color_icons = true,
        separator_style = 'thick'
    }
}
