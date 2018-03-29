" Avery Wagar


" Functional Config {{{
set nocompatible
filetype off
" Turn on syntax highlighting
syntax on


"  Pick a leader key
let mapleader = ";"

" Security
set modelines=1

"Open in folder
cd ~/usr/dev/

" Folding
set foldmethod=marker
set foldlevel=0
"
"Show line number
set number
set relativenumber

" Show file stats
set ruler

" Blink cursor on error instead of beeping (grr)
set noerrorbells

" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf8,prc

" Whitespace
set wrap " Wrap lines
set linebreak " Wraps lines a words
set breakindent " Consistent indent of wrapped linex
set textwidth=100 " Wrap at 100 chars
" set formatoptions=tcqrn1
set expandtab " Use spaces instead of tan
set softtabstop=2 " Number of spaces per tab
set shiftwidth=2   " Number of auto indent spaces
set autoindent " Auto indent
set noshiftround " Indent lines by 2 not by nearest mutiple of two

" Cursor motion
set scrolloff=3
set backspace=indent,eol,start " Use backspace in insert mode

" Different Cursor shape in tmux 
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" Allow hidden buffers
set hidden

" Rendering
set ttyfast

" Status bar
set laststatus=2

" Last line
set noshowmode
set noshowcmd

" Searching
set hlsearch "  Highlight all search results
set incsearch " Searches the string incrementaly
set smartcase " Enable smart case 
set ignorecase " Always case-insensitive
set showmatch " Highlight matching brace


filetype plugin indent on


"Spell checking for spefic files
autocmd FileType md,markdown,txt, setlocal spell
" autocmd FileType md,markdown Dispatch instant-markdown-d

autocmd FileType js,jsx :Dispatch tern

"Make vim more natural
set history=100
set splitbelow
set splitright


" }}}
