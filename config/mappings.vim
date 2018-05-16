"Mappings {{{
" Open docs

nnoremap <silent> K :call ZealDoc()<CR>


function! ZealDoc()
  if expand('%:e') == 'py'
    execute "silent !zeal \"python: " . expand('<cword>') . "\"&\n\n"
  elseif expand('%:e') == 'rs'
    execute "silent !zeal \"rust: " . expand('<cword>') . "\"&\n\n"
  elseif expand('%:e') == 'js'
    execute "silent !zeal \"nodejs: " . expand('<cword>') . "\"&\n\n"
  elseif expand('%:e') == 'cs'
    execute "silent !zeal \"unity3d: " . expand('<cword>') . "\"&\n\n"
  elseif expand('%:e') != ''
    execute "silent !zeal \"" . expand('%:e') . ": " . expand('<cword>') . "\"&\n\n"

  else
    execute "silent !zeal \"" . expand('<cword>') . "\"&\n\n"
  endif
endfunction

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
" }}}
