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
    'mg979/vim-visual-multi',
    event = "VeryLazy",
  },
  {
    "epwalsh/obsidian.nvim",
    version = "*",  -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- event = {
    --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
    --   -- refer to `:h file-pattern` for more examples
    --   "BufReadPre path/to/my-vault/*.md",
    --   "BufNewFile path/to/my-vault/*.md",
    -- },
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",

      -- see below for full list of optional dependencies 👇
    },
    opts = {
      disable_frontmatter = true,
      workspaces = {
        {
          name = "notes",
          path = "~/notes",
        },
      },
      daily_notes = {
        -- Optional, if you keep daily notes in a separate directory.
        folder = "diary",
        -- Optional, if you want to change the date format for the ID of daily notes.
        date_format = "%Y-%m-%d",
        -- Optional, if you want to change the date format of the default alias of daily notes.
        alias_format = "%B %-d, %Y",
        -- Optional, default tags to add to each new daily note created.
        default_tags = { "daily-notes" },
        -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
        template = "templates/diary.md"
      },
      templates = {
        folder = "templates",
        date_format = "%Y-%m-%d-%a",
        time_format = "%H:%M",
        substitutions = {
          yesterday = function()
            return os.date("%Y-%m-%d", os.time() - 86400)
          end,
          tomorrow = function()
            return os.date("%Y-%m-%d", os.time() + 86400)
          end
        }
      },
      ---@param url string
      follow_url_func = function(url)
        -- Open the URL in the default web browser.
        vim.fn.jobstart({"open", url})  -- Mac OS
        -- vim.fn.jobstart({"xdg-open", url})  -- linux
        -- vim.cmd(':silent exec "!start ' .. url .. '"') -- Windows
        -- vim.ui.open(url) -- need Neovim 0.10.0+
      end,
      ---@param img string
      follow_img_func = function(img)
        vim.fn.jobstart { "qlmanage", "-p", img }  -- Mac OS quick look preview
        -- vim.fn.jobstart({"xdg-open", url})  -- linux
        -- vim.cmd(':silent exec "!start ' .. url .. '"') -- Windows
      end,
    },
  },
  -- {
  --   'MeanderingProgrammer/render-markdown.nvim',
  --   -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
  --   -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
  --   dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
  --   ---@module 'render-markdown'
  --   ---@type render.md.UserConfig
  --   opts = {},
  -- },
  -- {
  --   "OXY2DEV/markview.nvim",
  --   lazy = false,      -- Recommended
  --   ft = "markdown", -- If you decide to lazy-load anyway
  --   dependencies = {
  --       "nvim-treesitter/nvim-treesitter",
  --       "nvim-tree/nvim-web-devicons"
  --   }
  -- },
  {
    "wellle/context.vim",
    cmd = {
      "ContextActivate",
      "ContextEnable",
      "ContextDisable",
      "ContextToggle",
    },
    event = "VeryLazy",
    config = function ()
      -- vim.fn["context#enable"](1) -- 0 = window, 1 = global
    end
  },
  {
    'linux-cultist/venv-selector.nvim',
    branch='regexp',
    dependencies = { 'neovim/nvim-lspconfig', 'nvim-telescope/telescope.nvim', 'mfussenegger/nvim-dap-python' },
    cmd = {
      'VenvSelect',
    },
    opts = {
      -- Your options go here
      -- name = "venv",
      -- auto_refresh = false
    },
    keys = {
      -- Keymap to open VenvSelector to pick a venv.
      { '<leader>vs', '<cmd>VenvSelect<cr>' },
      -- Keymap to retrieve the venv from a cache (the one previously used for the same project directory).
      { '<leader>vc', '<cmd>VenvSelectCached<cr>' },
    },
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
      require("neogit").setup({})
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
        '<C-h>',
        function()
          require('agitator').git_time_machine({
            use_current_win=true,
            set_custom_shortcuts = function(code_bufnr)
              vim.keymap.set('n', '<C-h>', function()
                require"agitator".git_time_machine_previous()
              end, {buffer = code_bufnr})
              vim.keymap.set('n', '<C-l>', function()
                require"agitator".git_time_machine_next()
              end, {buffer = code_bufnr})
              vim.keymap.set('n', '<c-y>', function()
                require"agitator".git_time_machine_copy_sha()
              end, {buffer = code_bufnr})
              vim.keymap.set('n', 'q', function()
                require"agitator".git_time_machine_quit()
              end, {buffer = code_bufnr})
            end,
            popup_last_line = "<C-h> Back | <C-l> Forward | <C-y> Yank SHA | [q]uit"
          })
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
  -- {
  --   'tzachar/highlight-undo.nvim',
  --   keys = {
  --     "<C-r>",
  --     "u",
  --   },
  --   config = function ()
  --     require('highlight-undo').setup {
  --       duration = 300,
  --       undo = {
  --         hlgroup = 'HighlightUndo',
  --         mode = 'n',
  --         lhs = 'u',
  --         map = 'undo',
  --         opts = {}
  --       },
  --       redo = {
  --         hlgroup = 'HighlightRedo',
  --         mode = 'n',
  --         lhs = '<C-r>',
  --         map = 'redo',
  --         opts = {}
  --       },
  --       highlight_for_count = true,
  --     }
  --   end
  -- },

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
    cmd = { "Genghis" },
    keys = {
      {
        '¡',
        function()
          require('genghis').createNewFile()
        end,
        desc = "Genghis create new file",
      },
      {
        '<A-1>',
        function()
          require('genghis').createNewFile()
        end,
        desc = "Genghis create new file",
      },
      {
        '™',
        function()
          require('genghis').renameFile()
        end,
        desc = "Genghis rename file",
      },
      {
        '<A-2>',
        function()
          require('genghis').renameFile()
        end,
        desc = "Genghis rename file",
      },
      {
        '£',
        function()
          require('genghis').duplicateFile()
        end,
        desc = "Genghis duplicate file",
      },
      {
        '<A-3>',
        function()
          require('genghis').duplicateFile()
        end,
        desc = "Genghis duplicate file",
      },
      {
        '¢',
        function()
          require('genghis').moveAndRenameFile()
        end,
        desc = "Genghis move and rename file",
      },
      {
        '<A-4>',
        function()
          require('genghis').moveAndRenameFile()
        end,
        desc = "Genghis move and rename file",
      },
      {
        '∞',
        function()
          require('genghis').copyRelativePath()
        end,
        desc = "Genghis copy relative path",
      },
      {
        '<A-5>',
        function()
          require('genghis').copyRelativePath()
        end,
        desc = "Genghis copy relative path",
      },
      {
        '§',
        function()
          require('genghis').moveSelectionToNewFile()
        end,
        desc = "Genghis move selection to new file",
      },
      {
        '<A-6>',
        function()
          require('genghis').moveSelectionToNewFile()
        end,
        desc = "Genghis move selection to new file",
      },
      {
        '¶',
        function()
          require('genghis').chmodx()
        end,
        desc = "Genghis change mode executable chmodx",
      },
      {
        '<A-7>',
        function()
          require('genghis').chmodx()
        end,
        desc = "Genghis change mode executable chmodx",
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
      require("genghis").setup()
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
  -- { "ap/vim-css-color", ft = { "css", "javascript", "typescript", "html", "markdown" } }, -- Show Colors in CSS
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
