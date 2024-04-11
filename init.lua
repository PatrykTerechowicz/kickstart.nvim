vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Linting icons
ICON_ERROR = 'E'
ICON_WARN = 'W'
ICON_INFO = 'I'
ICON_HINT = 'H'

-- Language servers
SERVERS = { 'basedpyright', 'lua_ls', 'html', 'cssls', 'clangd' }

require 'options'

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`
require 'keymaps'

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
require 'lazy-install'

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
require 'lazy-plugins'
