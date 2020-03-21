""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""" Plugins

call plug#begin('~/.vim/plugged')
Plug 'jeffkreeftmeijer/vim-numbertoggle'  " smartly set relativenumber
Plug 'jreybert/vimagit'                   " add git workflow inside vim
Plug 'junegunn/vim-peekaboo'              " show values of registers
Plug 'kshenoy/vim-signature'              " display marks in sign column
Plug 'majutsushi/tagbar'                  " generate and browse tags
Plug 'markonm/traces.vim'                 " range, pattern, substitute preview
Plug 'mbbill/undotree'                    " undo history visualizer
Plug 'mhinz/vim-signify'                  " display changed lines from version control in sign column
Plug 'ntpeters/vim-better-whitespace'     " resolve trailing whitespace issues
Plug 'sjl/vitality.vim'                   " makes focus events in vim work when inside tmux
Plug 'tpope/vim-surround'                 " text objects for parentheses
Plug 'vim-airline/vim-airline'            " better status line
Plug 'vim-airline/vim-airline-themes'     " status line themes

Plug 'lifepillar/vim-solarized8'

Plug 'neovimhaskell/haskell-vim', {'for': 'haskell'}
Plug 'pangloss/vim-javascript', {'for': 'javascript'}
Plug 'suan/vim-instant-markdown', {'for': 'markdown', 'on': 'InstantMarkdownPreview'}
Plug 'lervag/vimtex', {'for': 'tex'}
Plug 'keith/tmux.vim', {'for': 'tmux'}
Plug 'cespare/vim-toml', {'for': 'toml'}
Plug 'maralla/vim-toml-enhance', {'for': 'toml'}
call plug#end()

let g:plug_window='vertical topleft 75new'
let g:better_whitespace_ctermcolor='grey'
let g:better_whitespace_guicolor='grey'
let g:strip_whitespace_on_save=1
let g:strip_whitespace_confirm=0
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
let g:airline_theme='solarized'

let g:clang_library_path='/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/'
let g:instant_markdown_autostart=0
let g:instant_markdown_slow=1
let g:tex_flavor = 'latex'
let g:vimtex_latexmk_options='-pdfxe -file-line-error'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""" Colors

set termguicolors
set background=dark
colorscheme solarized8

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""" Misc

set backspace=indent,eol,start
set hidden                      " switch buffer without having to save current buffer
set laststatus=2                " leave airline bar on
set lazyredraw                  " don't redraw if action is not typed
set nocompatible                " be not compatible with vi
set ttyfast                     " faster redraw

if has("clipboard")
    set clipboard=unnamed       " allow for copy and paste into MacOS clipboard
endif
if has("mouse")
    set mouse=a                 " enable mouse
endif

" when a prefix or leader key is pressed, wait indefinitely for further input
" instead of timing out after one second
set notimeout
set ttimeout

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

map <C-p> :InstantMarkdownPreview<CR>
map <C-t> :UndotreeToggle<CR>
" stop highlighting search text
nmap <silent> ,/ :nohlsearch<CR>
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

set splitright                  " use a more natural splitting
set splitbelow
nnoremap <C-H> <C-W><C-H>       " save keystrokes
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""" Searching

set ignorecase                  " ignore case when searching
set smartcase                   " override ignorecase if search pattern contains upper case characters
set incsearch                   " search as characters are entered
set hlsearch                    " highlight all matches

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""" Autocommands

augroup configgroup
    autocmd!
    autocmd BufEnter Makefile setlocal noexpandtab
    autocmd BufNewFile,BufRead *.cls set syntax=tex
augroup END
