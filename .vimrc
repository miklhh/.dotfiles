" ------------------------------------------------------------------------------------ #
" --                                    Vim Plug                                    -- #
" ------------------------------------------------------------------------------------ #

call plug#begin('~/.vim/plugged')

    " Colorscheme
    Plug 'morhetz/gruvbox'
    Plug 'junegunn/seoul256.vim'

    " Get (Neo)Vim startup time with :StartupTime
    Plug 'dstein64/vim-startuptime'

    " LaTeX goodies
    Plug 'lervag/vimtex'

    " LaTeX synctex synchronization through DBus (for use with Evince)
    Plug 'peterbjorgensen/sved'

    " Vim surround
    Plug 'tpope/vim-surround'

    " Plugins specific to NeoVim starts here
    if has('nvim')

        " ``All the Lua function I don't want to write twice''
        Plug 'nvim-lua/plenary.nvim'

        " NeoVim dev-icons
        Plug 'nvim-tree/nvim-web-devicons'

        " Fuzzy-find more stuff with fzf-lua
        Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
        Plug 'ibhagwan/fzf-lua', { 'branch': 'main' }

        " Oil file manager
        Plug 'stevearc/oil.nvim'

        " Quickstart configs for Nvim LSP
        Plug 'neovim/nvim-lspconfig'

        " LSP server package manager Mason
        Plug 'williamboman/mason.nvim', { 'do': ':MasonUpdate' }
        Plug 'williamboman/mason-lspconfig.nvim'
        Plug 'mfussenegger/nvim-lint'

        " NeoVim tree file manager
        Plug 'nvim-tree/nvim-tree.lua'

        " LSP diagnostics highlight group for colorschemes that don't yet support them.
        " Prerequisite of folke/trouble.nvim.
        Plug 'folke/lsp-colors.nvim'

        " NeoVim LSP diagnostics trouble finder
        Plug 'folke/trouble.nvim'

        " Autocompletion engine
        Plug 'hrsh7th/cmp-nvim-lsp'
        Plug 'hrsh7th/cmp-nvim-lsp-document-symbol'
        Plug 'hrsh7th/cmp-buffer'
        Plug 'hrsh7th/cmp-path'
        Plug 'hrsh7th/cmp-cmdline'
        Plug 'hrsh7th/nvim-cmp'

        Plug 'saghen/blink.cmp', { 'tag': 'v0.11.0' }

        " Pictograms for NeoVim auto-completion
        Plug 'onsails/lspkind-nvim'

        " Snippet engine with snippet support for LSP-servers
        Plug 'hrsh7th/cmp-vsnip'
        Plug 'hrsh7th/vim-vsnip'
        Plug 'hrsh7th/vim-vsnip-integ'

        " LSP fidget spinner
        Plug 'j-hui/fidget.nvim'

        " TreeSitter syntax highlighting
        Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
        Plug 'nvim-treesitter/nvim-treesitter-context'
        Plug 'nvim-treesitter/playground'

        " NeoVims which-key
        Plug 'folke/which-key.nvim'

        " NeoVim sudo read/write (:SudaRead, :SudaWrite)
        Plug 'lambdalisue/suda.vim'

        " NeoVim runtime profiler
        Plug 'stevearc/profile.nvim'

    endif " -- End of NeoVim specific plugins

    " Jupyter Vim support
    "Plug 'jupyter-vim/jupyter-vim'

    " Colorizer
    Plug 'norcalli/nvim-colorizer.lua'

    " Numpy docstring generation
    Plug 'heavenshell/vim-pydocstring', { 'do': 'make install', 'for': 'python' }

" Initialize plugin system
call plug#end()


" ------------------------------------------------------------------------------------ #
" --                                      Misc                                      -- #
" ------------------------------------------------------------------------------------ #


" Cycle numbered registers when yanking. This allow the numbered registers to act like
" a ring buffer when performing the yank operation (just like delete already does!)
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

" FZF create new file quick-action (thank you Frans Skarman for this quickie) bound to
" <leader>E
function! FzfEditPrompt(file)
    let cmd = ':e ' . a:file . '/'
    call feedkeys(cmd)
endfunction
command! -nargs=1 FzfEditPrompt :call FzfEditPrompt(<f-args>)
map <leader>E :call fzf#run({'source': 'find . -type d -print', 'sink': 'FzfEditPrompt'})<CR>

" Newly open .tex-files are always LaTeX
let g:tex_flavor='latex'

" Vim-Tmux navigator settings
let g:tmux_navigator_disable_when_zoomed = 0
let g:tmux_navigator_preserve_zoom = 0

" ------------------------------------------------------------------------------------ #
" --                             LSP settings for NeoVim                            -- #
" ------------------------------------------------------------------------------------ #

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

