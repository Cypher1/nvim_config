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
  {
    "ahmedkhalf/project.nvim",
    event = "VeryLazy",
    config = function ()
      require("project_nvim").setup()
    end
  },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.6",
    dependencies = {
      { "nvim-lua/plenary.nvim" }
    },
    cmd = {
      "Telescope"
    },
    keys = {
      {
        '<C-p>',
        function()
          require('telescope.builtin').live_grep()
        end,
      },
      {
        '<leader>ff',
        function()
          require('telescope.builtin').find_files()
        end,
      },
      {
        '<leader>fg',
        function()
          require('telescope.builtin').git_files()
        end,
      },
      {
        '<leader>fb',
        function()
          require('telescope.builtin').buffers()
        end,
      },
      {
        '<leader>fh',
        function()
          require('telescope.builtin').help_tags()
        end,
      },
    }
  },

  -- Colorschemes
  -- "ratazzi/blackboard.vim",
  -- "marko-cerovac/material.nvim",

  {
    "rose-pine/neovim", name = "rose-pine"
  },

  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required
      "sindrets/diffview.nvim",        -- optional - Diff integration
      -- Only one of these is needed, not both.
      "nvim-telescope/telescope.nvim", -- optional
      -- "ibhagwan/fzf-lua",              -- optional
    },
    keys = {
      {"<C-g>", "<cmd>Neogit<CR>", desc="Run an interactive git session"},
    },
    cmd = {
      "Neogit",
    },
    config = function ()
      require("neogit").setup()
    end
  },
  {
    "emmanueltouzery/agitator.nvim",
    dependencies = {
      "sindrets/diffview.nvim",        -- optional - Diff integration
    },
    cmd = {},
    keys = {
      {
        '<leader>/',
        function()
          require('agitator').git_blame_toggle()
        end,
      },
      {
        '<c-h>',
        function()
          require('agitator').git_time_machine({use_current_win=true})
        end,
      },
      {
        '<leader>?',
        function()
          local commit_sha = require('agitator').git_blame_commit_for_line()
          if commit_sha == nil then
            vim.notify("Not in git directory")
          elseif commit_sha == "00000000" then
            vim.notify("Not commited")
          else
            vim.cmd("DiffviewOpen " .. commit_sha .. "^.." .. commit_sha)
          end
        end,
      },
    }
  },
  {
    'tzachar/highlight-undo.nvim',
    keys = {
      "<C-r>",
      "u",
    },
    config = function ()
      require('highlight-undo').setup {
        duration = 300,
        undo = {
          hlgroup = 'HighlightUndo',
          mode = 'n',
          lhs = 'u',
          map = 'undo',
          opts = {}
        },
        redo = {
          hlgroup = 'HighlightRedo',
          mode = 'n',
          lhs = '<C-r>',
          map = 'redo',
          opts = {}
        },
        highlight_for_count = true,
      }
    end
  },

  {
    "nvim-treesitter/nvim-treesitter",
    version = false,
    event = {
      "VeryLazy"
    },
    build = ":TSUpdate",
    config = function()
      require('nvim-treesitter.configs').setup {
        -- A list of parser names, or "all" (the five listed parsers should always be installed)
        ensure_installed = {
          "c",
          "cpp",
          -- "help",
          "javascript",
          "lua",
          "query",
          "rust",
          "sql",
          "typescript",
          "vim",
          "vimdoc",
        },

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,

        -- Automatically install missing parsers when entering buffer
        -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
        auto_install = true,

        highlight = {
          enable = true,

          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = false,
        },
      }
    end
  },
  {
    "tpope/vim-speeddating",
    keys = {
      "<C-a>",
      "<C-x>",
    }
  },
  {
    "mbbill/undotree",
    cmd = {
      "UndotreeFocus",
      "UndotreeHide",
      "UndotreePersistUndo",
      "UndotreeShow",
      "UndotreeToggle",
    },
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
    "junegunn/fzf",
    dir = "~/.fzf",
    build = "./install --all"
  },
  {
    "junegunn/fzf.vim",
    cmd = {
      "Buffers",
      "GFiles",
      "GGrep",
    },
    keys = {
      {"<C-o>", "<cmd>GFiles<CR>", desc="Search git files"},
      {"<C-f>", "<cmd>GGrep<CR>", desc="Search git lines"},
      {"<C-b>", "<cmd>Buffers<CR>", desc="Search open guffers"},
    },
    config = function ()
      -- Command for git grep
      -- - fzf#vim#grep(command, with_column, [options], [fullscreen])
      vim.cmd([[command! -bang -nargs=* GGrep
      \ call fzf#vim#grep(
      \   'git grep --line-number '.shellescape(<q-args>), 0,
      \   { 'dir': systemlist('git rev-parse --show-toplevel')[0] }, <bang>0)
      ]])

      -- Likewise, GFiles command with preview window
      vim.cmd([[command! -bang -nargs=? -complete=dir GFiles
      \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
      ]])
    end
  },

  -- Tweaks & Fixes
  "ConradIrwin/vim-bracketed-paste", -- Paste properly
  "tpope/vim-repeat", -- Repetitions
  { "roxma/vim-window-resize-easy", keys = { "<c-w>" }, }, -- Resize windows
  {
    "chrisgrieser/nvim-genghis",
    cmd = {
      "Chmodx",
      "CopyDirectoryPath",
      "CopyFilename",
      "CopyFilepath",
      "CopyFilepathWithTilde",
      "CopyRelativeDirectoryPath",
      "CopyRelativePath",
      "Duplicate",
      "Move",
      "MoveSelectionToNew",
      "MoveToFolderInCwd",
      "New",
      "Rename",
      "Trash",
    },
    keys = {
      {
        '¡',
        function()
          require('genghis').createNewFile()
        end,
      },
      {
        '<A-1>',
        function()
          require('genghis').createNewFile()
        end,
      },
      {
        '™',
        function()
          require('genghis').renameFile()
        end,
      },
      {
        '<A-2>',
        function()
          require('genghis').renameFile()
        end,
      },
      {
        '£',
        function()
          require('genghis').duplicateFile()
        end,
      },
      {
        '<A-3>',
        function()
          require('genghis').duplicateFile()
        end,
      },
      {
        '¢',
        function()
          require('genghis').moveAndRenameFile()
        end,
      },
      {
        '<A-4>',
        function()
          require('genghis').moveAndRenameFile()
        end,
      },
      {
        '∞',
        function()
          require('genghis').copyRelativePath()
        end,
      },
      {
        '<A-5>',
        function()
          require('genghis').copyRelativePath()
        end,
      },
      {
        '§',
        function()
          require('genghis').moveSelectionToNewFile()
        end,
      },
      {
        '<A-6>',
        function()
          require('genghis').moveSelectionToNewFile()
        end,
      },
      {
        '¶',
        function()
          require('genghis').chmodx()
        end,
      },
      {
        '<A-7>',
        function()
          require('genghis').chmodx()
        end,
      },
    },
    dependencies = {
      "stevearc/dressing.nvim",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-omni",
      "nvim-telescope/telescope.nvim",
    },
    config = function ()
      local cmp = require("cmp")
      cmp.setup.filetype("DressingInput", {
        sources = cmp.config.sources { { name = "omni" } },
      })
      require("dressing").setup {
        select = {
          backend = { "telescope" },
        },
      }
    end,
  }, -- Unix built in
  -- Tools
  {
    "AndrewRadev/switch.vim",
    keys = {
      { "<leader>1", "<cmd>Switch<CR>", desc="Switch common literals or expressions" },
      { "<leader>!", "<cmd>SwitchReverse<CR>", desc="Switch common literals or expressions back" },
    }
  }, -- Switch t->f
  {
    "nvim-tree/nvim-tree.lua",
    cmds = {
      "NvimTreeToggle",
      "NvimTreeFocus",
      "NvimTreeFindFile",
      "NvimTreeCollapse",
    },
    keys = {
      { "<leader>t", "<cmd>NvimTreeToggle<CR>", desc="Toggle the file tree" },
      { "<leader>ft", "<cmd>NvimTreeFindFile<CR>", desc="Find the current file in the file tree" },
      { "<leader>ct", "<cmd>NvimTreeCollapse<CR>", desc="Collapse the file tree" },
    },
    config = function ()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      require("nvim-tree").setup({
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        update_focused_file = {
          enable = true,
          update_root = true
        },
      })
    end,
  }, -- File manager
  "mhinz/vim-signify", -- Sign column diffs
  { "ap/vim-css-color", ft = { "css", "javascript", "typescript", "html", "markdown" } }, -- Show Colors in CSS
  "google/vim-searchindex", -- Count search solutions

  -- Format / Language Specifics
  { "chrisbra/csv.vim", ft = "csv" }, -- CSV
  { "sbdchd/neoformat", cmd = { "Neoformat" } }, -- Autoformat (includes clang-format,

  {
    "dmmulroy/tsc.nvim",
    cmd = {
      "TSC",
    },
    config = function ()
      require('tsc').setup()
    end,
  },
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
    ft = {
      "typescript",
      "javascript",
    },
    config = function()
      require("typescript-tools").setup({})
    end,
  },
  -- add LazyVim and import its plugins
  {
    "LazyVim/LazyVim",
    keys = {
      { "<C-l>", "<cmd>Lazy<CR>", desc="Open the package manager" }
    }
  },
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
  checker = { enabled = false }, -- automatically check for plugin updates
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
