#!/bin/bash


"============ vim-plugin ==========="
call plug#begin('~/.vim/autoload')

Plug 'preservim/nerdtree'
Plug 'preservim/tagbar'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'vim-airline/vim-airline'
Plug 'frazrepo/vim-rainbow'
Plug 'morhetz/gruvbox'

" for golang.."
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'valloric/youcompleteme', { 'do': 'python3 ./install.py --clang-completer --go-completer --js-completer'}

" 편의.."
Plug 'milkypostman/vim-togglelist'
Plug 'AndrewRadev/splitjoin.vim'

call plug#end()

nmap <F9> :NERDTreeToggle
nmap <F8> :TagbarToggle
let g:rainbow_active = 1

set termguicolors
let g:gruvbox_contrast_dark="hard"
set background=dark
autocmd vimenter * colorscheme gruvbox


"============ kernel source 경로 ==========="
let kernel_src_home=$PWD

set number backspace=indent,eol,start
set ruler
set ts=4 sts=4 sw=4

set autoindent smartindent cindent
set paste

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


"============ ctags, scope 경로 ==========="
if filereadable(kernel_src_home . "/cscope.out")
    set sw=8 ts=8 sts=8
    exe "set tags+=" . kernel_src_home . "/tags"
    exe "cscope add " . kernel_src_home . "/cscope.out"
endif

set csprg=/usr/bin/cscope
