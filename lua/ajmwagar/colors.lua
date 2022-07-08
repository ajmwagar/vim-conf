vim.cmd([[
" Colors {{{
" Fix colors in tmux
if !has('gui_running')
  " Font
  set guifont ="Knack Nerd Font"
  " Colors
  set termguicolors
  set t_Co=256
  let g:deus_termcolors=256
  let NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

set background=dark    " Setting dark mode
let g:deus_italics = 1
set fillchars+=vert:\ 
colorscheme deus
" }}}
]])
