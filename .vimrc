""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""" Plugins

call plug#begin('~/.vim/plugged')
Plug 'itchyny/lightline.vim'              " improved status line
Plug 'jeffkreeftmeijer/vim-numbertoggle'  " smartly set relativenumber
Plug 'jreybert/vimagit'                   " add git workflow inside vim
Plug 'junegunn/vim-peekaboo'              " show values of registers
Plug 'kshenoy/vim-signature'              " show marks in sign column
Plug 'majutsushi/tagbar'                  " generate and browse tags
Plug 'markonm/traces.vim'                 " range, pattern, substitute preview
Plug 'mbbill/undotree'                    " undo history visualizer
Plug 'mhinz/vim-signify'                  " show VCS information in sign column
Plug 'ntpeters/vim-better-whitespace'     " resolve trailing whitespace issues
Plug 'sjl/vitality.vim'                   " make focus events work inside tmux
Plug 'tpope/vim-surround'                 " text objects for parentheses

Plug 'lifepillar/vim-solarized8'

Plug 'mattn/emmet-vim'
Plug 'pangloss/vim-javascript'
Plug 'suan/vim-instant-markdown', {'on': 'InstantMarkdownPreview'}
Plug 'lervag/vimtex'
Plug 'KeitaNakamura/tex-conceal.vim'
Plug 'keith/tmux.vim'
Plug 'cespare/vim-toml'
Plug 'maralla/vim-toml-enhance'

call plug#end()

let g:plug_window='vertical topleft 75new'
let g:peekaboo_delay=1000
let g:better_whitespace_ctermcolor='grey'
let g:better_whitespace_guicolor='grey'
let g:strip_whitespace_on_save=1
let g:strip_whitespace_confirm=0

let g:instant_markdown_autostart=0
let g:instant_markdown_slow=1
let g:tex_flavor = 'latex'
let g:vimtex_latexmk_options='-pdfxe -file-line-error'

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

let g:lightline = {
      \   'colorscheme': 'solarized',
      \   'active': {
      \     'right': [['lineinfo'], ['percent'], ['filetype']]
      \   },
      \ }

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""" Misc

set backspace=indent,eol,start  " make backspace work as expected
set hidden                      " allow switching buffers without saving
set lazyredraw                  " don't redraw if action is not typed
set nocompatible                " be not compatible with vi
set ttyfast                     " faster redraw

" when a prefix or leader key is pressed, wait indefinitely for further input
" instead of timing out after one second
set notimeout
set ttimeout

if has('clipboard')
  set clipboard=unnamed         " allow for copy and paste into MacOS clipboard
endif
if has('mouse')
  set mouse=a                   " enable mouse
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""" Space and Tabs

set tabstop=2                   " 2 space tab
set expandtab                   " use spaces for tabs
set softtabstop=2               " 2 space tab
set shiftwidth=2                " size of an "indent"
set autoindent                  " indent new lines
set smartindent                 " smarter autoindenting
set linebreak                   " wrap long lines better

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""" Keybindings

nnoremap <C-t> :UndotreeToggle<CR>
" stop highlighting search text
nnoremap ,/ :nohlsearch<CR>
" insert a newline in normal mode
nnoremap <silent><C-o> :set paste<CR>m`o<Esc>``:set nopaste<CR>

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

set splitbelow                  " use a more natural splitting
set splitright
nnoremap <C-H> <C-W><C-H>       " save keystrokes
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""" Searching

set ignorecase                  " ignore case when searching
set smartcase                   " only ignore case when input is all lower case
set incsearch                   " search as characters are entered
set hlsearch                    " highlight all matches

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""" Autocommands

augroup configgroup
  autocmd!
  autocmd BufEnter Makefile setlocal noexpandtab
  autocmd BufNewFile,BufRead *.cls set syntax=tex
augroup END
