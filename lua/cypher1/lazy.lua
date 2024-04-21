local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath
  })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

local plugins = {
  "wbthomason/packer.nvim",

  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.6",
    -- or                            , branch = '0.1.x',
    dependencies = { {
      "nvim-lua/plenary.nvim" } },
  },

  -- Colorschemes
  "ratazzi/blackboard.vim",
  "marko-cerovac/material.nvim",

  {
    "rose-pine/neovim", name = "rose-pine"
  },

  {
    "nvim-treesitter/nvim-treesitter",
    version = false,
    event = {
      "VeryLazy"
    },
    build = ":TSUpdate",
  },

  {
    "theprimeagen/harpoon",
    keys = {
      {
        "<leader>a",
        function()
          require("harpoon.mark").add_file()
        end,
        desc="Add to harpoon"
      },
      {
        "<C-h>",
        function()
          require("harpoon.ui").toggle_quick_menu()
        end,
        desc="Toggle harpoon quick menu"
      },
      {
        "<leader>h1",
        function()
          require("harpoon.ui").nav_file(1)
        end,
        desc="Go to file 1"
      },
      {
        "<leader>h2",
        function()
          require("harpoon.ui").nav_file(2)
        end,
        desc="Go to file 2"
      },
      {
        "<leader>h3",
        function()
          require("harpoon.ui").nav_file(3)
        end,
        desc="Go to file 3"
      },
      {
        "<leader>h4",
        function()
          require("harpoon.ui").nav_file(4)
        end,
        desc="Go to file 4"
      },
    },
    event = {
      "VeryLazy"
    },
  },
  {
    "mbbill/undotree",
    event = "VeryLazy",
    keys = {
      {
        '<leader>u',
        function()
          vim.cmd.UndotreeToggle()
        end
      }
    },
  },
  {
    "tpope/vim-fugitive",
    keys = {
      {"<C-G>", "<ESC>:Gblame<CR>", desc="Open git blame"},
    }
  },

  {
    "junegunn/fzf",
    dir = "~/.fzf",
    build = "./install --all"
  },
  {
    "junegunn/fzf.vim",
    keys = {
      {"<C-O>", "<ESC>:GFiles<CR>", desc="Search git files"},
      {"<C-F>", "<ESC>:GGrep<CR>", desc="Search git lines"},
      {"<C-B>", "<ESC>:Buffers<CR>", desc="Search open guffers"},
    },
    config = function ()
        -- Command for git grep
        -- - fzf#vim#grep(command, with_column, [options], [fullscreen])
        vim.cmd([[command! -bang -nargs=* GGrep
          \ call fzf#vim#grep(
          \   'git grep --line-number '.shellescape(<q-args>), 0,
          \   { 'dir': systemlist('git rev-parse --show-toplevel')[0] }, <bang>0)
        ]])

        -- Likewise, Files command with preview window
        vim.cmd([[command! -bang -nargs=? -complete=dir Files
          \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
          ]])
    end
  },

  -- Tweaks & Fixes
  "ConradIrwin/vim-bracketed-paste", -- Paste properly
  "tpope/vim-repeat", -- Repetitions
  "roxma/vim-window-resize-easy", -- Resize windows
  "tmhedberg/matchit", -- % Match based jumping
  {
    "chrisgrieser/nvim-genghis",
    event = {
      "VeryLazy"
    },
    dependencies = {
      "stevearc/dressing.nvim",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-omni",
    },
  }, -- Unix built in
  -- Tools
  "AndrewRadev/switch.vim", -- Switch t->f
  "nvim-tree/nvim-tree.lua", -- File manager
  "mhinz/vim-signify", -- Sign column diffs
  "ap/vim-css-color", -- Show Colors in CSS
  "google/vim-searchindex", -- Count search solutions

  -- Format / Language Specifics
  "chrisbra/csv.vim", -- CSV
  "sbdchd/neoformat", -- Autoformat (includes clang-format,

  -- LSP stuff
  "neovim/nvim-lspconfig",
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "saadparwaiz1/cmp_luasnip",
  "L3MON4D3/LuaSnip",
  "rafamadriz/friendly-snippets",

  {
    "pmizio/typescript-tools.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("typescript-tools").setup({})
    end,
  },
  -- add LazyVim and import its plugins
  "LazyVim/LazyVim",
}

local opts = {
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = {
    colorscheme = { "rose-pine" },
  },
  checker = { enabled = true }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        -- "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        -- "tarPlugin",
        "tohtml",
        "tutor",
        -- "zipPlugin",
      },
    },
  },
}

require("lazy").setup(plugins, opts)
