"""
""" True-hearted .vimrc for quick and easy navigation and file editing
""" Author: Mikael Henriksson
"""

" -----------------------------------------------------------------------------
" --                             Initialization                              --
" -----------------------------------------------------------------------------

" Vim != Vi
set nocompatible
filetype off

" Enable 24-bit true color support
if exists('+termguicolors')
    " Tmux compliance
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

    " Enable true color
    set termguicolors
endif

" Enable filetype detection, plugin loading and auto indentation
filetype plugin indent on
syntax on

" -----------------------------------------------------------------------------
" --                               Vim Plug                                  --
" -----------------------------------------------------------------------------
"
call plug#begin('~/.vim/plugged')

    " Airline Vim tray
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    " UndoTree and NerdTree
    Plug 'mbbill/undotree'
    Plug 'preservim/nerdtree'

    " Colorscheme
    Plug 'morhetz/gruvbox'

    " Vim FZF
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'chengzeyi/fzf-preview.vim'

    " Clipboard peek-a-boo
    Plug 'junegunn/vim-peekaboo'

    " Gives :Bdetele and :Bwipeout which behaves like well designed citizens
    Plug 'moll/vim-bbye'

    " Get Vim startup time with :StartupTime
    Plug 'dstein64/vim-startuptime'

    " Vim fugitive (Git integration)
    Plug 'tpope/vim-fugitive'

    " Neovim LSP plugins
    if has('nvim')
        " Good default LSP configurations for common LSP-Servers
        Plug 'neovim/nvim-lspconfig'

        " Auto completion plugin for NVim
        Plug 'hrsh7th/nvim-compe'
        Plug 'hrsh7th/vim-vsnip'
        Plug 'hrsh7th/vim-vsnip-integ'
    endif

    " NeoVim sudo read/write (:SudaRead, :SudaWrite)
    Plug 'lambdalisue/suda.vim'

" Initialize plugin system
call plug#end()

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"
imap <c-space> <Plug>(asyncomplete_force_refresh)


" -----------------------------------------------------------------------------
" --                              Appearance                                 --
" -----------------------------------------------------------------------------

" Gruvbox colorscheme settings
" More info: https://github.com/morhetz/gruvbox/wiki/Configuration
let g:gruvbox_bold='1'
let g:gruvbox_italic='0'
let g:gruvbox_contrast_dark='hard'
set background=dark
colorscheme gruvbox

" Airline settings
let g:airline_theme = 'gruvbox'

" Line and column numbering
set number
set relativenumber
set ruler
nmap <C-L><C-L> :set invrelativenumber<CR>


" -----------------------------------------------------------------------------
" --                              Keybindings                                --
" -----------------------------------------------------------------------------

" Map leader key to spacebar
let mapleader = " "

" Fzf file to open in new buffer by filename
map <Leader>e :FZF<CR>

" Fzf buffer swapping by filename
map <Leader>w :Buffers<CR>

" Fzf lines in current buffer
map <Leader>f :FZFBLines<CR>

" Fzf lines in all open buffers
map <Leader>F :Lines<CR>

" No yank on delete. Use <Leader+d> to remove and yank
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

" Pinky friendly substitute for <C-u> and <C-d>
nnoremap U <C-u>
nnoremap D <C-d>
xnoremap U <C-u>
xnoremap D <C-d>

" No highlight
nnoremap <leader>n :noh<CR>

" i3-like binding for switching between splits
nnoremap <leader>ö <C-W>l
nnoremap <leader>j <C-W>h
nnoremap <leader>k <C-W>j
nnoremap <leader>l <C-W>k

" NerdTree
let NERDTreeShowLineNumbers=1
nnoremap <leader>o :NERDTreeToggle<CR>

" UndoTree
nnoremap <leader>u :UndotreeToggle<CR>

" Redraw
nnoremap <leader>r :redraw!<CR>

" NVim-Compe keybindings
if has('nvim')
    inoremap <silent><expr> <C-Space> compe#complete()
    inoremap <silent><expr> <CR>      compe#confirm('<CR>')
    inoremap <silent><expr> <C-e>     compe#close('<C-e>')
    inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
    inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })
endif

" -----------------------------------------------------------------------------
" --                                Misc                                     --
" -----------------------------------------------------------------------------

" Other settings
set laststatus=2
set scrolloff=4
set backspace=2
set hlsearch        " Highlight on search
set hidden          " Keep buffers open in bg for fast reopening
set incsearch       " Highlight text when searching
set signcolumn=no   " No extra linting column
set cursorline      " Highlight the current line
set nowrap

" Use white space for tabbing
set tabstop=4
set shiftwidth=4
set expandtab

" Cycle numbered registers when yanking. This allow the numbered registers to
" act like a ring buffer when performing the yank operation (just like delete
" already does!)
function! SaveLastReg()
    if v:event['regname']==""
        if v:event['operator']=='y'
            for i in range(8,1,-1)
                exe "let @".string(i+1)." = @". string(i)
            endfor
            if exists("g:last_yank")
                let @1=g:last_yank
            endif
            let g:last_yank=@"
        endif
    endif
endfunction
if !exists("g:RegisteredYankRingBuffer")
    let g:RegisteredYankRingBuffer="1"
    :autocmd TextYankPost * call SaveLastReg()
endif
:autocmd VimEnter * let g:last_yank=@"

" -----------------------------------------------------------------------------
" --                        LSP settings for NeoVim                          --
" -----------------------------------------------------------------------------
"
if has('nvim')

" Autocompletion using NVim-Compe. NVim-Compe has been depricated and should
" be replaced with NVim-Cmp in the future. Although, as writing this note,
" NVim-Cmp is not yet ready to replace NVim-Compe.
"   -- Mikael Henriksson [2021-09-15]
set completeopt=menuone,noselect
lua << EOF
    require('config/compe')
    require('config/keybinds')
EOF

" [LaTeX] LSP config
lua << EOF
    require'lspconfig'.texlab.setup{}
EOF

" [C++] Clangd config
lua << EOF
    require'lspconfig'.clangd.setup{}
EOF

" [Rust] Rust Analyzer config
lua << EOF
    require'lspconfig'.rust_analyzer.setup{}
EOF

" VHDL Language server with VHDL-Tool
lua << EOF
    local lspconfig = require'lspconfig'
    local configs = require'lspconfig/configs'
    local util = require 'lspconfig/util'
    -- Check if it's already defined for when reloading this file.
    if not lspconfig.vhdl_tool then
      configs.vhdl_tool = {
        default_config = {
          cmd = {'vhdl-tool', 'lsp'};
          filetypes = {'vhdl'};
          root_dir = util.root_pattern('vhdltool-config.yaml', '.git');
          settings = {};
        };
      }
    end
    lspconfig.vhdl_tool.setup{}
EOF

endif "if has('nvim')

