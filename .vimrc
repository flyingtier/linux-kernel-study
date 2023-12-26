#!/bin/bash


"============ vim-plugin ==========="
call plug#begin('~/.vim/autoload')

Plug 'preservim/nerdtree'
Plug 'preservim/tagbar'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'frazrepo/vim-rainbow'
Plug 'morhetz/gruvbox'

call plug#end()


nmap <F9> :NERDTreeToggle
nmap <F8> :TagbarToggle
let g:rainbow_active = 1


"" vim-airline setting
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_highlighting_cache = 1
let g:airline_powerline_fonts = 1


set background=dark
set termguicolors
colorscheme gruvbox



"============ kernel source ==========="
let kernel_src_home=$PWD

set number backspace=indent,eol,start
set ruler
"set ts=4 sts=4 sw=4"
set tabstop=4 softtabstop=-1 shiftwidth=4 expandtab

set smartindent
set cindent
" set paste"

set ignorecase
set showmatch
set hlsearch

set fileencodings=utf-8,euc-kr
set mouse=
set cc=80    " 80라인 컬럼 표시"
set nowrap

syntax on

"============ remember last line ==========="
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | 
  	  \ exe "normal! g'\"" | endif
endif


"============ ctags, scope ==========="
if filereadable(kernel_src_home . "/cscope.out")
    set sw=8 ts=8 sts=8
    exe "set tags+=" . kernel_src_home . "/tags"
    exe "cscope add " . kernel_src_home . "/cscope.out"
endif

set csprg=/usr/bin/cscope
