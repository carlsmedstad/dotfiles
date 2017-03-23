" Vim Init - My take on Vim-configuration
" Maintainer:   Carl Smedstad
" Version:      0.1
"
" The MIT License (MIT)
"
" Copyright (C) 2017 Carl Smedstad
"
" Permission is hereby granted, free of charge, to any person obtaining
" a copy of this software and associated documentation files (the "Software"),
" to deal in the Software without restriction, including without limitation
" the rights to use, copy, modify, merge, publish, distribute, sublicense,
" and/or sell copies of the Software, and to permit persons to whom the
" Software is furnished to do so, subject to the following conditions:
"
" The above copyright notice and this permission notice shall be included
" in all copies or substantial portions of the Software.
"
" THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
" EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
" OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
" IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
" DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
" TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
" OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

let $MYVIMDIR = expand('~/.config/nvim')

" paths of plugins i'm currently developing
"set runtimepath+=$HOME/workspace/vimscript/vim-toggler

" Plugins: --------------------------------------------------------{{{
" only calls plug (my plugin manager of choice) if it's installed
if filereadable($MYVIMDIR.'/autoload/plug.vim')
  call plug#begin($MYVIMDIR.'/plugged')
  " a sensible, barebones init-file to start off with
  Plug 'tpope/vim-sensible'

  " adds quick-comment bindings
  Plug 'tpope/vim-commentary'

  " saves cursor position between sessions
  Plug 'farmergreg/vim-lastplace'

  " a fancier statusline and accompanying themes
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'

  " a bunch of language packs
  Plug 'sheerun/vim-polyglot'

  " parser and lint for vimscript, used with syntastic
  Plug 'ynkdir/vim-vimlparser'
  Plug 'syngan/vim-vimlint'

  " syntax checker
  Plug 'vim-syntastic/syntastic'

  " autocomplete code while in insert-mode
  Plug 'Valloric/YouCompleteMe'

  " file explorer
  Plug 'scrooloose/nerdtree'

  " my own little plugin, easy vimscript sourcing
  Plug 'carlsmedstad/vim-sourcer'
  call plug#end()
endif

" Airline: -------------------------------------------------------------{{{
" only run if plugin airline is loaded by plug
if index(keys(g:plugs), 'vim-airline') > 0
  " this is a hack that disables powerline fonts where I don't
  " have them, for example in a tty where X isn't running
  if $TERM =~ 256
    let g:airline_powerline_fonts=1
  endif

  " enables airlines built-in tabline
  let g:airline#extensions#tabline#enabled = 1

  " removes encoding section, got tired of seeing [Unix]UTF-8 all the time
  let g:airline_section_y = ''

  " unfinished tweaks to airlines other sections, the goal is to
  " customize them for buffers containing terminals or locations
  " lists where a lot of the information is redundant
  let g:airline_section_z = '%3p%% %{g:airline_symbols.linenr}%4l:%3v'
  let g:airline_section_c = '%<%{GetName()}%{IsModified()} %#__accent_red#'
        \ .'%{airline#util#wrap(airline#parts#readonly(),0)}%#__restore__#'
endif
" ----------------------------------------------------------------------}}}

" Syntastic: -----------------------------------------------------------{{{
if index(keys(g:plugs), 'syntastic') > 0
  " some defaults recommended by the plugin author, pretty self-explanatory
  let g:syntastic_always_populate_loc_list = 1
  let g:syntastic_check_on_open = 1
  let g:syntastic_check_on_wq = 0

  " use validator as html-checker, w3 was super-slow for some reason
  let g:syntastic_html_checkers = ['validator']

  " vimlint doesn't recognize NeoVim's commands and shows them as errors,
  " this quiets the wrong error messages I've encountered so far
  let g:syntastic_vim_vimlint_quiet_messages = { 'regex' : 'tnoremap' }
endif
" ----------------------------------------------------------------------}}}
" -----------------------------------------------------------------}}}


" WIP! UNFINISHED
" For cleaner statusline in terminal emulator
function! GetName()
  if expand('%') =~ 'term://'
    return b:term_title
  else
    return expand('%:t')
  endif
endfunction
function! IsModified()
  if and(expand('%') !~ 'term://', &modified == 1)
    return '[+]'
  elseif expand('%') =~ 'term://'
    return '['.bufnr('%').']'
  else
    return ''
  endif
endfunction


" ColorScheme: ----------------------------------------------------{{{
" only change colorscheme operating in gui or terminal supports colors
if &t_Co > 2 || has("gui_running")
  " change colorscheme to "solarized" if available, also
  " change some left-over colors not changed by the scheme
  try
    colorscheme solarized
    set background=dark
    hi SignColumn ctermbg=8
    let g:airline_theme='solarized'
  catch /.*/
  endtry
endif
" -----------------------------------------------------------------}}}


" Options: --------------------------------------------------------{{{
" set X window title to name of active file
set title titlestring=%t

" use X clipboard, enables copy/paste from vim to outside and vice versa
set clipboard=unnamedplus

" search ignores case except if uppercase is used in search phrase
set ignorecase smartcase

" enable undofile, saves undo-history between sessions
set undofile

" when a window is closed the buffer stays open
set hidden

" splitting won't default to a 50/50 ratio
set noequalalways

" do smart autoindenting when starting a new line
set smartindent

" no folds enabled by default and define folds in code by: {{{}}}
set nofoldenable foldmethod=marker

" tab-completion: will complete longest unique, then traverse all matching
set wildmode=longest,full

" enable line-number-bar and set min-width to 5, i.e. 3 digits + padding
set number numberwidth=5

" highlight the line under the cursor
set cursorline

" highlighted columns at "textwidth" to show too long lines
set colorcolumn=+1,+3

" don't wrap lines too long for the window by default
set nowrap

" use list and use symbols in listchars, e.g. • for trailing whitespace
set list showbreak=↪\  listchars=tab:→\ ,nbsp:␣,trail:•,extends:⟩,precedes:⟨

" this makes every newline a ↲ symbol, turned off atm, too messy
" set listchars+=eol:↲
" -----------------------------------------------------------------}}}


" Autocommands: ---------------------------------------------------{{{
" set options for different filetypes
augroup fileTypes
  autocmd!
  autocmd FileType vim set expandtab sw=2
  autocmd FileType html set tw=80 et sw=2
  autocmd FileType java set tw=80 sw=4
  autocmd FileType markdown set tw=80
  autocmd FileType help set nolist
augroup END

" dynamically change width of number-line-bar depending on filesize
augroup numberWidth
  autocmd!
  autocmd WinEnter,BufEnter * if line('$') < 100
        \ | setlocal numberwidth=4 | endif
augroup END

" use current files dir as working dir, except in some special cases
augroup workingDir
  autocmd!
  autocmd BufEnter * silent! lcd %:p:h
  autocmd BufEnter ~/workspace/vimscript* silent! lcd %:p:h:h
augroup END
" -----------------------------------------------------------------}}}


" WIP! UNFINISHED
" Toggler function I wrote to enable some mappings
let g:toggler_dict = {}
function! Toggler(name, doif, doelse)
  if get(g:toggler_dict, a:name, 0) == 0
    let g:toggler_dict[a:name] = 1
    exec a:doif
  else
    let g:toggler_dict[a:name] = 0
    exec a:doelse
  endif
endfunction

" WIP! UNFINISHED
nnoremap <silent><Leader>t :bo 10split +terminal <Bar> setlocal nobuflisted<CR>
hi TermCursor cterm=underline ctermfg=None ctermbg=None
let g:term_open = 0
augroup terminalEmulator
  au!
  autocmd BufEnter term://* startinsert
  autocmd TermOpen * let g:term_open += 1
  autocmd TermClose * let g:term_open -= 1
augroup END


" Mappings: -------------------------------------------------------{{{
let g:mapleader=","

" source or open vim-files
nnoremap <silent><Leader>i :source $MYVIMRC<CR>
nnoremap <silent><Leader><S-i> :e $MYVIMRC<CR>
nnoremap <silent><Leader>s :SourceBufs<CR>
nnoremap <silent><Leader>n :e $HOME/documents/vim.txt<CR>

" Vim help on word under cursor
nnoremap <C-\> :h <C-r><C-w><CR>

" tabswitch remaps for consistency with vimium
nnoremap <C-j> <S-j>
nnoremap <C-k> <S-k>
nnoremap <silent><S-j> :bprev<CR>
nnoremap <silent><S-k> :bnext<CR>

" traverse paragraphs
nnoremap <A-j> }
nnoremap <A-k> {

" traverse syntax-checker errors and toggle location list
nnoremap <silent><A-S-j> :lnext<CR>
nnoremap <silent><A-S-k> :lprev<CR>
nnoremap <silent><A-e> :call Toggler('A-e', 'lopen <Bar> wincmd k', 'wincmd x <Bar> lclose')<CR>

" insert one character without leaving normal-mode
nnoremap <silent><Space> :exec "normal i".nr2char(getchar())<CR>
nnoremap <silent><S-Space> :exec "normal a".nr2char(getchar())<CR>

" delete trailing whitespaces
nnoremap <silent><A-l> :%s/\s\+$//e<CR>

" enable some common Ctrl mappings in command line
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-a> <C-b>
cnoremap <C-d> <Del>
cnoremap <C-y> <C-r>"<BS>
cnoremap <C-o> <C-f>

" terminal
tnoremap <Esc> <C-\><C-n>
tnoremap <C-w><C-w> <C-\><C-n><C-w><C-w>
tnoremap <C-w><C-q> <C-\><C-n><C-w><C-q>
" -----------------------------------------------------------------}}}
