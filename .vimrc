""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""" Plugins

call plug#begin('~/.vim/plugged')
Plug 'ntpeters/vim-better-whitespace'
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
Plug 'Xuyuanp/nerdtree-git-plugin', {'on': 'NERDTreeToggle'}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'suan/vim-instant-markdown', {'for': 'markdown', 'on': 'InstantMarkdownPreview'}
Plug 'lervag/vimtex', {'for': 'tex'}
Plug 'vim-syntastic/syntastic'
Plug 'tpope/vim-fugitive'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
Plug 'cespare/vim-toml', {'for': 'toml'}
Plug 'maralla/vim-toml-enhance', {'for': 'toml'}
Plug 'keith/tmux.vim', {'for': 'tmux'}
Plug 'majutsushi/tagbar'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'mbbill/undotree'
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

set nocompatible                " be iMproved
set lazyredraw                  " don't redraw if action is not typed
set ttyfast                     " faster redraw
set backspace=indent,eol,start
set hidden                      " switch buffer without having to save current buffer
set laststatus=2                " leave airline bar on

if has("clipboard")
    set clipboard=unnamed       " allow for copy and paste into macOS clipboard
endif
if has("mouse")
    set mouse=a
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
set modelines=1
set autoindent
set linebreak

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""" Keybindings

let mapleader=" "
map <C-n> :NERDTreeToggle<CR>
map <C-p> :InstantMarkdownPreview<CR>
map <C-t> :UndotreeToggle<CR>
nmap <silent> ,/ :nohlsearch<CR>    " shortcut to stop highlighting search text
nnoremap <silent><C-o> :set paste<CR>m`o<Esc>``:set nopaste<CR> " shortcut to insert a newline in normal mode

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""" UI Layout

set relativenumber              " set relative line numbers
set number                      " display absolute line number on current line
set showcmd                     " show command in bottom bar
set cursorline                  " highlight current line
set wildmenu                    " visual autocomplete for command menu
set showmatch                   " higlight matching parenthesis

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""" Windows

set splitright                  " use a more natural splitting
set splitbelow
nnoremap <C-J> <C-W><C-J>       " save keystrokes
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""" Searching

set ignorecase                  " ignore case when searching
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
    autocmd BufNewFile,BufRead *.tt setfiletype tt2
    autocmd FileType tt setlocal nofixeol
    autocmd filetype crontab setlocal nobackup nowritebackup
augroup END
