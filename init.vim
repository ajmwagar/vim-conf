" For a paranoia.
" Normally `:set nocp` is not needed, because it is done automatically
" when .vimrc is found.
if &compatible
  " `:set nocp` has many side effects. Therefore this should be done
  " only when 'compatible' is set.
  set nocompatible
endif

" Begone default plugins
let g:loaded_matchit = 1
let g:loaded_gzip = 1
let g:loaded_zipPlugin = 1
let g:loaded_logipat = 1
let g:loaded_2html_plugin = 1
let g:loaded_rrhelper = 1
let g:loaded_getscriptPlugin = 1
let g:loaded_tarPlugin = 1


" Source config files
source ~/.config/nvim/config/plugins.vim " Handle Plugins with minpac
source ~/.config/nvim/config/editor.vim " Colorschemes/indentation
source ~/.config/nvim/config/mappings.vim " Shortcuts/mappings

