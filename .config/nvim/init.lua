--------------------------------------------------------------------------------
---- Plugins

require("packer").startup(function()
  use("wbthomason/packer.nvim")
  -- Colorscheme
  use("lifepillar/vim-solarized8")
  -- General
  use("jeffkreeftmeijer/vim-numbertoggle")  -- smartly set relativenumber
  use("jiangmiao/auto-pairs")               -- auto brackets, parens, quotes
  use("jreybert/vimagit")                   -- git workflow integration
  use("kyazdani42/nvim-web-devicons")       -- devicon support
  use("mbbill/undotree")                    -- undo history visualizer
  use("lewis6991/gitsigns.nvim")            -- git integration
  use("ntpeters/vim-better-whitespace")     -- remove trailing whitespace
  use("nvim-lua/plenary.nvim")              -- async functions for plugins
  use("nvim-lualine/lualine.nvim")          -- improved status line
  use("tpope/vim-commentary")               -- code comment operators
  use("tpope/vim-surround")                 -- text objects for pairs
  -- Treesitter
  use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
  use("nvim-treesitter/nvim-treesitter-textobjects")
  use("JoosepAlviste/nvim-ts-context-commentstring")
  -- LSP
  use("neovim/nvim-lspconfig")
  use("williamboman/mason.nvim")
  use("williamboman/mason-lspconfig.nvim")
  use("jose-elias-alvarez/null-ls.nvim")
  use("jayp0521/mason-null-ls.nvim")
  -- Completion
  use("hrsh7th/nvim-cmp")
  use("onsails/lspkind-nvim")
  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-path")
  -- Snippet
  use("L3MON4D3/LuaSnip")
  use("saadparwaiz1/cmp_luasnip")
  use("rafamadriz/friendly-snippets")
  -- Telescope
  use("nvim-telescope/telescope.nvim")
  use({"nvim-telescope/telescope-fzf-native.nvim", run = "make" })
  -- Language-specific
  use({
    "iamcco/markdown-preview.nvim",
    run = function()
      vim.fn["mkdp#util#install"]()
    end,
  })
end)

vim.g.python3_host_prog = "/usr/local/bin/python3"
vim.g.peekaboo_delay = 1000
vim.g.better_whitespace_ctermcolor = "grey"
vim.g.better_whitespace_guicolor = "grey"
vim.g.strip_whitespace_confirm = 0
vim.g.strip_whitespace_on_save = 1

--- Gitsigns

require("gitsigns").setup({
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map("n", "]c", function()
      if vim.wo.diff then
        return "]c"
      end
      vim.schedule(function()
        gs.next_hunk()
      end)
      return "<Ignore>"
    end, { expr = true })
    map("n", "[c", function()
      if vim.wo.diff then
        return "[c"
      end
      vim.schedule(function()
        gs.prev_hunk()
      end)
      return "<Ignore>"
    end, { expr = true })
    -- Actions
    map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>")
    map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>")
    map("n", "<leader>hS", gs.stage_buffer)
    map("n", "<leader>hu", gs.undo_stage_hunk)
    map("n", "<leader>hR", gs.reset_buffer)
    map("n", "<leader>hp", gs.preview_hunk)
    map("n", "<leader>hb", function()
      gs.blame_line({ full = true })
    end)
    map("n", "<leader>tb", gs.toggle_current_line_blame)
    map("n", "<leader>hd", gs.diffthis)
    map("n", "<leader>hD", function()
      gs.diffthis("~")
    end)
    map("n", "<leader>td", gs.toggle_deleted)
    -- Text object
    map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
  end,
})

--- Lualine

require("lualine").setup({
  options = { theme = "solarized" },
  sections = { lualine_x = { "filetype" } },
  tabline = { lualine_b = { "buffers" }, lualine_y = { "tabs" } },
})

--- Treesitter

require("nvim-treesitter.configs").setup({
  auto_install = true,
  context_commentstring = { enable = true },
  ensure_installed = {
    "help",
    "diff",
    "lua",
    "markdown",
    "python",
    "cpp",
    "javascript",
    "typescript",
  },
  highlight = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  indent = { enable = true },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
      },
    },
  },
})

--- LSP

-- show diagnostic source
vim.diagnostic.config({ virtual_text = { source = true } })

vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

local on_attach = function(_, bufnr)
  local opts = { buffer = bufnr }
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
  vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
  vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
  vim.keymap.set("n", "<space>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts)
  vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
  vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "<space>f", function()
    vim.lsp.buf.format({ async = true })
  end, opts)
end

require("mason").setup()

require("mason-lspconfig").setup({
  ensure_installed = {
    "sumneko_lua",
    "marksman",
    "pyright",
    "clangd",
    "tsserver",
    "tailwindcss",
  },
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("mason-lspconfig").setup_handlers({
  function(server_name)
    require("lspconfig")[server_name].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })
  end,

  -- override targetted servers
  ["sumneko_lua"] = function()
    require("lspconfig")["sumneko_lua"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = { Lua = { diagnostics = { globals = { "use", "vim" } } } },
    })
  end,
})

local code_actions = require("null-ls").builtins.code_actions
local diagnostics = require("null-ls").builtins.diagnostics
local formatting = require("null-ls").builtins.formatting

require("null-ls").setup({
  sources = {
    code_actions.gitsigns,
    formatting.stylua.with({ extra_args = { "--indent-type", "Spaces", "--indent-width", "2" } }),
    diagnostics.markdownlint,
    diagnostics.pylint,
    diagnostics.mypy,
    formatting.isort,
    formatting.black,
    diagnostics.cppcheck,
    diagnostics.eslint_d,
    formatting.prettierd,
    formatting.rustywind,
  },
})

require("mason-null-ls").setup({ automatic_installation = true })

--- Completion

local cmp = require("cmp")
local luasnip = require("luasnip")

require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
  -- disable completion in comments
  enabled = function()
    local context = require("cmp.config.context")
    -- keep command mode completion enabled when cursor is in a comment
    if vim.api.nvim_get_mode().mode == "c" then
      return true
    else
      return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
    end
  end,
  experimental = { ghost_text = true },
  formatting = {
    fields = { "abbr", "kind", "menu" },
    format = require("lspkind").cmp_format({
      with_text = false,
      before = function(entry, vim_item)
        vim_item.menu = ({
          nvim_lsp = "[LSP]",
          luasnip = "[Snippet]",
          buffer = "[Buffer]",
          path = "[Path]",
        })[entry.source.name]
        return vim_item
      end,
    }),
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm(),
    ["<Tab>"] = function(fallback)
      if luasnip.jumpable(1) then
        luasnip.jump(1)
      else
        fallback()
      end
    end,
    ["<S-Tab>"] = function(fallback)
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end,
  }),
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  sources = cmp.config.sources(
    { { name = "nvim_lsp" }, { name = "luasnip" } },
    { { name = "buffer" } },
    { { name = "path" } }
  ),
})

--------------------------------------------------------------------------------
---- Telescope

require("telescope").load_extension("fzf")

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})

--------------------------------------------------------------------------------
---- Colors

vim.opt.termguicolors = true                      -- enable true colors
vim.opt.background = "dark"
vim.cmd.colorscheme("solarized8")

--------------------------------------------------------------------------------
---- UI Layout

vim.opt.signcolumn = "yes"                        -- always show the sign column
vim.opt.number = true                             -- display line numbers
vim.opt.showcmd = true                            -- show command in bottom bar
vim.opt.cursorline = true                         -- highlight current line
vim.opt.wildmenu = true                           -- visual autocomplete for command menu
vim.opt.wildmode = { "list:longest", "full" }     -- better autocomplete menu
vim.opt.showmode = false                          -- don't show mode when changing mode

--------------------------------------------------------------------------------
---- Windows

vim.opt.splitbelow = true                         -- horizontal splits open down
vim.opt.splitright = true                         -- vertical splits open to the right

--------------------------------------------------------------------------------
---- Searching

vim.opt.ignorecase = true                         -- ignore case when searching
vim.opt.smartcase = true                          -- only ignore case when input is all lower case
vim.opt.incsearch = true                          -- search as characters are entered
vim.opt.hlsearch = true                           -- highlight all matches

--------------------------------------------------------------------------------
---- Space and Tabs

vim.opt.tabstop = 2                               -- 2 space tab
vim.opt.expandtab = true                          -- use spaces for tabs
vim.opt.softtabstop = 2                           -- 2 space tab
vim.opt.shiftwidth = 2                            -- size of an indent
vim.opt.autoindent = true                         -- indent new lines
vim.opt.smartindent = true                        -- smarter autoindenting
vim.opt.linebreak = true                          -- wrap long lines better

--------------------------------------------------------------------------------
---- Misc

vim.opt.backspace = { "indent", "eol", "start" }  -- make backspace work as expected
vim.opt.hidden = true                             -- allow switching buffers without saving
vim.opt.lazyredraw = true                         -- don't redraw if action is not typed
vim.opt.compatible = false                        -- be not compatible with vi
vim.opt.ttyfast = true                            -- faster redraw
vim.opt.timeout = false                           -- do not time out prefix or leader keys
vim.opt.ttimeout = true                           -- time out key code sequences
vim.opt.clipboard = "unnamedplus"                 -- enable copy and paste into system clipboard
vim.opt.mouse = "a"                               -- enable mouse support
vim.opt.eventignore = "FocusLost"                 -- ignore FocusLost event
vim.opt.foldmethod = "expr"                       -- use custom folding
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"   -- use treesitter for folding
vim.opt.foldlevelstart = 99                       -- open all folds initially
vim.opt.scrolloff = 8                             -- minimum lines to keep above and below cursor

--------------------------------------------------------------------------------
---- Key Mappings

-- center cursor after move operations
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
-- easier terminal escape
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
-- toggle undo tree window
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
-- insert a newline in normal mode
vim.keymap.set("n", "<C-o>", ":set paste<CR>m`o<Esc>``:set nopaste<CR>", { silent = true })
