---@diagnostic disable: undefined-global

-- Error theme:
vim.cmd('colorscheme habamax')
--0=========================================================================0
-- █▀ █▀▀ ▀█▀ ▀█▀ █ █▄░█ █▀▀ █▀
-- ▄█ ██▄ ░█░ ░█░ █ █░▀█ █▄█ ▄█
--0=========================================================================0

-- Global Settings
vim.g.mapleader = ' ' -- Setting the leader key

-- Keymap Variables
local remap = vim.keymap.set

-- Terminal and Title Settings
vim.opt.title = true
vim.opt.titlestring = '%t'

-- Indentation and Formatting Settings
vim.opt.autoindent = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.smarttab = true
vim.opt.tabstop = 4

-- Display Settings
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.mouse = 'a'
vim.opt.showcmd = true
vim.opt.timeoutlen = 300
vim.opt.wildmenu = true
vim.opt.wrap = false
vim.opt.completeopt = 'menu,menuone,noselect'
vim.opt.updatetime = 50
vim.opt.scrolloff = 5
vim.opt.signcolumn = 'yes'

-- List and Match Settings
vim.opt.list = true
vim.opt.listchars = { tab = '  ', leadmultispace = '│   ' }
vim.opt.showmatch = true

-- GUI and Encoding Settings
vim.opt.termguicolors = true
vim.opt.clipboard = 'unnamedplus'
vim.opt.encoding = 'utf-8'

-- Search and Case Settings
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.smartcase = true
vim.opt.smartindent = true

-- Line Number Settings
vim.opt.number = true
--0=========================================================================0
-- █▀█ █▀▀ █▀▄▀█ ▄▀█ █▀█ █▀
-- █▀▄ ██▄ █░▀░█ █▀█ █▀▀ ▄█
--0=========================================================================0
-- QOL:
-- Search centering
remap('n', 'n', 'nzz')
remap('n', 'N', 'Nzz')
-- Deleting to the void
remap('n', 'x', '"_x')
remap('v', 'x', '"_x')
-- Format pasted line
remap('n', 'p', 'p==')
-- Map fj to <Esc>
remap('i', 'fj', '<Esc>')
remap('v', 'fj', '<Esc>')

-- Page movement up/down
remap('n', '<C-k>', '<S-Up>zz')
remap('n', '<C-j>', '<S-Down>zz')
remap('v', '<C-k>', '<S-Up>zz')
remap('v', '<C-j>', '<S-Down>zz')
-- Save file
remap('n', '<C-s>', ':w<CR>')
-- Move selected lines with alt arrows like in subl
remap('v', '<A-k>', ":m '<-2<CR>gv=gv")
remap('v', '<A-j>', ":m '>+1<CR>gv=gv")
remap('n', '<A-k>', ':m .-2<cr>==')
remap('n', '<A-j>', ':m .+1<cr>==')
-- Vertical split
remap('n', '<leader>+', '<Cmd>vsplit<CR>')
-- Horizontal split
remap('n', '<leader>-', '<Cmd>split<CR>')
-- Move in splits with hjkl
remap('n', '<leader>h', '<Cmd>wincmd h<CR>')
remap('n', '<leader>j', '<Cmd>wincmd j<CR>')
remap('n', '<leader>k', '<Cmd>wincmd k<CR>')
remap('n', '<leader>l', '<Cmd>wincmd l<CR>')
remap('t', '<leader>h', '<Cmd>wincmd h<CR>')
remap('t', '<leader>j', '<Cmd>wincmd j<CR>')
remap('t', '<leader>k', '<Cmd>wincmd k<CR>')
remap('t', '<leader>l', '<Cmd>wincmd l<CR>')
-- Resize splits
remap('n', '<S-Left>', '<Cmd>vertical resize -2<CR>')
remap('n', '<S-Right>', '<Cmd>vertical resize +2<CR>')
remap('n', '<S-Up>', '<Cmd>resize -2<CR>')
remap('n', '<S-Down>', '<Cmd>resize +2<CR>')
-- Indent/Unindent selected text with Tab and Shift+Tab
remap('v', '>', '>gv')
remap('v', '<', '<gv')
-- Remove search HL
remap('n', '<leader>nh', '<Cmd>nohlsearch<CR>')
-- New buffer
remap('n', '<leader>t', ':enew<CR>')
-- Next buffer
remap('n', '<Tab>', '<Cmd>bnext<CR>')
-- Previous buffer
remap('n', '<S-Tab>', '<Cmd>bprevious<CR>')
-- Quit current buffer
remap('n', '<leader>q', '<Cmd>bd<CR>')
--0=========================================================================0
-- █░░ ▄▀█ ▀█ █▄█
-- █▄▄ █▀█ █▄ ░█░
--0=========================================================================0
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim' -- Lazy bootstrap starts here
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath) -- Ends here, this should be left alone.
-- Add <Esc> as an option to close the lazy plugins window
require('lazy.view.config').keys.close = '<Esc>'
--0=========================================================================0
-- █▀█ █░░ █░█ █▀▀ █ █▄░█ █▀   █▀ ▀█▀ ▄▀█ █▀█ ▀█▀   █░█ █▀▀ █▀█ █▀▀
-- █▀▀ █▄▄ █▄█ █▄█ █ █░▀█ ▄█   ▄█ ░█░ █▀█ █▀▄ ░█░   █▀█ ██▄ █▀▄ ██▄
--0=========================================================================0
require("lazy").setup({
    {
      'glacambre/firenvim',

      -- Lazy load firenvim
      -- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
      lazy = not vim.g.started_by_firenvim,
      build = function()
        vim.fn["firenvim#install"](0)
      end
    },
    {
      'leet0rz/modified-moonlight.nvim', -- this is the theme
      config = function()
        vim.cmd('colorscheme moonlight') -- this applies the theme
      end
    },
    {
      'windwp/nvim-autopairs',
      config = function()
        require("nvim-autopairs").setup()
      end
    },
    {
      'terrortylor/nvim-comment',
      config = function()
        -- remaps
        remap('n', "'", ':CommentToggle<CR>')
        remap('v', "'", ':CommentToggle<CR>')
        require('nvim_comment').setup()
      end

    },
    --0=============================================================================================0
    -- ▀█▀ █▀▀ █░░ █▀▀ █▀ █▀▀ █▀█ █▀█ █▀▀
    -- ░█░ ██▄ █▄▄ ██▄ ▄█ █▄▄ █▄█ █▀▀ ██▄
    --0=============================================================================================0
    {
      'nvim-telescope/telescope.nvim',
      tag = '0.1.6',
      dependencies = { 'nvim-lua/plenary.nvim' },
      config = function()
        -- remaps
        local builtin = require('telescope.builtin')
        remap('n', '<leader>ff', builtin.find_files)
        remap('n', '<leader>fg', builtin.live_grep)
        remap('n', '<leader>fb', builtin.buffers)
        remap('n', '<leader>fh', builtin.help_tags)
        remap('n', '<leader>fc', builtin.treesitter)
        -- telescope's setup
        require('telescope').setup {
          defaults = {
            sorting_strategy = 'ascending',
            layout_strategy = 'horizontal',
            layout_config = {
              horizontal = {
                prompt_position = 'top',
                preview_width = 0.5,
                results_width = 0.5,
                height = 0.8,
                preview_cutoff = 120,
              }
            },
            mappings = {
              i = {
                ["<C-j>"] = "move_selection_next",
                ["<C-k>"] = "move_selection_previous"
              }
            }
          },
        }
      end
    },
    --0=============================================================================================0
    -- █▀█ █ █░░
    -- █▄█ █ █▄▄
    --0=============================================================================================0
    {
      'stevearc/oil.nvim',
      dependencies = { "nvim-tree/nvim-web-devicons" },
      config = function()
        -- remaps
        remap('n', '<leader>oo', ':Oil<CR>')
        remap('n', '<leader>of', ':Oil --float<CR>')
        require('oil').setup({
          columns = { "icon" },
          default_file_explorer = true,
          keymaps = {
            -- Remove splits and add Ctrl + S for saving
            ["<C-s>"] = ":w<CR>",
            ["<C-h>"] = false,
            -- Adjust close to be my custom <Esc>
            ["<leader>fj"] = "actions.close",
            -- Adjust commands that change cwd
            ["<leader>cd"] = "actions.cd",
            ["<leader>tcd"] = "actions.tcd",
            ["`"] = false,
            ["~"] = false,
          },
          view_options = { show_hidden = true },
        })
      end
    },
    --0=============================================================================================0
    -- █▄▄ █░█ █▀▀ █▀▀ █▀▀ █▀█ █░░ █ █▄░█ █▀▀
    -- █▄█ █▄█ █▀░ █▀░ ██▄ █▀▄ █▄▄ █ █░▀█ ██▄
    --0=============================================================================================0
    {
      "akinsho/bufferline.nvim",
      version = "*",
      config = function()
        require("bufferline").setup()
      end
    },
    --0=============================================================================================0
    -- ▀█▀ █▀█ █▀▀ █▀▀ █▀ █░█ █ ▀█▀ ▀█▀ █▀▀ █▀█
    -- ░█░ █▀▄ ██▄ ██▄ ▄█ █▀█ █ ░█░ ░█░ ██▄ █▀▄
    --0=============================================================================================0
    {
      'nvim-treesitter/nvim-treesitter',
      build = ":TSUpdate",
      config = function()
        -- ENABLES THIS IF USING WINDOWS:
        -- require('nvim-treesitter.install').compilers = { 'zig' }
        require('nvim-treesitter.configs').setup {
          ensure_installed = { 'c', 'lua', 'vim', 'vimdoc', 'query' },
          -- Install parsers synchronously (only applied to `ensure_installed`)
          sync_install = false,
          -- Automatically install missing parsers when entering buffer
          auto_install = false,
          highlight = {
            enable = true,
          },
        }
      end
    },
    --0=============================================================================================0
    -- █░░ █░█ ▄▀█ █░░ █ █▄░█ █▀▀
    -- █▄▄ █▄█ █▀█ █▄▄ █ █░▀█ ██▄
    --0=============================================================================================0
    {
      'nvim-lualine/lualine.nvim',
      config = function()
        vim.o.showmode = false
        require('lualine').setup({
          options = {
            icons_enabled = true,
            -- theme = 'dracula',
          },
          -- this part shows full path, helps navigate in Oil.
          sections = {
            lualine_c = { { 'filename', path = 2 } }
          }
        })
      end
    },
    --0=============================================================================================0
    -- █░░ █▀ █▀█
    -- █▄▄ ▄█ █▀▀
    --0=============================================================================================0
    {
      'neovim/nvim-lspconfig',
      config = function()
        local lspconfig = require('lspconfig')
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
        local custom_attach = function(client, bufnr)
          print('Lsp Attached.')
        end
        --0=============================================================================================0
        -- █░░ █░█ ▄▀█ ▄▄ █░░ ▄▀█ █▄░█ █▀▀ █░█ ▄▀█ █▀▀ █▀▀ ▄▄ █▀ █▀▀ █▀█ █░█ █▀▀ █▀█
        -- █▄▄ █▄█ █▀█ ░░ █▄▄ █▀█ █░▀█ █▄█ █▄█ █▀█ █▄█ ██▄ ░░ ▄█ ██▄ █▀▄ ▀▄▀ ██▄ █▀▄
        --0=============================================================================================0
        lspconfig.lua_ls.setup({
          on_attach = custom_attach,
          capabilities = capabilities,
          settings = {
            Lua = {
              runtime = {
                version = 'LuaJIT',
              },
              diagnostics = {
                enable = true,
                -- enable = false,
              },
              workspace = {
                checkThirdParty = false,
                library = {
                  vim.env.VIMRUNTIME,
                },
              },
              telemetry = { enable = false },
            },
          },
        })
        -- new server goes here:
        -- lspconfig.SERVER.setup({
        --    on_attach = custom_attach,
        --    capabilities = capabilities
        --    COPY PASTE SERVER SETTINGS HERE
        --})
      end
    },
    --0=============================================================================================0
    -- █▀▀ █▀▄▀█ █▀█
    -- █▄▄ █░▀░█ █▀▀
    --0=============================================================================================0
    {
      'hrsh7th/nvim-cmp',
      event = 'InsertEnter',
      dependencies = {
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'L3MON4D3/LuaSnip' },
        -- Other:
        'hrsh7th/cmp-path',
      },
      config = function()
        local cmp = require('cmp')
        local cmp_ap = require('nvim-autopairs.completion.cmp')
        local luasnip = require('luasnip')
        luasnip.config.setup {}
        cmp.setup({
          snippet = {
            expand = function(args)
              require('luasnip').lsp_expand(args.body)
            end,
          },
          window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered()
          },
          mapping = cmp.mapping.preset.insert({
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<CR>'] = cmp.mapping.confirm({ select = true }),
          }),
          sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'luasnip' },
            { name = 'path' },
          }),
        })
        -- bracket completion for lua
        cmp.event:on(
          'confirm_done',
          cmp_ap.on_confirm_done()
        )
      end
    },
  },
  {
    ui = {
      border = "rounded"
    }
  },
  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      -- calling `setup` is optional for customization
      require("fzf-lua").setup({})
    end
  })
--
--0=========================================================================0
-- █▀█ █░░ █░█ █▀▀ █ █▄░█ █▀   █▀▀ █▄░█ █▀▄   █░█ █▀▀ █▀█ █▀▀
-- █▀▀ █▄▄ █▄█ █▄█ █ █░▀█ ▄█   ██▄ █░▀█ █▄▀   █▀█ ██▄ █▀▄ ██▄
--0=========================================================================0
--0=========================================================================0
-- ▄▀█ █░█ ▀█▀ █▀█ █▀▀ █▀▄▀█ █▀▄
-- █▀█ █▄█ ░█░ █▄█ █▄▄ █░▀░█ █▄▀
--0=========================================================================0
-- Highlight yanked text for 150ms
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end
})
