" Use sneak labeling mode, i.e., label sneak matches when performing a sneak
" operation
let g:sneak#label = 1

" Case insensitive sneaking
let g:sneak#use_ic_scs = 1

" Use <leader>s to sneak backwards

" 2-character Sneak (default)
nmap s <Plug>Sneak_s
nmap <leader>s <Plug>Sneak_S
" visual-mode
xmap s <Plug>Sneak_s
xmap <leader>s <Plug>Sneak_S

" operator-pending-mode
omap s <Plug>Sneak_s
omap <leader>s <Plug>Sneak_S
