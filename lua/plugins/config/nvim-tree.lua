local tree = require('nvim-tree')
local api = require('nvim-tree.api')

local function open_nvim_tree(data)
  -- buffer is a directory
  local directory = vim.fn.isdirectory(data.file) == 1
  local no_name = data.file == "" and vim.bo[data.buf].buftype == ""

  if not directory and not no_name then
    return
  end



  -- change to the directory
  -- vim.cmd.cd(data.file)

  -- open the tree
  api.tree.open()
end

-- local function maybe_close_nvim_tree(ev)
--   local function count_nonhidden_buffers()
--     local count = 0
--     for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
--       local bufopt = vim.api.nvim_buf_get_option(bufnr, 'buflisted')
--       if bufopt and bufopt ~= 0 and not vim.api.nvim_buf_get_option(bufnr, 'bufhidden') then
--         count = count + 1
--       end
--     end
--     return count
--   end
--   local function get_cur_buf_name()
--     local bufnr = vim.api.nvim_get_current_buf()
--     return vim.api.nvim_buf_get_name(bufnr)
--   end
-- 
--   print("name" .. vim.bo.name)
--   if count_nonhidden_buffers() == 0 and (vim.bo.filetype == 'NvimTree' or get_curthen
--     vim.cmd(":qa")
--   end
-- end


vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
-- vim.api.nvim_create_autocmd({ "BufDelete" }, { pattern =  "*", callback = maybe_close_nvim_tree })
tree.setup {
    hijack_cursor = true,
    hijack_unnamed_buffer_when_opening = true,

    diagnostics = {
      enable = true,
      show_on_dirs = true,
    },

    tab = {
      sync = {
        open = true,

      }
    },
}

