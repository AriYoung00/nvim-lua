local vim = vim
local opt = vim.opt
local g   = vim.g

-- disable netrw for nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Set shell
-- commented for now, is this necessary?
-- if vim.o.shell:match("fish$") then
--     vim.o.shell = "sh"
-- end


-- Enable mouse mode
opt.mouse = "a"

-- Conceal level
opt.conceallevel = 2

-- Folding config
-- opt.foldmethod  = 'expr'
-- opt.foldexpr    = 'nvim_treesitter#foldexpr()'
opt.foldmethod  = 'syntax'
opt.foldnestmax = 2

-- Set correct tab behavior
opt.tabstop     = 4
opt.softtabstop = 4
opt.shiftwidth  = 4
opt.textwidth   = 80
opt.expandtab   = true

-- Other misc configuration
opt.smartindent = true
opt.visualbell  = true
opt.splitbelow  = true
opt.number      = true

-- airline/powerline/statusline config
opt.laststatus = 2

-- RANDOM PLUGIN CONFIG SECTION --
g.bullets_enabled_file_types = { 'markdown', 'text', 'gitcommit', 'scratch' }
g.tex_flavor = 'latex'
g.vimtex_quickfix_mode = 0

-- restore cursor position
function Set_cursor_position()
  local line = vim.fn.line
  local last_pos = line("'\"")
  local total_lines = line("$")
  if last_pos > 1 and last_pos <= total_lines then
    vim.api.nvim_command('normal! g`"')
  end
end
vim.api.nvim_command('autocmd BufReadPost * lua Set_cursor_position()')


-- Set terminal cursor shapes
opt.termguicolors = true
vim.cmd([[
  let &t_SI = "\<esc>[5 q"
  let &t_SR = "\<esc>[3 q"
  let &t_EI = "\<esc>[ q"
]])
