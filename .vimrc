"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""" Plugins

call plug#begin('~/.vim/plugged')
Plug 'ntpeters/vim-better-whitespace'
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
Plug 'Xuyuanp/nerdtree-git-plugin', {'on': 'NERDTreeToggle'}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'bling/vim-bufferline'
Plug 'airblade/vim-gitgutter'
Plug 'wlangstroth/vim-racket', {'for': 'racket'}
Plug 'suan/vim-instant-markdown', {'for': 'markdown'}
Plug 'lervag/vimtex', {'for': 'tex'}
Plug 'vim-syntastic/syntastic'
Plug 'Valloric/YouCompleteMe'
Plug 'tpope/vim-fugitive'
Plug 'sjl/vitality.vim'
call plug#end()

let g:plug_window='vertical topleft 75new'
let g:instant_markdown_slow=1           " make vim-instant-markdown refresh on only certain events
let g:instant_markdown_autostart=0      " turn vim-instant-markdown autostart off
let g:airline_powerline_fonts=1         " automatically populate with powerline glyphs
let g:airline_theme='solarized'         " use solarized for airline
let g:airline#extensions#tabline#enabled=1
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
let g:vimtex_latexmk_options='-xelatex -synctex=1 -file-line-error'
let g:syntastic_enable_racket_racket_checker=1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""" Colors

syntax enable                   " enable syntax processing
set background=dark
colorscheme solarized
highlight ExtraWhitespace ctermbg = grey guibg = #A8A8A8

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""" Misc

set nocompatible                " be iMproved
set lazyredraw                  " don't redraw if action is not typed
set ttyfast                     " faster redraw
set backspace=indent,eol,start
set laststatus=2                " leave airline bar on
filetype off
if has("clipboard")
   set clipboard=unnamed       " allow for copy and paste into macOS clipboard
endif
if has("mouse")
    set mouse=a
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""" Space and Tabs

set tabstop=4                   " 4 space tab
set expandtab                   " use spaces for tabs
set softtabstop=4               " 4 space tab
set shiftwidth=4                " size of an "indent"
set modelines=1
set autoindent
set linebreak
filetype plugin indent on       " load filetype-specific indent files and use the filetype plugins

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""" Keybindings

map <C-n> :NERDTreeToggle<CR>
map <C-p> :InstantMarkdownPreview<CR>
nmap <silent> ,/ :nohlsearch<CR>    " shortcut to stop highlighting search text

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""" UI Layout

set relativenumber              " set relative line numbers
set number                      " show line numbers
set showcmd                     " show command in bottom bar
set cursorline                  " highlight current line
set wildmenu                    " visual autocomplete for command menu
set showmatch                   " higlight matching parenthesis

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""" Panes

set splitright                  " use a more natural splitting
set splitbelow
nnoremap <C-J> <C-W><C-J>       " save keystrokes
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""" Searching

set ignorecase                  " ignore case when searching
set incsearch                   " search as characters are entered
set hlsearch                    " highlight all matches

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""" AutoGroups

augroup configgroup
    autocmd!
    autocmd VimEnter * highlight clear SignColumn
    autocmd BufEnter * EnableStripWhitespaceOnSave
    autocmd FileType php setlocal expandtab
    autocmd FileType php setlocal list
    autocmd FileType php setlocal listchars=tab:+\ ,eol:-
    autocmd FileType php setlocal formatprg=par\ -w80\ -T4
    autocmd FileType ruby setlocal tabstop=2
    autocmd FileType ruby setlocal shiftwidth=2
    autocmd FileType ruby setlocal softtabstop=2
    autocmd FileType ruby setlocal commentstring=#\ %s
    autocmd FileType python setlocal commentstring=#\ %s
    autocmd BufEnter Makefile setlocal noexpandtab
    autocmd BufNewFile,BufRead *.tt setfiletype tt2
    autocmd FileType tt setlocal nofixeol
    autocmd BufNewFile,BufRead *.cls setfiletype tex
augroup END
