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
    use 'sheerun/vim-polyglot'
    use 'dkarter/bullets.vim'
    use 'justinmk/vim-sneak'
    use 'jackguo380/vim-lsp-cxx-highlight'
    use 'kyazdani42/nvim-web-devicons'
    use "HiPhish/nvim-ts-rainbow2"
    use "folke/neodev.nvim"
    use "onsails/lspkind.nvim"
    use 'stevearc/dressing.nvim'


    use {
      'nvim-telescope/telescope.nvim', branch = '0.1.x',
    }

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true },
        config = function() require('lualine').setup{ options = { theme = 'onedark'} } end
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
        'williamboman/mason.nvim',
    }

    use {
        'simrat39/rust-tools.nvim',
        config = function ()
            local rt = require('rust-tools')
            rt.setup({
              server = {
                on_attach = function(_, _bufnr)
                  -- Hover actions
                  rt.inlay_hints.enable()
                end,
              },
            })
        end
    }
    use {
        'williamboman/mason-lspconfig.nvim',
        config = function()
            require('neodev').setup{ lspconfig = false }
            require('mason').setup()
            require('mason-lspconfig').setup()
            require('mason-lspconfig').setup_handlers {
                function(server_name)
                    local capabilities = require('cmp_nvim_lsp').default_capabilities()
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities
                    }
                end,
                ["lua_ls"] = function()
                    local caps = require('cmp_nvim_lsp').default_capabilities()
                    require("lspconfig").lua_ls.setup{ before_init = require("neodev.lsp").before_init }
                end,
                ["rust_analyzer"] = function()
                    require("rust-tools").setup {}
                end
            }
        end
    }

    use {
        'neovim/nvim-lspconfig',
        config = function() require("plugins/config/lsp") end
    }

    use {
        'simrat39/inlay-hints.nvim',
        config = function () require('inlay-hints').setup() end
    }

    -- completion
    use {
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        tag = "v1.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!:).
        run = "make install_jsregexp"
    }

    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use {
        'hrsh7th/nvim-cmp',
        config = function() require('plugins/config/cmp') end
    }

    use {
        'lewis6991/gitsigns.nvim',
        config = function() require('gitsigns').setup() end
    }

    use {
        'akinsho/bufferline.nvim',
        config = function() require("plugins/config/bufferline") end
    }

    use {
        'windwp/nvim-autopairs',
        config = function() 
            local npairs = require('nvim-autopairs')
            local Rule = require('nvim-autopairs.rule')
            npairs.setup { check_ts = true }
            npairs.add_rules(require('nvim-autopairs.rules.endwise-lua'))
            npairs.add_rules({ Rule('<', '>', {'rs', 'rust'}) })
        end
    }

    use "windwp/nvim-ts-autotag"
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
                additional_vim_regex_highlighting = false,
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
                autotag = {
                    enable = true
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

