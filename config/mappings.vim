"Mappings {{{
"
command! W :w suda://%<CR> " Write in sudo

" Open docs
nnoremap <silent> K :call ZealDoc()<CR>

function! ZealDoc()
  echo 'Opening Zeal...'
  if expand('%:e') == 'js'
    execute "silent !zeal \"nodejs: " . expand('<cword>') . "\" > /dev/null \n\n"
  elseif expand('%:e') == 'cs'
    execute "silent !zeal \"unity3d: " . expand('<cword>') . "\" > /dev/null \n\n"
  else
    execute "silent !zeal \"" . &filetype . ": " . expand('<cword>') . "\" > /dev/null \n\n"
  endif
endfunction

"Better Focus
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Don't lose selection when shifting sidewards
xnoremap <  <gv
xnoremap >  >gv

" Switching Buffers
noremap <leader>[ :bp<return>
noremap <leader>] :bn<return>

"Find and replace
map <leader>fr :%s///g<left><left>
map <leader>frl :s///g<left><left>
map <silent><leader><space> :let @/=''<cr> " clear search

" Move up/down editor lines
nnoremap <silent> j gj
nnoremap <silent> k gk

"Goyo
nnoremap <silent><leader>z :GoyoStart<return>

" Disable ex-mode 
nnoremap Q <nop> 

" }}}
