# vim-conf
📓 My (neo)vim files...

## Plugins
- `coc.nvim`: LSP integration and autocomplete
- [`vim-deus`](https://github.com/ajmwagar/vim-deus): my custom colorscheme
- `ALE`: Async. Linting Engine
- `lightline`: A nice looking statusline and bufferline
- `vim-polyglot`: The best syntax pack in the west
- `vim-fugitive`: Git integration
- `ack` and `fzf` + `ripgrep` = Very fast fuzzy searching

## Installation

### Neovim
1. `git clone https://github.com/ajmwagar/vim-conf.git ~/.config/nvim`
2. `nvim`
3. `:PackUpdate`
### Vim 8
1. `git clone https://github.com/ajmwagar/vim-conf.git ~/.vim`
2. `mv ~/.vim/init.vim ~/.vimrc`
3. `vim`
4. `:PackUpdate`

## Lisp

`lua/ajmwagar/lisp.lua` wires up syntax (bundled `lisp` syntax, plus the
tree-sitter `commonlisp` parser when it is installed; `*.lisp`, `*.cl`, `*.lsp`,
`*.asd`, `*.ros`, `*.soil`, `*.bel` and the usual Lisp rc files are treated as
Lisp) and a small REPL/runner
with no plugin dependencies. It probes `sbcl`, `clisp`, `ecl`, `ccl`, `ros`,
`guile`, `racket`, `csi` and `gosh`, and picks the one matching the buffer's
filetype.

```
:Lisp              toggle the REPL
:Lisp repl [impl]  open the REPL (force an implementation, e.g. `:Lisp repl ecl`)
:Lisp eval         send the enclosing top-level form, or the visual range
:Lisp buffer       load the current file into the REPL
:Lisp run [file]   run the file as a script, output in a scratch split
:Lisp stop         kill the REPL
:Lisp info         show detected/installed implementations
```

Buffer-local maps in `lisp`, `scheme`, `racket` files: `<leader>lr` REPL,
`<leader>le` eval form/selection, `<leader>lb` load buffer, `<leader>lf` run
file, `<leader>ls` stop REPL.

Run `:Lisp info` if it cannot find an implementation; on macOS the quickest
fix is `brew install sbcl`.

## Themes

Besides `vim-deus`, these are installed: `catppuccin` (+ variants), `tokyonight`,
`kanagawa`, `gruvbox`, `rose-pine` (pinned `catppuccin/nvim` to `v1.9.0`; newer
tags require `vim.pack` from Neovim 0.13). All built-in Neovim schemes are
available too.

```
:Theme            # fuzzy picker (telescope). Opens on deus; typing filters,
                  #   moving previews live, Enter applies+remembers, Esc restores.
:Theme tokyonight # apply directly
:Theme list       # print everything installed
<leader>tt        # same as :Theme
```

If telescope is unavailable the old floating list is used instead.

The confirmed choice is saved to `stdpath("state")/colorscheme` and restored on
startup. `galaxyline` keeps its own fixed palette, so the statusline does not
recolor with the scheme.
