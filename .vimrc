""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""" Plugins

call plug#begin('~/.vim/plugged')

" Colorscheme
Plug 'lifepillar/vim-solarized8'

" General
Plug 'itchyny/lightline.vim'              " improved status bar
Plug 'jeffkreeftmeijer/vim-numbertoggle'  " smartly set relativenumber
Plug 'jreybert/vimagit'                   " add git workflow inside vim
Plug 'junegunn/vim-peekaboo'              " show values of registers
Plug 'kshenoy/vim-signature'              " show marks in sign column
Plug 'lambdalisue/nerdfont.vim'           " nerd font support
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
Plug 'yuezk/vim-js'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'suan/vim-instant-markdown', {'on': 'InstantMarkdownPreview'}
Plug 'lervag/vimtex'
Plug 'KeitaNakamura/tex-conceal.vim'
Plug 'keith/tmux.vim'
Plug 'cespare/vim-toml'
Plug 'maralla/vim-toml-enhance'

" Neovim-specific
if has('nvim')
  Plug 'neoclide/coc.nvim', {'branch': 'release'} " LSP support
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
let g:instant_markdown_mathjax = 1
let g:tex_flavor = 'latex'
let g:vimtex_compiler_progname = 'nvr'
let g:vimtex_view_method = 'zathura'
let g:coc_global_extensions = [
      \   'coc-explorer',
      \   'coc-snippets',
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

let g:lightline#bufferline#clickable = 1
let g:lightline#bufferline#enable_nerdfont = 1
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
      \   'component_raw': {
      \     'buffers': 1,
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

set signcolumn=yes              " always show the sign column
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
  set clipboard=unnamedplus     " enable copy and paste into system clipboard
endif
if has('mouse')
  set mouse=a                   " enable mouse support
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""" Key Mappings

" save keystrokes
nnoremap <C-H> <C-W><C-H>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>

" toggle undo tree window
nnoremap <C-t> :UndotreeToggle<CR>
" stop highlighting search text
nnoremap ,/ :nohlsearch<CR>
" insert a newline in normal mode
nnoremap <silent><C-o> :set paste<CR>m`o<Esc>``:set nopaste<CR>

" switch to buffers by ordinal number
nmap <leader>1 <Plug>lightline#bufferline#go(1)
nmap <leader>2 <Plug>lightline#bufferline#go(2)
nmap <leader>3 <Plug>lightline#bufferline#go(3)
nmap <leader>4 <Plug>lightline#bufferline#go(4)
nmap <leader>5 <Plug>lightline#bufferline#go(5)
nmap <leader>6 <Plug>lightline#bufferline#go(6)
nmap <leader>7 <Plug>lightline#bufferline#go(7)
nmap <leader>8 <Plug>lightline#bufferline#go(8)
nmap <leader>9 <Plug>lightline#bufferline#go(9)
nmap <leader>0 <Plug>lightline#bufferline#go(10)

if has('nvim')
  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
      call CocActionAsync('doHover')
    else
      execute '!' . &keywordprg . ' ' . expand('<cword>')
    endif
  endfunction

  " organize imports of the current buffer
  command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')
  " show documentation in preview window
  nnoremap K :call <SID>show_documentation()<CR>
  nmap <leader>rn <Plug>(coc-rename)
  nmap [g <Plug>(coc-diagnostic-prev)
  nmap ]g <Plug>(coc-diagnostic-next)
  nmap gd <Plug>(coc-definition)
  nmap gi <Plug>(coc-implementation)
  nmap gr <Plug>(coc-references)
  nmap gy <Plug>(coc-type-definition)

  " trigger completion menu
  inoremap <expr> <C-space> coc#refresh()
  " select completion menu item
  inoremap <expr> <CR> pumvisible() ? coc#_select_confirm()
        \: "\<C-g>u\<CR>\<C-r>=coc#on_enter()\<CR>"

  " open coc-explorer in floating mode
  nnoremap <space>e :CocCommand explorer --preset floating<CR>
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""" Autocommands

augroup configgroup
  autocmd!
  autocmd BufNewFile,BufRead *.cls set syntax=tex
augroup END
