local Theme = {
    Unknown = -1,
    Dark  = 0,
    Light = 1
};

local function getSysTheme()
    -- non-portable macos hack for now
    -- the following line makes it unix-generic as well
    if vim.fn.executable("defaults") == 0 then
        return Theme.Unknown
    end

    local handle = io.popen('defaults read -g AppleInterfaceStyle')
    local output = ""
    if handle ~= nil then
        output = handle:read("*a")
    end

    if handle == nil or not string.find(output, "Dark") then
        return Theme.Light
    else
        return Theme.Dark
    end
end

local function getStyle()
    local output = getSysTheme()

    if output == Theme.Dark or output == Theme.Unknown then
        return 'deep'
    else -- theme must be light
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
