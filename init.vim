" For a paranoia.
" Normally `:set nocp` is not needed, because it is done automatically
" when .vimrc is found.
if &compatible
  " `:set nocp` has many side effects. Therefore this should be done
  " only when 'compatible' is set.
  set nocompatible
endif

" Source config files
source ~/.config/nvim/config/plugins.vim " Handle Plugins with minpac
source ~/.config/nvim/config/editor.vim " Colorschemes/indentation
source ~/.config/nvim/config/mappings.vim " Shortcuts/mappings
