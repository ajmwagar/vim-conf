vim.cmd([[
" Persistent undo: {{{
if exists("+undofile")
  " undofile - This allows you to use undos after exiting and restarting
  " This, like swap and backup files, uses .vim-undo first, then ~/.vim/undo
  " :help undo-persistence
  " This is only present in 7.3+
  if isdirectory($HOME . '/.config/nvim/undo') == 0
    :silent !mkdir -p ~/.config/nvim/undo > /dev/null 2>&1
  endif
  set undodir=./.vim-undo// " Set undodir
  set undodir+=~/.config/nvim/undo//
  set undofile " Create undofiles
endif

" Begone swapfiles
set directory^=$HOME/.config/nvim/tmp// " Disable swapfiles
" }}}
]])
