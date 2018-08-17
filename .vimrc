""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""" Plugins

call plug#begin('~/.vim/plugged')
Plug 'ntpeters/vim-better-whitespace'
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
Plug 'Xuyuanp/nerdtree-git-plugin', {'on': 'NERDTreeToggle'}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'suan/vim-instant-markdown', {'for': 'markdown', 'on': 'InstantMarkdownPreview'}
Plug 'lervag/vimtex', {'for': 'tex'}
Plug 'vim-syntastic/syntastic'
Plug 'jreybert/vimagit'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
Plug 'cespare/vim-toml', {'for': 'toml'}
Plug 'maralla/vim-toml-enhance', {'for': 'toml'}
Plug 'keith/tmux.vim', {'for': 'tmux'}
Plug 'majutsushi/tagbar'
Plug 'mbbill/undotree'
Plug 'myusuf3/numbers.vim'
Plug 'osyo-manga/vim-over'
Plug 'junegunn/vim-peekaboo'
Plug 'kshenoy/vim-signature'
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-surround'
if has("nvim")
    Plug 'floobits/floobits-neovim'
    Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
endif
call plug#end()

let g:plug_window='vertical topleft 75new'
let g:instant_markdown_slow=1           " make vim-instant-markdown refresh on only certain events
let g:instant_markdown_autostart=0      " turn vim-instant-markdown autostart off
let g:airline_powerline_fonts=1         " automatically populate with powerline glyphs
let g:airline_theme='solarized'         " use solarized for airline
let g:airline#extensions#tabline#enabled=1
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
let g:vimtex_latexmk_options='-pdfxe -file-line-error'
let g:syntastic_enable_racket_racket_checker=1
let g:deoplete#enable_at_startup=1
let g:clang_library_path='/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/'
let g:tex_flavor = "latex"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""" Cursor Shape

if has("nvim")
    let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""" Colors

set background=dark
colorscheme solarized
highlight ExtraWhitespace ctermbg = grey guibg = #A8A8A8

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

" when a prefix or leader key is pressed, wait indefinitely for further input,
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
set linebreak

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""" Keybindings

map <C-n> :NERDTreeToggle<CR>
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
set wildmode=list:longest,full
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
    autocmd VimEnter * highlight clear SignColumn
    autocmd BufEnter * EnableStripWhitespaceOnSave
    autocmd VimLeave tex VimtexClean
    autocmd FileType php setlocal expandtab
    autocmd FileType php setlocal list
    autocmd FileType php setlocal listchars=tab:+\ ,eol:-
    autocmd FileType php setlocal formatprg=par\ -w80\ -T4
    autocmd FileType ruby setlocal commentstring=#\ %s
    autocmd FileType python setlocal commentstring=#\ %s
    autocmd BufEnter Makefile setlocal noexpandtab
    autocmd BufNewFile,BufRead *.cls setfiletype tex
    "autocmd BufReadPost *.cls setfiletype tex
augroup END
