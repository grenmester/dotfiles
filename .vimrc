""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""" Plugins

call plug#begin('~/.vim/plugged')

" Colorscheme
Plug 'lifepillar/vim-solarized8'

" General
Plug 'itchyny/lightline.vim'              " improved status line
Plug 'jeffkreeftmeijer/vim-numbertoggle'  " smartly set relativenumber
Plug 'jreybert/vimagit'                   " add git workflow inside vim
Plug 'junegunn/vim-peekaboo'              " show values of registers
Plug 'kshenoy/vim-signature'              " show marks in sign column
Plug 'majutsushi/tagbar'                  " generate and browse tags
Plug 'markonm/traces.vim'                 " range, pattern, substitute preview
Plug 'mbbill/undotree'                    " undo history visualizer
Plug 'mengelbrecht/lightline-bufferline'  " show buffers in tabline
Plug 'mhinz/vim-signify'                  " show VCS information in sign column
Plug 'ntpeters/vim-better-whitespace'     " resolve trailing whitespace issues
Plug 'sjl/vitality.vim'                   " make focus events work inside tmux
Plug 'tpope/vim-surround'                 " text objects for parentheses

" Language-specific
Plug 'mattn/emmet-vim'
Plug 'pangloss/vim-javascript'
Plug 'suan/vim-instant-markdown', {'on': 'InstantMarkdownPreview'}
Plug 'lervag/vimtex'
Plug 'KeitaNakamura/tex-conceal.vim'
Plug 'keith/tmux.vim'
Plug 'cespare/vim-toml'
Plug 'maralla/vim-toml-enhance'

" Neovim-specific
if has('nvim')
  Plug 'neoclide/coc.nvim', {'branch': 'release'} " LSP support
  Plug 'Shougo/neosnippet.vim'                    " snippet support
  Plug 'Shougo/neosnippet-snippets'               " common snippets
endif

call plug#end()

let g:plug_window = 'vertical topleft 75new'
let g:peekaboo_delay = 1000
let g:better_whitespace_ctermcolor = 'grey'
let g:better_whitespace_guicolor = 'grey'
let g:strip_whitespace_on_save = 1
let g:strip_whitespace_confirm = 0
let g:instant_markdown_autostart = 0
let g:instant_markdown_slow = 1
let g:tex_flavor = 'latex'
let g:vimtex_latexmk_options = '-pdfxe -file-line-error'
let g:coc_global_extensions = [
      \   'coc-explorer',
      \   'coc-neosnippet',
      \   'coc-emmet',
      \   'coc-html',
      \   'coc-css',
      \   'coc-eslint',
      \   'coc-prettier',
      \   'coc-markdownlint',
      \   'coc-vimtex',
      \   'coc-python',
      \   'coc-vimlsp',
      \   'coc-json',
      \ ]

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""" Colors

set termguicolors               " enable true colors
colorscheme solarized8
set background=dark

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""" Status Bar

set laststatus=2                " leave status bar on
set noshowmode                  " don't show mode when changing mode
set showtabline=2               " leave tab line on

function! LightlineTabRight()
  return reverse(lightline#tabs())
endfunction

let g:lightline#bufferline#show_number = 1

let g:lightline = {
      \   'active': {
      \     'left': [['bufnum', 'mode', 'paste'],
      \              ['cocstatus', 'currentfunction', 'readonly', 'filename', 'modified']],
      \     'right': [['lineinfo'],
      \               ['percent'],
      \               ['filetype']],
      \   },
      \   'colorscheme': 'solarized',
      \   'component_expand': {
      \     'buffers': 'lightline#bufferline#buffers',
      \     'rtabs': 'LightlineTabRight',
      \   },
      \   'component_function': {
      \     'cocstatus': 'coc#status',
      \     'currentfunction': 'CocCurrentFunction',
      \   },
      \   'component_type': {
      \     'buffers': 'tabsel',
      \     'rtabs': 'tabsel',
      \   },
      \   'tabline': {
      \     'left': [['buffers']],
      \     'right': [['rtabs']],
      \   },
      \ }

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""" UI Layout

set relativenumber              " set relative line numbers
set number                      " display absolute line number on current line
set showcmd                     " show command in bottom bar
set cursorline                  " highlight current line
set wildmenu                    " visual autocomplete for command menu
set wildmode=list:longest,full  " better autocomplete menu
set showmatch                   " higlight matching parenthesis

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""" Windows

set splitbelow                  " horizontal splits open down
set splitright                  " vertical splits open to the right

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""" Searching

set ignorecase                  " ignore case when searching
set smartcase                   " only ignore case when input is all lower case
set incsearch                   " search as characters are entered
set hlsearch                    " highlight all matches

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""" Space and Tabs

set tabstop=2                   " 2 space tab
set expandtab                   " use spaces for tabs
set softtabstop=2               " 2 space tab
set shiftwidth=2                " size of an indent
set autoindent                  " indent new lines
set smartindent                 " smarter autoindenting
set linebreak                   " wrap long lines better

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""" Misc

set backspace=indent,eol,start  " make backspace work as expected
set hidden                      " allow switching buffers without saving
set lazyredraw                  " don't redraw if action is not typed
set nocompatible                " be not compatible with vi
set ttyfast                     " faster redraw
set notimeout                   " do not time out prefix or leader keys
set ttimeout                    " time out key code sequences

if has('clipboard')
  set clipboard=unnamed         " allow for copy and paste into MacOS clipboard
endif
if has('mouse')
  set mouse=a                   " enable mouse
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""" Key Mappings

" save keystrokes
nnoremap <C-H> <C-W><C-H>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>

nnoremap <C-t> :UndotreeToggle<CR>
" stop highlighting search text
nnoremap ,/ :nohlsearch<CR>
" insert a newline in normal mode
nnoremap <silent><C-o> :set paste<CR>m`o<Esc>``:set nopaste<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""" Autocommands

augroup configgroup
  autocmd!
  autocmd BufEnter Makefile setlocal noexpandtab
  autocmd BufNewFile,BufRead *.cls set syntax=tex
augroup END
