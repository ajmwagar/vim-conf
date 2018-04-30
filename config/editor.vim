" Avery Wagar
" Functional Config {{{
" set shortmess=I " Read :help shortmess for everything else.
set nocompatible
filetype off
" Turn on syntax highlighting
syntax on
" Begone swapfiles
set directory^=$HOME/.config/nvim/tmp//
"  Pick a leader key
let mapleader = ";"
" Security
set modelines=1
"Open in folder
cd ~/usr/dev/
" Folding
set foldmethod=marker
set foldlevel=0
"Show line number
set number
set relativenumber

" Whitespace
set wrap " Wrap lines
set linebreak " Wraps lines a words
set breakindent " Consistent indent of wrapped linex
set textwidth=100 " Wrap at 100 chars
set expandtab " Use spaces instead of tan
set softtabstop=2 " Number of spaces per tab
set shiftwidth=2   " Number of auto indent spaces
set autoindent " Auto indent
set noshiftround " Indent lines by 2 not by nearest mutiple of two

" Netrw
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_browse_split = 4
let g:netrw_winsize = 15
let g:netrw_altv = 1
let g:netrw_preview=1           " open previews vertically

" Toggle Vexplore with leader-t
function! ToggleVExplorer()
  if exists("t:expl_buf_num")
      let expl_win_num = bufwinnr(t:expl_buf_num)
      if expl_win_num != -1
          let cur_win_nr = winnr()
          exec expl_win_num . 'wincmd w'
          close
          exec cur_win_nr . 'wincmd w'
          unlet t:expl_buf_num
      else
          unlet t:expl_buf_num
      endif
  else
      exec '1wincmd w'
      Vexplore
      let t:expl_buf_num = bufnr("%")
  endif
endfunction
map <silent> <leader>t :call ToggleVExplorer()<CR>


" Cursor motion
set backspace=indent,eol,start " Use backspace in insert mode

" Different Cursor shape in tmux 
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

set hidden " Allow hidden buffers
set ttyfast " Rendering

" Searching
set hlsearch "  Highlight all search results
set incsearch " Searches the string incrementaly
set smartcase " Enable smart case 
set ignorecase " Always case-insensitive
set showmatch " Highlight matching brace

filetype plugin indent on

"Spell checking for spefic files
autocmd FileType md,markdown,txt, setlocal spell

"Make vim more natural
set splitbelow
set splitright

" augroup numbertoggle
"   autocmd!

"   augroup numbertoggle
"     autocmd!
"     autocmd BufEnter,FocusGained,WinEnter * if &nu | set rnu   | endif
"     autocmd BufEnter,FocusGained,WinEnter * if &nu | :SignifyEnable | endif
"     autocmd BufLeave,FocusLost,WinLeave   * if &nu | set nornu | endif
"     autocmd BufLeave,FocusLost,WinLeave   * if &nu | :SignifyDisable | endif
"   augroup END

  " }}}
" Colors {{{
set t_Co=256

set termguicolors
" Fix colors in tmux
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"

set background=dark    " Setting dark mode
"set background=light    " Setting light mode
set fillchars+=vert:\ 
let g:deus_termcolors=256
let NVIM_TUI_ENABLE_TRUE_COLOR=1
let g:deus_italics = 1
colorscheme deus

if has("gui_running")
	set guifont ="DejaVuSansMono Nerd Font Complete Mono:h11"
endif

" }}}
