local function loadrequire(mod)
    local function requiref(mod)
        require(mod)
    end
    res = pcall(requiref,mod)
    if not(res) then
        print("could not find module '" .. mod .. "'")
    end
end
loadrequire("env")

require("general")
require("plugins/setup")
require("keybinds/general")
require("keybinds/lsp")
-- require("keybinds/coc")
