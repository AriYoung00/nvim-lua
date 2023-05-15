local function loadrequire(mod)
    local function requiref(mod)
        require(mod)
    end
    res = pcall(requiref,mod)
    if not(res) then
        -- print("could not find module '" .. mod .. "'")
    end
end
loadrequire("env")

vim.opt.guifont = { "JetBrainsMono Nerd Font", ":h11" }

require("general")
require("plugins/setup")
require("keybinds/general")
require("keybinds/lsp")
