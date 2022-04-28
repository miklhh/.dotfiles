"""
""" True-hearted .vimrc for quick and easy navigation and file editing
""" Author: Mikael Henriksson
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

    " Airline Vim tray
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    " UndoTree for easy undo history access
    Plug 'mbbill/undotree'

    " Colorscheme
    Plug 'morhetz/gruvbox'

    " Vim FZF
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'chengzeyi/fzf-preview.vim'

    " Clipboard peek-a-boo
    Plug 'junegunn/vim-peekaboo'

    " Gives :Bdelete and :Bwipeout; like :bdelete and :bwipeout but without closing the pane
    Plug 'moll/vim-bbye'

    " Get Vim startup time with :StartupTime
    Plug 'dstein64/vim-startuptime'

    " Vim fugitive (Git integration)
    Plug 'tpope/vim-fugitive'

    " LaTeX synctex synchronization through DBus
    Plug 'peterbjorgensen/sved'

    " Neovim specific plugins
    if has('nvim')
        " Good default LSP server configurations
        Plug 'neovim/nvim-lspconfig'

        " LSP installer helper, trigger with: 'LspInstall' or 'LspInstallInfo'
        Plug 'williamboman/nvim-lsp-installer'

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

        " GitHub Co-Pilot
        Plug 'github/copilot.vim'

        " local
        Plug 'rhysd/vim-grammarous'
    endif

    " NeoVim sudo read/write (:SudaRead, :SudaWrite)
    Plug 'lambdalisue/suda.vim'

    " Proper syntax highlighting when editing .tmux.conf
    Plug 'tmux-plugins/vim-tmux'

    " Fuzzy incsearch (<leader>/)
    Plug 'haya14busa/incsearch.vim'
    Plug 'haya14busa/incsearch-fuzzy.vim'

    " Maximize Vim splits
    Plug 'szw/vim-maximizer'

    " GoTo file manager (gof) or terminal (got)
    Plug 'justinmk/vim-gtfo'

    " TMux + Vim seamless pane/split jumping
    Plug 'christoomey/vim-tmux-navigator'
    

" Initialize plugin system
call plug#end()

" --------------------------------------------------------------------------------------------------------------------
" --                                                  Appearance                                                    --
" --------------------------------------------------------------------------------------------------------------------

" Gruvbox colorscheme settings - more info: https://github.com/morhetz/gruvbox/wiki/Configuration
let g:gruvbox_bold='1'
let g:gruvbox_italic='0'
let g:gruvbox_contrast_dark='hard'
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

" Use <Ctrl+c/x> to copy/cut test when in visual mode
vnoremap <C-c> "+y
vnoremap <C-x> "+d

" Use <Ctrl+s> to write when in normal mode
nnoremap <C-s> :w<CR> 

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
nnoremap <M-L> <C-W>L

" Create new splits (tmux-like)
nnoremap <M-i> :vsplit<CR>
nnoremap <M-u> :split<CR>

" UndoTree
nnoremap <leader>u :UndotreeToggle<CR>

" Vim Maximizer
nnoremap <M-f> :MaximizerToggle<CR>

" Redraw
nnoremap <leader>r :redraw!<CR>

" Jump forward and backward in VSnip snippets
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

" FZF files in '~/.dotfiles'
nnoremap <leader>.e :FZF ~/.dotfiles<CR>

" FZF incsearch
map <leader>/ <Plug>(incsearch-fuzzy-/)
map <leader>? <Plug>(incsearch-fuzzy-?)

" Scroll with <C-j/k> when searching
cnoremap <C-j> <C-g>
cnoremap <C-k> <C-t>

" --------------------------------------------------------------------------------------------------------------------
" --                                                     Misc                                                       --
" --------------------------------------------------------------------------------------------------------------------

set mouse=a                     " Enable all mouse functionality
set laststatus=2                " Always show the status line in the last window
set scrolloff=4                 " Always show four lines above and under cursorline
set backspace=indent,eol,start  " Insert mode backspace (and <C-W>) settings
set hlsearch                    " Highlight text on search
set hidden
set incsearch                   " Show searches in realtime
set signcolumn=no               " Extra linting column the the left (yes/no)
set cursorline                  " Highlight the row under the cursor
set nowrap                      " Don't wrap very long lines to next row

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


" Alias bd -> Bd (vim-bbye buffer delete)
cnoreabbrev bd Bd

" Minimap settings
let g:minimap_auto_start = 1

" --------------------------------------------------------------------------------------------------------------------
" --                                           LaTeX/spellchecking settings                                         --
" --------------------------------------------------------------------------------------------------------------------

" Newly open .tex-files are LaTeX
let g:tex_flavor='latex'

" Enable spellcheck for TeX files
autocmd FileType plaintex,tex,latex syntax spell toplevel
autocmd FileType plaintex,tex,latex set spell

" BUG: Re-sourcing .vimrc after initially loading a LaTeX file helps to spellcheck only non LaTeX 
"autocmd FileType plaintex,tex,latex :source ~/.vimrc

" Spellcheck keybindings <leader> + sn: next, sp: previous, sl: list, sa: add to dict, sr: remove from dict
nnoremap <leader>sn ]s
nnoremap <leader>sp [s
nnoremap <leader>sl z=
nnoremap <leader>sa zg
nnoremap <leader>sr zw

" Use system install of languagetool
let g:grammarous#languagetool_cmd = 'languagetool'

" --------------------------------------------------------------------------------------------------------------------
" --                                            LSP settings for NeoVim                                             --
" --------------------------------------------------------------------------------------------------------------------

if has('nvim')

set completeopt=menu,menuone,noselect
lua << EOF
    require('config/cmp')       -- CMP Autocompletion settings
    require('config/keybinds')  -- General LSP keybinds
EOF

" LSP config for servers installed with nvim-lsp-installer
lua << EOF
    local lsp_installer = require("nvim-lsp-installer")
    lsp_installer.on_server_ready(function(server)
        local opts = {
            capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
        }
        server:setup(opts)
    end)
EOF

" VHDL Language server with VHDL-Tool
lua << EOF
    local server_name = 'vhdl_tool'
    local configs = require 'lspconfig.configs'
    if configs[server_name] == nil then
        local util = require 'lspconfig.util'
        local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
        configs[server_name] = {
            default_config = {
                cmd = {'vhdl-tool', 'lsp'};
                filetypes = {'vhdl'};
                root_dir = util.root_pattern('vhdltool-config.yaml', '.git');
                settings = {};
            }
        }
        require'lspconfig'.vhdl_tool.setup{ capabilities = capabilities }
    end
EOF

" --------------------------------------------------------------------------------------------------------------------
" --                                              TreeSitter settings                                               --
" --------------------------------------------------------------------------------------------------------------------

lua <<EOF
require'nvim-treesitter.configs'.setup {
  -- One of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = "all",

  -- Install languages synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- List of parsers to ignore installing
  --ignore_install = { "javascript" },

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- list of language that will be disabled
    --disable = { "c", "rust" },

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF

endif "if has('nvim')

