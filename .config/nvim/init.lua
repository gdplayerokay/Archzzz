-- ================================
-- Bootstrap lazy.nvim
-- ================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
    end
    vim.opt.rtp:prepend(lazypath)

    require("lazy").setup({

        -- ================================
        -- Blue-themed Colorscheme: Tokyonight
        -- ================================
        {
        'morhetz/gruvbox', 
        name = 'gruvbox', 
        config = function()
            -- Optional: Set up Catppuccin color scheme
            vim.cmd('colorscheme gruvbox')
        end
        },
        -- ================================
        -- Lualine status bar
        -- ================================
        {
            "nvim-lualine/lualine.nvim",
            dependencies = { "kyazdani42/nvim-web-devicons" },
            config = function()
            require('lualine').setup {
                options = {
                    theme = 'tokyonight',
                    section_separators = {'', ''},
                    component_separators = {'', ''},
                    icons_enabled = true,
                },
                sections = {
                    lualine_a = {'mode'},
                    lualine_b = {'branch', 'diff', 'diagnostics'},
                    lualine_c = {'filename'},
                    lualine_x = {'encoding', 'fileformat', 'filetype'},
                    lualine_y = {'progress'},
                    lualine_z = {'location'}
                }
            }
            end,
        },

        -- ================================
        -- Neo-tree file explorer
        -- ================================
        {
            "nvim-neo-tree/neo-tree.nvim",
            branch = "v3.x",
            dependencies = {
                "nvim-lua/plenary.nvim",
                "nvim-tree/nvim-web-devicons",
                "MunifTanjim/nui.nvim",
            },
            config = function()
            require("neo-tree").setup({
                close_if_last_window = true,
                popup_border_style = "rounded",
                enable_git_status = true,
                enable_diagnostics = true,
                default_component_configs = {
                    indent = { padding = 1 },
                    icon = { folder_closed = "", folder_open = "", folder_empty = "" },
                },
                window = { position = "left", width = 30 },
            })

            -- Toggle Neo-tree with Ctrl+n
            vim.keymap.set('n', '<C-n>', ':Neotree toggle<CR>', { noremap = true, silent = true })
            end,
        },

        -- ================================
        -- Alpha start menu
        -- ================================
        {
            "goolord/alpha-nvim",
            dependencies = { "nvim-tree/nvim-web-devicons" },
            config = function()
            local alpha = require("alpha")
            local dashboard = require("alpha.themes.dashboard")

            dashboard.section.header.val = {
                "10101000010101110101010000101001010100100",
                "10101001010101111001100000011100101000011",
                "10110100100010000101010110001010101010000",
                "10101001010100100010000100101001010000010",
                "10101010010101010101001010100101010010101",
                "00001010101011001010100101010100101010010",
            }

            dashboard.section.buttons.val = {
                dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
                          dashboard.button("f", "  Find file", ":Telescope find_files<CR>"),
                          dashboard.button("r", "  Recent files", ":Telescope oldfiles<CR>"),
                          dashboard.button("t", "  Find text", ":Telescope live_grep<CR>"),
                          dashboard.button("c", "  Configuration", ":e ~/.config/nvim/init.lua<CR>"),
                          dashboard.button("q", "  Quit", ":qa<CR>"),
            }

            dashboard.section.footer.val = "W3LC0M3 T0 NV1M!"
            alpha.setup(dashboard.config)
            end,
        },

        -- ================================
        -- Telescope
        -- ================================
        {
            "nvim-telescope/telescope.nvim",
            dependencies = { "nvim-lua/plenary.nvim" },
        },

        -- ================================
        -- LSP Config
        -- ================================
        {
            "neovim/nvim-lspconfig",
        },

        -- ================================
        -- Mason (LSP server manager)
    -- ================================
    {
        "williamboman/mason.nvim",
        config = function() require("mason").setup() end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function() require("mason-lspconfig").setup() end,
    },

    -- ================================
    -- Autocompletion
    -- ================================
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
        },
        config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")

        cmp.setup({
            snippet = {
                expand = function(args)
                luasnip.lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-n>'] = cmp.mapping.select_next_item(),
                                                ['<C-p>'] = cmp.mapping.select_prev_item(),
                                                ['<CR>'] = cmp.mapping.confirm({ select = true }),
                                                ['<C-Space>'] = cmp.mapping.complete(),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
                { name = 'buffer' },
                { name = 'path' },
            })
        })
        end,
    },

    })

    -- ================================
    -- Neovim core settings
    -- ================================
    vim.opt.number = true
    vim.opt.relativenumber = true
    vim.opt.expandtab = true
    vim.opt.shiftwidth = 4
    vim.opt.tabstop = 4
    vim.opt.mouse = "a"
    vim.opt.clipboard = "unnamedplus"
    vim.opt.ignorecase = true
    vim.opt.smartcase = true
    vim.opt.hlsearch = true
    vim.opt.splitright = true
    vim.opt.splitbelow = true

    -- ================================
    -- LSP keybindings
    -- ================================
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { noremap=true, silent=true })
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { noremap=true, silent=true })
    vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, { noremap=true, silent=true })
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { noremap=true, silent=true })
    vim.keymap.set('n', 'C-s>', ':w')

    vim.keymap.set('n', '<C-n>', ':Neotree toggle<CR>', { noremap = true, silent = true })
    -- ================================
    -- Bootstrap lazy.nvim
    -- ================================
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not vim.loop.fs_stat(lazypath) then
        vim.fn.system({
            "git",
            "clone",
            "--filter=blob:none",
            "https://github.com/folke/lazy.nvim.git",
            "--branch=stable",
            lazypath,
        })
        end
        vim.opt.rtp:prepend(lazypath)

        require("lazy").setup({

            -- ================================
            -- Blue-themed Colorscheme: Tokyonight
            -- ================================
            {
                "folke/tokyonight.nvim",
                config = function()
                require("tokyonight").setup({
                    style = "storm",  -- dark blue variant
                    transparent = false,
                    terminal_colors = true,
                    styles = {
                        comments = { italic = true },
                        keywords = { italic = true },
                    },
                })
                vim.cmd("colorscheme tokyonight")
                end,
            },

            -- ================================
            -- Lualine status bar
            -- ================================
            {
                "nvim-lualine/lualine.nvim",
                dependencies = { "kyazdani42/nvim-web-devicons" },
                config = function()
                require('lualine').setup {
                    options = {
                        theme = 'tokyonight',
                        section_separators = {'', ''},
                        component_separators = {'', ''},
                        icons_enabled = true,
                    },
                    sections = {
                        lualine_a = {'mode'},
                        lualine_b = {'branch', 'diff', 'diagnostics'},
                        lualine_c = {'filename'},
                        lualine_x = {'encoding', 'fileformat', 'filetype'},
                        lualine_y = {'progress'},
                        lualine_z = {'location'}
                    }
                }
                end,
            },

            -- ================================
            -- Neo-tree file explorer
            -- ================================
            {
                "nvim-neo-tree/neo-tree.nvim",
                branch = "v3.x",
                dependencies = {
                    "nvim-lua/plenary.nvim",
                    "nvim-tree/nvim-web-devicons",
                    "MunifTanjim/nui.nvim",
                },
                config = function()
                require("neo-tree").setup({
                    close_if_last_window = true,
                    popup_border_style = "rounded",
                    enable_git_status = true,
                    enable_diagnostics = true,
                    default_component_configs = {
                        indent = { padding = 1 },
                        icon = { folder_closed = "", folder_open = "", folder_empty = "" },
                    },
                    window = { position = "left", width = 30 },
                })

                -- Toggle Neo-tree with Ctrl+n
                vim.keymap.set('n', '<C-n>', ':Neotree toggle<CR>', { noremap = true, silent = true })
                end,
            },

            -- ================================
            -- Alpha start menu
            -- ================================
            {
                "goolord/alpha-nvim",
                dependencies = { "nvim-tree/nvim-web-devicons" },
                config = function()
                local alpha = require("alpha")
                local dashboard = require("alpha.themes.dashboard")

                dashboard.section.header.val = {
                    "10101000010101110101010000101001010100100",
                    "10101001010101111001100000011100101000011",
                    "10110100100010000101010110001010101010000",
                    "10101001010100100010000100101001010000010",
                    "10101010010101010101001010100101010010101",
                    "00001010101011001010100101010100101010010",
                }

                dashboard.section.buttons.val = {
                    dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
                              dashboard.button("f", "  Find file", ":Telescope find_files<CR>"),
                              dashboard.button("r", "  Recent files", ":Telescope oldfiles<CR>"),
                              dashboard.button("t", "  Find text", ":Telescope live_grep<CR>"),
                              dashboard.button("c", "  Configuration", ":e ~/.config/nvim/init.lua<CR>"),
                              dashboard.button("q", "  Quit", ":qa<CR>"),
                }

                dashboard.section.footer.val = "W3LC0M3 T0 NV1M!"
                alpha.setup(dashboard.config)
                end,
            },

            -- ================================
            -- Telescope
            -- ================================
            {
                "nvim-telescope/telescope.nvim",
                dependencies = { "nvim-lua/plenary.nvim" },
            },

            -- ================================
            -- LSP Config
            -- ================================
            {
                "neovim/nvim-lspconfig",
            },

            -- ================================
            -- Mason (LSP server manager)
        -- ================================
        {
            "williamboman/mason.nvim",
            config = function() require("mason").setup() end,
        },
        {
            "williamboman/mason-lspconfig.nvim",
            config = function() require("mason-lspconfig").setup() end,
        },

        -- ================================
        -- Autocompletion
        -- ================================
        {
            "hrsh7th/nvim-cmp",
            dependencies = {
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-path",
                "hrsh7th/cmp-cmdline",
                "L3MON4D3/LuaSnip",
                "saadparwaiz1/cmp_luasnip",
            },
            config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            cmp.setup({
                snippet = {
                    expand = function(args)
                    luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-n>'] = cmp.mapping.select_next_item(),
                                                    ['<C-p>'] = cmp.mapping.select_prev_item(),
                                                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                                                    ['<C-Space>'] = cmp.mapping.complete(),
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                    { name = 'buffer' },
                    { name = 'path' },
                })
            })
            end,
        },

        })

        -- ================================
        -- Neovim core settings
        -- ================================
        vim.opt.number = true
        vim.opt.relativenumber = true
        vim.opt.expandtab = true
        vim.opt.shiftwidth = 4
        vim.opt.tabstop = 4
        vim.opt.mouse = "a"
        vim.opt.clipboard = "unnamedplus"
        vim.opt.ignorecase = true
        vim.opt.smartcase = true
        vim.opt.hlsearch = true
        vim.opt.splitright = true
        vim.opt.splitbelow = true

        -- ================================
        -- LSP keybindings
        -- ================================
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { noremap=true, silent=true })
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, { noremap=true, silent=true })
        vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, { noremap=true, silent=true })
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { noremap=true, silent=true })

        vim.keymap.set('n', '<C-n>', ':Neotree toggle<CR>', { noremap = true, silent = true })
