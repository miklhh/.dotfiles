"""
""" True-hearted .vimrc (and init.nvim) for quick and easy navigation and file editing. All of the cross-configuration
""" files loaded by this configuration are available under 'https://github.com/miklhh/.dotfiles'.
""" Happy go lucky as this configuration is licensed under the premisive MIT License. Have at it.
"""
""" Author: Mikael Henriksson (2015 - 2022)
"""

" --------------------------------------------------------------------------------------------------------------------
" --                                                 Initialization                                                 --
" --------------------------------------------------------------------------------------------------------------------

" Vim != Vi
set nocompatible

" Enable plugin loading, auto indentation and syntax highlighting
filetype plugin indent on
syntax on

" Enable 24-bit true color support
if exists('+termguicolors')
    " Tmux true color compliance
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

    " Enable true color
    set termguicolors
endif

" --------------------------------------------------------------------------------------------------------------------
" --                                                    Vim Plug                                                    --
" --------------------------------------------------------------------------------------------------------------------

call plug#begin('~/.vim/plugged')

    " Vim Sneak
    Plug 'justinmk/vim-sneak'

    " Vim <3 FZF
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'chengzeyi/fzf-preview.vim'

    " Gives access to :Bdelete and :Bwipeout; like :bdelete and :bwipeout but without closing the pane
    Plug 'moll/vim-bbye'

    " UndoTree for easy undo history access
    Plug 'mbbill/undotree'

    " Clipboard peek-a-boo
    Plug 'junegunn/vim-peekaboo'

    " Git integration in Vim with vim-fugitive
    Plug 'tpope/vim-fugitive'

    " Maximize Vim splits
    Plug 'szw/vim-maximizer'

    " Go-to file manager (gof) or go-to terminal (got)
    Plug 'justinmk/vim-gtfo'

    " Easy Vim alignment
    Plug 'junegunn/vim-easy-align'

    " TMux + Vim seamless pane/split navigation
    Plug 'christoomey/vim-tmux-navigator'

    " Gruvbox clolorscheme
    Plug 'morhetz/gruvbox'
    Plug 'junegunn/seoul256.vim'

    " Airline tray
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    " Get (Neo)Vim startup time with :StartupTime
    Plug 'dstein64/vim-startuptime'

    " LaTeX synctex synchronization through DBus
    Plug 'peterbjorgensen/sved'

    " Plugins specific to NeoVim starts here
    if has('nvim')

        " Good default LSP server configurations
        Plug 'neovim/nvim-lspconfig'

        " LSP server package manager Mason, replacing the depricated nvim-lsp-installer. Trigger with: 'Mason',
        " 'MasonInstall <package>' and 'MasonLog'
        Plug 'williamboman/mason.nvim'
        Plug 'williamboman/mason-lspconfig.nvim'
        Plug 'mfussenegger/nvim-lint'

        " LSP tree view
        Plug 'simrat39/symbols-outline.nvim'

        " NeoVim devicons (needed by ex: nvim-tree and trouble.nvim)
        Plug 'kyazdani42/nvim-web-devicons'

        " NeoVim tree view
        Plug 'kyazdani42/nvim-tree.lua'

        " LSP diagnostics highlight group for colorschemes that don't yet support them. Prerequisite of 
        " folke/trouble.nvim.
        Plug 'folke/lsp-colors.nvim'

        " NeoVim LSP diagnostics prettifier and telescope
        Plug 'folke/trouble.nvim'

        " Autocompletion engine
        Plug 'hrsh7th/nvim-cmp'
        Plug 'hrsh7th/cmp-nvim-lsp'
        Plug 'hrsh7th/cmp-buffer'
        Plug 'hrsh7th/cmp-path'
        Plug 'hrsh7th/cmp-cmdline'

        " Pictograms for nvim-cmp
        Plug 'onsails/lspkind-nvim'

        " Snippet engine with snippet support for LSP-servers
        Plug 'hrsh7th/vim-vsnip'
        Plug 'hrsh7th/vim-vsnip-integ'

        " TreeSitter syntax highlighting
        Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
        Plug 'nvim-treesitter/playground'

        " Toggle LSP diagnostics 'ToggleDiagOn/ToggleDiagOff'
        Plug 'WhoIsSethDaniel/toggle-lsp-diagnostics.nvim'

        " FZF LSP things
        Plug 'gfanto/fzf-lsp.nvim'
        Plug 'nvim-lua/plenary.nvim'

        " NeoVims which-key
        Plug 'folke/which-key.nvim'

        " NeoVim sudo read/write (:SudaRead, :SudaWrite)
        Plug 'lambdalisue/suda.vim'

    endif " -- End of NeoVim specific plugins

    " Proper syntax highlighting when editing .tmux.conf
    Plug 'tmux-plugins/vim-tmux'

    " Fuzzy incsearch (<leader>/)
    Plug 'haya14busa/incsearch.vim'
    Plug 'haya14busa/incsearch-fuzzy.vim'

    " Jupyter Vim support
    Plug 'jupyter-vim/jupyter-vim'

    " Colorizer
    Plug 'norcalli/nvim-colorizer.lua'

" Initialize plugin system
call plug#end()

" --------------------------------------------------------------------------------------------------------------------
" --                                                  Appearance                                                    --
" --------------------------------------------------------------------------------------------------------------------

" Gruvbox colorscheme settings - more info: https://github.com/morhetz/gruvbox/wiki/Configuration
let g:gruvbox_bold='1'
let g:gruvbox_italic='1'
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_contrast_light='hard'
set background=dark
colorscheme gruvbox

" Airline settings
let g:airline_theme = 'gruvbox'
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ' :'
let g:airline_symbols.maxlinenr = ' '
let g:airline_symbols.column = '➔'
set noshowmode

" Line and column numbering
set number
set relativenumber
set ruler
nmap <C-L><C-L> :set invrelativenumber<CR>

" Colorization for all filetypes
if has('nvim')
    lua require'colorizer'.setup()
endif

" --------------------------------------------------------------------------------------------------------------------
" --                                                   Keybindings                                                  --
" --------------------------------------------------------------------------------------------------------------------

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

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" LSP symbols outline
if has('nvim')
    map <Leader>S :SymbolsOutline<CR>
endif 

" No yank on delete. Use <Leader+d> to remove and yank
nnoremap d "_d
xnoremap d "_d
nnoremap x "_x
xnoremap x "_x
nnoremap c "_c
xnoremap c "_c
nnoremap C "_C
xnoremap C "_C
nnoremap <leader>d ""d
xnoremap <leader>d ""d

" Use <Ctrl+c/x> to copy/cut into register + when in visual mode
vnoremap <C-c> "+y
vnoremap <C-x> "+d

" No highlight
nnoremap <leader>n :noh<CR>

" Switch between panes (i3-like) using TMux Navigator
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <M-j> :TmuxNavigateLeft<cr>
nnoremap <silent> <M-l> :TmuxNavigateUp<cr>
nnoremap <silent> <M-k> :TmuxNavigateDown<cr>
nnoremap <silent> <M-ö> :TmuxNavigateRight<cr>

" Move current split to the far right/left (i3-like)
nnoremap <M-Ö> <C-W>L
nnoremap <M-J> <C-W>H
nnoremap <M-K> <C-W>J
nnoremap <M-L> <C-W>K

" Create new (empty) splits (tmux-like)
set splitright
set splitbelow
nnoremap <M-I> :vnew<CR>
nnoremap <M-U> :new<CR>

" UndoTree
nnoremap <leader>u :UndotreeToggle<CR>

" Vim Maximizer
nnoremap <M-F> :MaximizerToggle<CR>

" Redraw
nnoremap <leader>r :redraw!<CR>

" FZF files in '~/.dotfiles'
nnoremap <leader>.e :FZF ~/.dotfiles<CR>

" FZF incsearch
map <leader>/ <Plug>(incsearch-fuzzy-/)
map <leader>? <Plug>(incsearch-fuzzy-?)

" Scroll with <C-j/k> when searching
cnoremap <C-j> <C-g>
cnoremap <C-k> <C-t>

" NeoVim tree toggle
if has('nvim')
    nnoremap <leader>, :NvimTreeToggle<CR>
endif

" Do not use default jupyter-vim keybindings
let g:jupyter_mapkeys = 0

" --------------------------------------------------------------------------------------------------------------------
" --                                                     Misc                                                       --
" --------------------------------------------------------------------------------------------------------------------

set mouse=a                     " Enable all mouse functionality
set laststatus=2                " Always show the status line in the last window
set scrolloff=4                 " Always show four lines above and under cursorline
set backspace=indent,eol,start  " Insert mode backspace (and <C-W>) settings
"set hlsearch                    " Highlight text on search
set hidden
set incsearch                   " Show searches in realtime
set signcolumn=no               " Extra linting column the the left (yes/no)
set cursorline                  " Highlight the row under the cursor
set nowrap                      " Don't wrap very long lines to next row
set ignorecase                  " Ignore casing when searching by default

" Use white space for tabbing
set tabstop=4
set shiftwidth=4
set expandtab

" Automatically re-read files that changes on disk, but only if they are marked as non-modified in their associated
" buffer
set autoread
au CursorHold * checktime

" Cycle numbered registers when yanking. This allow the numbered registers to act like a ring buffer when performing
" the yank operation (just like delete already does!)
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

" Alias bd -> Bd (vim-bbye buffer delete)
cnoreabbrev bd Bd

" FZF create new file quick-action (thank you Frans Skarman for this quickie) bound to <leader>E
function! FzfEditPrompt(file)
    let cmd = ':e ' . a:file . '/'
    call feedkeys(cmd)
endfunction
command! -nargs=1 FzfEditPrompt :call FzfEditPrompt(<f-args>)
map <leader>E :call fzf#run({'source': 'find . -type d -print', 'sink': 'FzfEditPrompt'})<CR>

" Newly open .tex-files are always LaTeX
let g:tex_flavor='latex'

" --------------------------------------------------------------------------------------------------------------------
" --                                             LSP settings for NeoVim                                            --
" --------------------------------------------------------------------------------------------------------------------

if has('nvim')

set completeopt=menu,menuone,noselect
lua << EOF
    require('config/cmp')       -- CMP autocompletion settings
    require('config/keybinds')  -- General LSP keybinds
    require('config/lsp')       -- LSP settings
    require('trouble').setup {
        -- trouble configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration: 'help trouble'
    }

    require('lint').linters_by_ft = {
        -- Filetypes and associated linters that are to execute
        -- when buffer is written
        markdown = {'vale'};
        sh = {'shellcheck'};
    }

    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      callback = function()
        require("lint").try_lint()
      end,
    })
EOF

endif "if has('nvim')

" --------------------------------------------------------------------------------------------------------------------
" --                                       Other external (Neo)Vim configurations                                   --
" --------------------------------------------------------------------------------------------------------------------

" Vim-Sneak settings
source ~/.config/vim/config/sneak.vim

" Vsnip keybindings
source ~/.config/vim/config/vsnip.vim

" Jupyther keybindings <leader+j>
source ~/.config/vim/config/jupyter-vim.vim

if has('nvim')

lua <<EOF
    require('nvim-tree').setup()
    require('config/treesitter')
    require('config/which-key')
EOF

endif "if has('nvim')

