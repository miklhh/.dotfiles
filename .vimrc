"""
""" Minimalist .vimrc version for slow terminal emulators.
""" Author: Mikael Henriksson
"""

" --- Vim != Vi ---
set nocompatible
filetype off

" --- Vundle ---
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'preservim/nerdtree'
Plugin 'ap/vim-css-color'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
call vundle#end()
filetype plugin indent on

" --- Leader key ---
let mapleader = " "

" --- Prefer white spaces over tabs ---
filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab

" --- Line and column numbering ---
set number
set relativenumber
set ruler
nmap <C-L><C-L> :set invrelativenumber<CR>

" --- Delete functionality. Use 'Leader+d' to remove and yank. ---
nnoremap d "_d
xnoremap d "_d
nnoremap x "_x
xnoremap x "_x
nnoremap s "_s
xnoremap s "_s
nnoremap c "_c
xnoremap c "_c
nnoremap C "_C
xnoremap C "_C
nnoremap <leader>d ""d
xnoremap <leader>d ""d

" --- i3-like binding for switching between splits ---
nnoremap <leader>ö <C-W>l
nnoremap <leader>j <C-W>h
nnoremap <leader>l <C-W>k
nnoremap <leader>k <C-W>j

" --- Nerdtree settings.
nnoremap <leader>o :NERDTreeToggle<CR>
let NERDTreeShowLineNumbers=1

" --- Airline settings
let g:airline_theme = 'solarized'
set background=light

" --- Other settings
set laststatus=2
set scrolloff=4
set backspace=2
set hlsearch
syntax on
set nowrap
