" Use Sneak labeling mode, i.e., label sneak matches when performing a sneak
" operation
let g:sneak#label = 1

" Only exit Sneak labeling mode using <Esc> (not <Space> as is default).
let g:sneak#label_esc = "\<Esc>"

" Case insensitive sneaking
let g:sneak#use_ic_scs = 1

" Sneak keybinding: normal-mode
nmap s <Plug>Sneak_s
nmap <leader>s <Plug>Sneak_S
" Sneak keybinding: visual-mode
xmap s <Plug>Sneak_s
xmap <leader>s <Plug>Sneak_S
" Sneak keybinding: operator-pending-mode
omap s <Plug>Sneak_s
omap <leader>s <Plug>Sneak_S

" The set of keys available as labels when sneaking around. Ultimatly, these
" labels should:
" 1. Be fast (think home row) and easy to use for the keyboard and keyboard
"    layout at hand.
" 2. Not interfear with actions that are common to use *after* a sneak action
"    has been performed. This since labeling mode fallthrough can save one
"    extra keystroke
let g:sneak#target_labels = "fs,.mönMLÖNFSqtuRGHQZT"

