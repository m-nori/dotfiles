-- Neovim Modern Setup (init.lua) - 2025 推奨構成

-----------------------------------------
-- 基本設定
-----------------------------------------
vim.o.number = true
vim.o.relativenumber = false
vim.o.clipboard = "unnamedplus"
vim.o.termguicolors = true
vim.o.mouse = "a"
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.g.mapleader = ","
vim.g.maplocalleader = ","
vim.o.shell = "/opt/homebrew/bin/fish"
vim.g.accelerated_jk_mode = "time_driven"
vim.g.accelerated_jk_acceleration_table = { 5, 10, 15, 20, 25, 30 }
vim.g.accelerated_jk_acceleration_limit = 30

-----------------------------------------
-- プラグイン管理: lazy.nvim
-----------------------------------------
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
  -----------------------------------------
  -- UI系
  -----------------------------------------
  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
   config = function()
     require('dashboard').setup {
       -- config
     }
   end,
  dependencies = { {'nvim-tree/nvim-web-devicons'}}
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd[[colorscheme tokyonight]]
    end
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {"nvim-tree/nvim-web-devicons"},
    config = true,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {}
  },
  -- GitSigns
  {
    "lewis6991/gitsigns.nvim",
    lazy = false,
    config = function()
      require("gitsigns").setup({
        signs = {
          add          = { text = "│" },
          change       = { text = "│" },
          delete       = { text = "_" },
          topdelete    = { text = "‾" },
          changedelete = { text = "~" },
          untracked    = { text = "┆" },
        },
        current_line_blame = true,
      })
    end
  },
  -- Scrollbar (連携: gitsigns, diagnostics, search)
  {
    "kevinhwang91/nvim-hlslens",
    event = "VeryLazy",
  },
  {
    "petertriho/nvim-scrollbar",
    lazy = false,
    config = function()
      require("scrollbar").setup({
        show = true,
        set_highlights = true,
        handle = {
          text = " ",
          highlight = "Cursor",
        },
        marks = {
          Cursor = { text = "■" },
          Search = { text = { "" } },
          Error = { text = { "" } },
          Warn = { text = { "" } },
          Info = { text = { "" } },
          Hint = { text = { "" } },
          Misc = { text = { "" } },
        },
        excluded_filetypes = {
          "prompt",
          "TelescopePrompt",
          "noice",
        },
        handlers = {
          diagnostic = true,
          gitsigns = true,
          search = true,
        },
      })
    end
  },
  {
    "Bekaboo/dropbar.nvim",
    lazy = false,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("dropbar").setup({
        icons = {
          enable = true,
        },
        menu = {
          win_configs = {
            border = "rounded",
          },
        },
      })
      vim.keymap.set('n', '<leader>db', function()
        require("dropbar.api").pick()
      end, { desc = "Open Dropbar" })
    end,
  },
  -----------------------------------------
  -- Markdown系
  -----------------------------------------
  {
    "OXY2DEV/markview.nvim",
    lazy = false,
    ft = "markdown",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    },
    config = function()
      require("markview").setup({
        experimental = {
          check_rtp_message = false,
        },
        preview = {
          modes = { "n", "no", "c" },
          hybrid_modes = {},
          callbacks = {
            on_enable = function(_, win)
              vim.wo[win].conceallevel = 2
              vim.wo[win].concealcursor = "c"
            end
          },
        },
        markdown = {
          headings = {
            enable = true,
            shift_width = 1,
            heading_1 = { style = "label" },
            heading_2 = { style = "label" },
            heading_3 = { style = "label" },
          },
          list_items = {
            enable = true,
            marker_minus = { text = "●" },
            marker_plus = { text = "●" },
            marker_star = { text = "●" },
          },
        },
        code_blocks = {
          enable = true,
          style = "language",
        },
        checkboxes = {
          enable = true,
          checked = { text = "✓" },
          unchecked = { text = "✗" },
        },
      })
      vim.keymap.set('n', '<leader>mv', ':Markview toggle<CR>', { desc = 'Toggle Markview' })
    end
  },
  {
    "toppair/peek.nvim",
    event = { "VeryLazy" },
    build = "deno task --quiet build:fast",
    config = function()
      require("peek").setup({
        auto_load = false,         -- ファイルオープン時に自動でプレビュー開始
        close_on_bdelete = true,  -- バッファ削除時にプレビューも閉じる
        syntax = true,             -- シンタックスハイライト有効
        theme = 'dark',            -- ダークテーマ
        update_on_change = true,
        app = 'browser',          -- ブラウザでプレビュー
        filetype = { 'markdown' },
        throttle_at = 200000,     -- ファイルサイズ制限
        throttle_time = 'auto',
      })
      -- キーマップ
      vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
      vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
      vim.keymap.set('n', '<leader>mp', function()
        local peek = require('peek')
        if peek.is_open() then
          peek.close()
        else
          peek.open()
        end
      end, { desc = 'Toggle Markdown Preview' })
    end
  },
  -----------------------------------------
  -- ファイラー / ファイル操作
  -----------------------------------------
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = {"nvim-lua/plenary.nvim"},
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = {"nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim"},
    config = function()
      -- telescope-file-browserの設定
      require("telescope").setup {
        extensions = {
          file_browser = {
            -- path = "%:p:h" を設定すると現在のバッファのディレクトリから開く
            path = "%:p:h",
            cwd_to_path = true,
          },
        },
      }
      require("telescope").load_extension("file_browser")
      vim.keymap.set("n", "<leader>fb", ":Telescope file_browser<CR>", { noremap = true })
    end
  },
  -----------------------------------------
  -- LSP / 補完
  -----------------------------------------
  "neovim/nvim-lspconfig",
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip"
    }
  },
  -----------------------------------------
  -- Git
  -----------------------------------------
  {
    "lewis6991/gitsigns.nvim",
    config = true
  },
  {
    "tpope/vim-fugitive",
    config = function()
      vim.keymap.set("n", "<leader>gd", ":Gdiffsplit<CR>", { desc = "Git Diff Split" })
    end,
  },
  {
    "sindrets/diffview.nvim",
    config = function()
     require("diffview").setup()
    end
  },
  {
  "NeogitOrg/neogit",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
    require("neogit").setup({
      integrations = {
        diffview = true
      }
    })
    vim.keymap.set("n", "<leader>gn", ":Neogit<CR>", { desc = "Open Neogit" })
    end,
  },
  -----------------------------------------
  -- Treesitter
  -----------------------------------------
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup {
        highlight = { enable = true },
        indent = { enable = true },
        ensure_installed = { "lua", "rust", "sql", "json", "vim", "bash" },
      }
    end
  },
  -----------------------------------------
  -- nvim内ターミナル
  -----------------------------------------
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = function(term)
          if term.direction == "horizontal" then
            return 50
          elseif term.direction == "vertical" then
            return vim.o.columns * 0.6  -- 画面の60%の幅
          end
        end,
        open_mapping = [[<C-]>]],
        direction = "horizontal", -- "vertical" or "float" も選べる
        shade_terminals = true,
        start_in_insert = true,
      })
    end
  },
  -----------------------------------------
  -- その他便利系
  -----------------------------------------
  "numToStr/Comment.nvim",
  -- コマンドの説明
  "folke/which-key.nvim",
  -- カーソル移動高速化
  {
    "rainbowhxch/accelerated-jk.nvim",
    config = function()
      vim.api.nvim_set_keymap("n", "j", "<Plug>(accelerated_jk_gj)", {})
      vim.api.nvim_set_keymap("n", "k", "<Plug>(accelerated_jk_gk)", {})
    end,
  },
})

-----------------------------------------
-- キーマッピング
-----------------------------------------
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Insert mode: Emacs-like movement
map("i", "<C-a>", "<C-o>^", opts)     -- 行頭（非空白）
map("i", "<C-e>", "<C-o>$", opts)     -- 行末
map("i", "<C-n>", "<Down>", opts)     -- 下
map("i", "<C-p>", "<Up>", opts)       -- 上
map("i", "<C-b>", "<Left>", opts)     -- 左
map("i", "<C-f>", "<Right>", opts)    -- 右
map("i", "<C-h>", "<BS>", opts)       -- バックスペース
map("i", "<C-d>", "<Del>", opts)      -- Delete

-- Insert mode: jj to escape
map("i", "jj", "<Esc>", opts)

-- Normal mode: remap q to escape
map("n", "q", "<Esc>", opts)

-- Leader+q で現在のバッファをクローズ
map("n", "<leader>q", "<cmd>q!<CR>", opts)
map("n", "<leader>w", "<cmd>w<CR>", opts)

-- Telescope キーバインドグループ
map("n", "ff", "<cmd>Telescope buffers<CR>", { desc = "Find Buffers", unpack(opts) })
-- map("n", "fb", "<cmd>Telescope file_browser<CR>", { desc = "File Browser", unpack(opts) })
map("n", "fb", function()
  require("telescope").extensions.file_browser.file_browser({
    hidden = true,
    respect_gitignore = false, -- 必要なら
  })
end, { desc = "File Browser", unpack(opts) })
map("n", "fs", function()
  require("telescope.builtin").find_files({
    hidden = true,
    no_ignore = true,
    follow = true,
  })
end, { desc = "Find all files (incl. hidden/gitignored)", unpack(opts) })
map("n", "fg", "<cmd>Telescope live_grep<CR>", { desc = "Live Grep", unpack(opts) })
map("n", "fd", "<cmd>Telescope git_status<CR>", { desc = "Git Status", unpack(opts) })

-- Git関連
require('gitsigns').setup {
  signs = {
    add          = {hl = 'GitGutterAdd', text = '┃', numhl='GitSignsAddNr'},
    change       = {hl = 'GitGutterChange', text = '┃', numhl='GitSignsChangeNr'},
    delete       = {hl = 'GitGutterDelete', text = '_', numhl='GitSignsDeleteNr'},
    topdelete    = {hl = 'GitGutterDelete', text = '‾', numhl='GitSignsDeleteNr'},
    changedelete = {hl = 'GitGutterChange', text = '~', numhl='GitSignsChangeNr'},
  },
  signcolumn = true,
  numhl      = true,
  linehl     = true,

  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(gs.next_hunk)
      return '<Ignore>'
    end, {expr=true})

    map('n', '[c', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(gs.prev_hunk)
      return '<Ignore>'
    end, {expr=true})

    -- Text object
    map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end
}

-- terminalモードからノーマルモードへ切り替え
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { noremap = true })

-----------------------------------------
-- カラー設定
-----------------------------------------
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.sqlx",
  callback = function()
    vim.bo.filetype = "sql"
  end,
})


