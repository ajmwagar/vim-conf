"Mappings {{{
"Netrw
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
map <leader><space> :let @/=''<cr> " clear search
"Loc List
" map <leader>e :copen<CR>
" map <leader>w :cclose<CR>
" Move up/down editor lines
nnoremap j gj
nnoremap k gk
"Goyo
nnoremap <leader>z :Goyo<return>

" Fuzzy find symbol
nnoremap <c-s> :call LanguageClient_textDocument_documentSymnol
" }}}
