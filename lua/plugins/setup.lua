local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'nvim-lua/plenary.nvim'

    -- use {
    --     'glacambre/firenvim',
    --     config = function() vim.fn['firenvim#install'](0) end
    -- }

    use 'lervag/vimtex'
    use 'dag/vim-fish'
    -- use 'sirver/ultisnips'
    use 'sheerun/vim-polyglot'
    use 'dkarter/bullets.vim'
    use 'justinmk/vim-sneak'
    use 'jackguo380/vim-lsp-cxx-highlight'
    use 'kyazdani42/nvim-web-devicons'
    use "HiPhish/nvim-ts-rainbow2"

    use {
      'nvim-telescope/telescope.nvim', branch = '0.1.x',
    }

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true },
        config = function() require('lualine').setup() end
    }

    use {
        'cespare/vim-toml', branch = 'main'
    }

    use {
        'navarasu/onedark.nvim',
        config = function () require('plugins/config/onedark') end
    }

    use {
        's1n7ax/nvim-window-picker',
        config = function() require('window-picker').setup() end
    }

    use {
        'nvim-tree/nvim-tree.lua',
        config = function() require('plugins/config/nvim-tree') end
    }

    use {
        'neoclide/coc.nvim', branch = 'release',
        config = function()
            -- some plugins have issues with backup
            vim.opt.backup = false
            vim.opt.writebackup = false

            -- Having longer updatetime (default is 4000 ms = 4s) leads 
            -- to noticeable delays and poor user experience
            vim.opt.updatetime = 300

            -- Always show the signcolumn, otherwise it would shift the 
            -- text each time diagnostics appeared/became resolved
            vim.opt.signcolumn = "yes"
        end
    }

    use {
        'lewis6991/gitsigns.nvim',
        config = function() require('gitsigns').setup() end
    }

    use {
        'akinsho/bufferline.nvim',
        config = function() require("plugins/config/bufferline") end
    }

    -- use(
    --     { "jackMort/ChatGPT.nvim",
    --     config = function()
    --       require("chatgpt").setup()
    --     end,
    --     requires = {
    --       "MunifTanjim/nui.nvim",
    --       "nvim-lua/plenary.nvim",
    --       "nvim-telescope/telescope.nvim"
    --     }
    -- })

    -- use {
    --     'windwp/nvim-autopairs',
    --     config = function() 
    --         require('nvim-autopairs').setup {
    --             bind_cr = false
    --         }
    --     end
    -- }

    use {
        'nvim-treesitter/nvim-treesitter',
        config = function()
            require('nvim-treesitter').setup {
                ensure_installed = { 'c', 'lua', 'rust' },
                sync_install = false,
                auto_install = true,
                highlight = {
                    enable = true,
                    disable = function(lang, buf)
                        local max_filesize = 100*1024
                        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                        if ok and stats and stats.size > max_filesize then
                            return true
                        end
                    end
                },
                additional_vim_regex_highlighting = false
            }

            require('nvim-treesitter.configs').setup {
                ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "rust", "python" },

                rainbow = {
                    enable = true,
                    -- list of languages you want to disable the plugin for
                    -- disable = { 'jsx', 'cpp' },
                    -- Which query to use for finding delimiters
                    query = 'rainbow-parens',
                    -- Highlight the entire buffer all at once
                    strategy = require('ts-rainbow').strategy.global,
                },
                highlight = {
                    enable = true,

                    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
                    disable = function(lang, buf)
                        local max_filesize = 256 * 1024 -- 256 KB
                        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                        if ok and stats and stats.size > max_filesize then
                            return true
                        end
                    end,

                    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                    -- Using this option may slow down your editor, and you may see some duplicate highlights.
                    -- Instead of true it can also be a list of languages
                    additional_vim_regex_highlighting = false,
                  },
            }
        end
    }

    use {
        'Pocco81/auto-save.nvim',
        config = function() require('auto-save').setup() end
    }

    use {
        "akinsho/toggleterm.nvim", tag = '*', 
        config = function() 
            require("toggleterm").setup {
                open_mapping = nil,
                direction = 'float'
            }
        end
    }

    if packer_bootstrap then
        require('packer').sync()
    end
end)

