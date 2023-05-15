local opts = { noremap = true, silent = true }
local map = vim.api.nvim_set_keymap
local keyset = vim.keymap.set

local nmap = function(lhs, rhs) map('n', lhs, rhs, opts) end
local imap = function(lhs, rhs) map('i', lhs, rhs, opts) end
local vmap = function(lhs, rhs) map('v', lhs, rhs, opts) end
local xmap = function(lhs, rhs) map('x', lhs, rhs, opts) end
local tmap = function(lhs, rhs) map('t', lhs, rhs, opts) end


-- Disable arrow keys
map('', '<up>', '<nop>', opts)
map('', '<down>', '<nop>', opts)
map('', '<left>', '<nop>', opts)
map('', '<right>', '<nop>', opts)

-- random
imap('jj', '<Esc>')

-- paste from system keyboard
nmap('<Leader>y', '"+y')
vmap('<Leader>y', '"+y')
nmap('<Leader>p', '"+p')
vmap('<Leader>p', '"+p')


    -- keep highlighting when shifting indent
vmap('>', '>gv')
vmap('<', '<gv')
xmap('>', '>gv')
xmap('<', '<gv')


-- misc plugin config (less than 5 lines each)
-- Nvim-tree
nmap('<Leader>tt', ':NvimTreeToggle<CR>')
nmap('<Leader>gt', ':NvimTreeFocus<CR>')

-- terminal stuff
tmap('<Leader><Esc>', '<C-\\><C-n>')
nmap('<c-/>', ':ToggleTerm direction=float<CR>')
nmap('<c-?>', ':ToggleTerm direction=horizontal<CR>')
tmap('<c-/>', '<C-\\><C-n>:ToggleTerm<CR>')

-- move between windows using alt+dir
nmap('<M-h>', '<C-w>h')
nmap('<M-j>', '<C-w>j')
nmap('<M-k>', '<C-w>k')
nmap('<M-l>', '<C-w>l')

-- nvim window picker
keyset('n', 'gs', function()
    local picked_window_id = require('window-picker').pick_window() or vim.api.nvim_get_current_win()
    vim.api.nvim_set_current_win(picked_window_id)
end, { desc = "Pick a window" })


-- bufferline
nmap('gb', ":BufferLinePick<CR>")
nmap('bd', ':BufferLinePickClose<CR>')


-- telescope
local tscope = require('telescope.builtin')
keyset('n', '<leader>ff', tscope.find_files, {})
keyset('n', '<leader>fg', tscope.live_grep, {})
keyset('n', '<leader>fb', tscope.buffers, {})
keyset('n', '<leader>fh', tscope.help_tags, {})
