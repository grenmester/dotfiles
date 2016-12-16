" Plugins {{{
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-perl/vim-perl'
Plugin 'luochen1990/rainbow'
Plugin 'scrooloose/nerdtree'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'suan/vim-instant-markdown'
Plugin 'lervag/vimtex'
call vundle#end()

let g:rainbow_active = 0                " make rainbow off by default
let g:instant_markdown_slow = 1         " make vim-instant-markdown refresh on only certain events
let g:instant_markdown_autostart = 0    " turn vim-instant-markdown autostart off
" }}}
" Colors {{{
syntax enable                   " enable syntax processing
set background=dark
colorscheme solarized
" }}}
" Misc {{{
set nocompatible                " be iMproved
set lazyredraw                  " don't redraw if action is not typed
set ttyfast                     " faster redraw
set backspace=indent,eol,start
filetype off
" }}}
" Spaces & Tabs {{{
set tabstop=4                   "4 space tab
set expandtab                   " use spaces for tabs
set softtabstop=4               " 4 space tab
set shiftwidth=4                " size of an "indent"
set modelines=1
filetype indent on              " load filetype-specific indent files
filetype plugin on              " use the file type plugins
set autoindent
set linebreak
" }}}
" Keybindings {{{
map <C-n> :NERDTreeToggle<CR>
" }}}
" UI Layout {{{
set number                      " show line numbers
set showcmd                     " show command in bottom bar
set cursorline                  " highlight current line
set wildmenu                    " visual autocomplete for command menu
set showmatch                   " higlight matching parenthesis
" }}}
" Searching {{{
set ignorecase                  " ignore case when searching
set incsearch                   " search as characters are entered
set hlsearch                    " highlight all matches
" }}}
" Folding {{{
set foldenable                  " don't fold files by default on open
set foldmethod=indent           " fold based on indent level
set foldnestmax=10              " max 10 depth
set foldlevelstart=10           " start with fold level of 10
" }}}
" AutoGroups {{{
augroup configgroup
    autocmd!
    autocmd VimEnter * highlight clear SignColumn
    autocmd BufWritePre * StripWhitespace
    autocmd FileType java setlocal noexpandtab
    autocmd FileType java setlocal list
    autocmd FileType java setlocal listchars=tab:+\ ,eol:-
    autocmd FileType java setlocal formatprg=par\ -w80\ -T4
    autocmd FileType php setlocal expandtab
    autocmd FileType php setlocal list
    autocmd FileType php setlocal listchars=tab:+\ ,eol:-
    autocmd FileType php setlocal formatprg=par\ -w80\ -T4
    autocmd FileType ruby setlocal tabstop=2
    autocmd FileType ruby setlocal shiftwidth=2
    autocmd FileType ruby setlocal softtabstop=2
    autocmd FileType ruby setlocal commentstring=#\ %s
    autocmd FileType python setlocal commentstring=#\ %s
    autocmd BufEnter *.cls setlocal filetype=java
    autocmd BufEnter *.zsh-theme setlocal filetype=zsh
    autocmd BufEnter Makefile setlocal noexpandtab
    autocmd BufEnter *.sh setlocal tabstop=2
    autocmd BufEnter *.sh setlocal shiftwidth=2
    autocmd BufEnter *.sh setlocal softtabstop=2
    autocmd BufNewFile,BufRead *.tt setf tt2
augroup END
" }}}
" vim:foldmethod=marker:foldlevel=0
