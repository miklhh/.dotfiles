"""
""" Mikael Henriksson .vimrc for the vim editor.
""" Updated: 2018-01-14
""" Updated: 2018-09-03
""" Updated: 2018-10-31
"""
""" Requires the Vundle Vim plugin manager. Information on how this component
""" can be installed can be found on: 'https://github.com/VundleVim/Vundle.vim'.
""" Once Vundle is installed, invoke 'PluginInstall' from the Vim command line.
"""
""" One should install the compile time component of YouCompleteMe in order to
""" utilize it. Instructions of doing this can be found on the YCM Github
""" page: 'https://github.com/ycm-core/YouCompleteMe'. To install the powerline
""" fonts, invoke '~/.vim/bundle/powerline-fonts/install.sh' to copy the
""" powerline fonts to their propriate directory. If one want to remove these
""" these fonts, run the uninstall.sh script from the same directory.


" --- Vundle package manager for Vim. ---
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'tpope/vim-repeat'
Plugin 'svermeulen/vim-easyclip'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'powerline/powerline-fonts'

call vundle#end()
filetype plugin indent on


" --- YouCompleteMe settings. ---
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 1
let g:ycm_enable_diagnostic_signs = 0
let g:ycm_enable_diagnostic_highlighting = 0
let g:ycm_extra_conf_globlist = ['~/programming/mOS/*']


" --- Airline settings. ---
let g:airline_powerline_fonts = 1
let g:airline_theme = 'bubblegum'
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.whitespace = '三'
let g:airline_symbols.linenr = '三'


" --- Line numbering, toggle with Ctrl+L+L ---
set number
set relativenumber
nmap <C-L><C-L> :set invrelativenumber<CR>


" --- Use whitespaces for tabs ---
filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab


" --- Specialfile treatments ---
autocmd BufEnter *.tcc :setlocal filetype=cpp
autocmd BufEnter *.tpp :setlocal filetype=cpp


" --- Natural split navigations ---
nnoremap <C-H> <C-W><C-H>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>


" --- Other settings ---
set clipboard=unnamedplus   " For copying protocol.
set laststatus=2            " For always displaing status line.
set scrolloff=4             " For using offset when scrolling.
syntax on
set nowrap

" --- Readability and coloring.
colorscheme slate
set hlsearch
set cursorline
highlight CursorLine term=bold cterm=bold guibg=Grey40
highlight Search ctermbg=Green ctermfg=Black
