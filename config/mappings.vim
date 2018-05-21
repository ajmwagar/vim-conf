"Mappings {{{
command! W :w suda://%<CR> " Write in sudo


" Open docs
nnoremap <silent> K :call ZealDoc()<CR>
function! ZealDoc()
  echo 'Opening Zeal...'
  if expand('%:e') == 'py'
    execute "silent !zeal \"python: " . expand('<cword>') . "\"\n\n > /dev/null" 
  elseif expand('%:e') == 'rs'
    execute "silent !zeal \"rust: " . expand('<cword>') . "\"\n\n > /dev/null"
  elseif expand('%:e') == 'js'
    execute "silent !zeal \"nodejs: " . expand('<cword>') . "\"\n\n > /dev/null"
  elseif expand('%:e') == 'css'
    execute "silent !zeal \"css: " . expand('<cword>') . "\"\n\n > /dev/null"
    echo 'hi'
  elseif expand('%:e') == 'cs'
    execute "silent !zeal \"unity3d: " . expand('<cword>') . "\"\n\n > /dev/null"
  elseif expand('%:e') != ''
    execute "silent !zeal \"" . expand('%:e') . ": " . expand('<cword>') . "\"\n\n > /dev/null"

  else
    execute "silent !zeal \"" . expand('<cword>') . "\"\n\n /dev/null"
  endif
endfunction

"Better Focus
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

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
nnoremap <silent><leader>z :Goyo<return>
nnoremap Q <nop>
autocmd VimEnter,BufEnter,BufWinEnter * silent! iunmap <buffer> <M-">

" }}}
