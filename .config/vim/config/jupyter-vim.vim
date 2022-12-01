" Run current file
nnoremap <leader>jr :JupyterRunFile<CR>
nnoremap <leader>ji :PythonImportThisFile<CR>

" Change to directory of current file
nnoremap <leader>jd :JupyterCd %:p:h<CR>

" Send a selection of lines
nnoremap <leader>jx :JupyterSendCell<CR>
nnoremap <leader>je :JupyterSendRange<CR>
nmap     <leader>jt <Plug>JupyterRunTextObj
vmap     <leader>jv <Plug>JupyterRunVisual

" Debugging maps
nnoremap <leader>jb :PythonSetBreak<CR>
