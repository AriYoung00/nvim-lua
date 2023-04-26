local function getSysTheme()
    local handle = io.popen('defaults read -g AppleInterfaceStyle')

    if handle == nil then
        return ""
    else
        return handle:read('*a')
    end
end

local function getStyle()
    local output = getSysTheme()
    if string.find(output, 'Dark') then
        return 'deep'
    else
        return 'light'
    end
end

local theme_style = getStyle()
require('onedark').setup {
    style = theme_style,
    toggle_style_key = '<leader>ts',
    toggle_style_list = {'deep', 'light'},
    code_style = {
        comments = 'italic',
        keywords = 'bold',
        functions = 'italic',
        strings = 'none',
        -- variables = 'italic'
    },
}
require('onedark').load()

-- this snippet is necessary to get onedark to load light theme correctly
-- not sure why
if theme_style == 'light' then
    vim.o.background = 'light'
else
    vim.o.background = 'dark'
end
