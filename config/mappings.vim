"Mappings {{{
"Better Focus
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
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
