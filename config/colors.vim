" Avery Wagar
" Vim Config


" Colors {{{

set t_Co=256

set termguicolors
" Fix colors in tmux
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

set background=dark    " Setting dark mode
"set background=light    " Setting light mode
set fillchars+=vert:\ 
colorscheme deus
let g:deus_termcolors=256
let NVIM_TUI_ENABLE_TRUE_COLOR=1

if has("gui_running")
	set guifont ="DejaVuSansMono Nerd Font Complete Mono:h11"
endif

" }}}
