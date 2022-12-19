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
  -- LSP
  use("neovim/nvim-lspconfig")
  use("williamboman/nvim-lsp-installer")
  use("jose-elias-alvarez/null-ls.nvim")
  -- Treesitter
  use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
  use("nvim-treesitter/nvim-treesitter-textobjects")
  use("JoosepAlviste/nvim-ts-context-commentstring")
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
  -- Language-specific
  use({ "iamcco/markdown-preview.nvim", run = "cd app && yarn install", cmd = "MarkdownPreview" })
end)

vim.g.python3_host_prog = "/usr/bin/python"
vim.g.peekaboo_delay = 1000
vim.g.better_whitespace_ctermcolor = "grey"
vim.g.better_whitespace_guicolor = "grey"
vim.g.strip_whitespace_confirm = 0
vim.g.strip_whitespace_on_save = 1

--- Gitsigns

require("gitsigns").setup({
  on_attach = function(bufnr)
    local function map(mode, lhs, rhs, opts)
      opts = vim.tbl_extend("force", { noremap = true, silent = true }, opts or {})
      vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
    end

    map("n", "]c", "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", { expr = true })
    map("n", "[c", "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", { expr = true })
    map("n", "<leader>hs", "<cmd>Gitsigns stage_hunk<CR>")
    map("v", "<leader>hs", "<cmd>Gitsigns stage_hunk<CR>")
    map("n", "<leader>hr", "<cmd>Gitsigns reset_hunk<CR>")
    map("v", "<leader>hr", "<cmd>Gitsigns reset_hunk<CR>")
    map("n", "<leader>hS", "<cmd>Gitsigns stage_buffer<CR>")
    map("n", "<leader>hu", "<cmd>Gitsigns undo_stage_hunk<CR>")
    map("n", "<leader>hR", "<cmd>Gitsigns reset_buffer<CR>")
    map("n", "<leader>hp", "<cmd>Gitsigns preview_hunk<CR>")
    map("n", "<leader>hb", "<cmd>lua require'gitsigns'.blame_line{full=true}<CR>")
    map("n", "<leader>tb", "<cmd>Gitsigns toggle_current_line_blame<CR>")
    map("n", "<leader>hd", "<cmd>Gitsigns diffthis<CR>")
    map("n", "<leader>hD", "<cmd>lua require'gitsigns'.diffthis('~')<CR>")
    map("n", "<leader>td", "<cmd>Gitsigns toggle_deleted<CR>")
    map("o", "ih", ":<C-U>Gitsigns select_hunk<CR>")
    map("x", "ih", ":<C-U>Gitsigns select_hunk<CR>")
  end,
})

--- Lualine

require("lualine").setup({
  options = { theme = "solarized" },
  sections = { lualine_x = { "filetype" } },
  tabline = { lualine_b = { "buffers" }, lualine_y = { "tabs" } },
})

--- LSP

-- update diagnostics even in insert mode
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics,
  { update_in_insert = true }
)

-- show diagnostic source
vim.diagnostic.config({ virtual_text = { source = true } })

local function on_attach(client, bufnr)
  local function map(lhs, rhs)
    vim.api.nvim_buf_set_keymap(bufnr, "n", lhs, rhs, { noremap = true, silent = true })
  end

  map("gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
  map("gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
  map("K", "<cmd>lua vim.lsp.buf.hover()<CR>")
  map("gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
  map("<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
  map("<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>")
  map("<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
  map("<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>")
  map("gr", "<cmd>lua vim.lsp.buf.references()<CR>")
  map("<space>e", "<cmd>lua vim.diagnostic.open_float()<CR>")
  map("[d", "<cmd>lua vim.diagnostic.goto_prev({float = false})<CR>")
  map("]d", "<cmd>lua vim.diagnostic.goto_next({float = false})<CR>")
  map("<space>q", "<cmd>lua vim.diagnostic.setloclist()<CR>")
  map("<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>")
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  if client.name == "tsserver" then
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
  end
end

require("nvim-lsp-installer").on_server_ready(function(server)
  local opts = { on_attach = on_attach }

  if server.name == "sumneko_lua" then
    opts = vim.tbl_deep_extend(
      "force",
      { settings = { Lua = { diagnostics = { globals = { "vim", "use" } } } } },
      opts
    )
  end

  server:setup(opts)
end)

local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    null_ls.builtins.code_actions.gitsigns,
    null_ls.builtins.diagnostics.markdownlint,
    null_ls.builtins.diagnostics.pylint,
    null_ls.builtins.diagnostics.mypy,
    null_ls.builtins.formatting.isort,
    null_ls.builtins.formatting.black,
    null_ls.builtins.diagnostics.eslint,
    null_ls.builtins.formatting.prettier,
    null_ls.builtins.diagnostics.cppcheck,
    null_ls.builtins.formatting.stylua,
  },
})

--- Treesitter

require("nvim-treesitter.configs").setup({
  context_commentstring = { enable = true },
  ensure_installed = "maintained",
  highlight = { enable = true },
  indent = { enable = true },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
  },
})

--- Completion

local cmp = require("cmp")
local luasnip = require("luasnip")

require("luasnip/loaders/from_vscode").lazy_load()

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<C-y>"] = cmp.config.disable,
    ["<C-e>"] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
    ["<CR>"] = cmp.mapping.confirm(),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  },
  sources = cmp.config.sources(
    { { name = "nvim_lsp" }, { name = "luasnip" } },
    { { name = "buffer" } },
    { { name = "path" } }
  ),
  experimental = { ghost_text = true },
  formatting = {
    fields = { "abbr", "kind", "menu" },
    format = require("lspkind").cmp_format({
      with_text = false,
      before = function(entry, vim_item)
        vim_item.menu = ({
          nvim_lsp = "[LSP]",
          luasnip = "[Snippet]",
          buffer = "[File]",
          path = "[Path]",
        })[entry.source.name]

        return vim_item
      end,
    }),
  },
})

--------------------------------------------------------------------------------
---- Colors

vim.opt.termguicolors = true                      -- enable true colors
vim.opt.background = "dark"
vim.cmd([[colorscheme solarized8]])

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

--------------------------------------------------------------------------------
---- Key Mappings

-- save keystrokes
vim.api.nvim_set_keymap("n", "<C-H>", "<C-W><C-H>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-J>", "<C-W><C-J>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-K>", "<C-W><C-K>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-L>", "<C-W><C-L>", { noremap = true })
vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", { noremap = true })

-- toggle undo tree window
vim.api.nvim_set_keymap("n", "<C-t>", "<cmd>UndotreeToggle<CR>", { noremap = true })
-- stop highlighting search text
vim.api.nvim_set_keymap("n", ",/", "<cmd>nohlsearch<CR>", { noremap = true })
-- insert a newline in normal mode
vim.api.nvim_set_keymap("n", "<C-o>", "<cmd>set paste<CR>m`o<Esc>``:set nopaste<CR>", { noremap = true, silent = true })
