" init.vim - My take on Vim-configuration
" Author:       Carl Smedstad
" License:      MIT. Copyright (c) 2017 Carl Smedstad
" Last Change:  March 29, 2017
" URL:          https://github.com/carlsmedstad/dotfiles

let $MYVIMDIR = expand("~/.config/nvim")
let g:mapleader=","

" paths of plugins i'm developing
" set runtimepath+=$HOME/workspace/vimscript/vim-toggler
" set runtimepath+=$HOME/workspace/vimscript/vim-sourcer
" set runtimepath+=$HOME/workspace/vimscript/vim-sessions

" Plugins: -------------------------------------------------------------{{{
if filereadable($MYVIMDIR."/autoload/plug.vim")

  call plug#begin($MYVIMDIR."/plugged")

  Plug 'tpope/vim-sensible'        " barebones init-file
  Plug 'tpope/vim-commentary'      " mappings for commenting code
  Plug 'tpope/vim-surround'        " mappings for paranthesis, brackets etc.
  Plug 'tpope/vim-repeat'          " make . work for plugins
  Plug 'farmergreg/vim-lastplace'  " save cursor pos between sessions

  Plug 'vim-airline/vim-airline'          " fancier statusline
  Plug 'vim-airline/vim-airline-themes'   " themes for the above
  Plug 'altercation/vim-colors-solarized' " colorscheme

  Plug 'sheerun/vim-polyglot'      " a bunch of language packs
  Plug 'ynkdir/vim-vimlparser'     " parser for vimscript
  Plug 'syngan/vim-vimlint'        " lint for vimscript
  Plug 'vim-syntastic/syntastic'   " syntax checker

  Plug 'carlsmedstad/vim-sourcer'  " commands for sourcing vimfiles
  Plug 'carlsmedstad/vim-sessions' " lightweight session manager

  call plug#end()

  " Solarized: ---------------------------------------------------------{{{
  if (index(keys(g:plugs), "vim-colors-solarized") >= 0)
        \ && (&t_Co > 2 || has("gui_running"))
    syntax on
    set background=dark
    colorscheme solarized
    hi SignColumn ctermbg=8
    hi Normal ctermbg=none
    let g:airline_theme='solarized'
  endif " --------------------------------------------------------------}}}

  " Airline: -----------------------------------------------------------{{{
  if index(keys(g:plugs), "vim-airline") >= 0
    if !empty($DISPLAY)
      let g:airline_powerline_fonts = 1
    else
      let g:airline_symbols_ascii = 1
    endif

    " enables airlines built-in tabline
    let g:airline#extensions#tabline#enabled = 1

    " remove encoding section
    let g:airline_section_y = ''

    " Minimal line and column number section
    let g:airline_section_z = '%3p%% %4l:%3v'
  endif " --------------------------------------------------------------}}}

  " Syntastic: ---------------------------------------------------------{{{
  if index(keys(g:plugs), "syntastic") >= 0
    " defaults recommended by the plugin author
    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_check_on_open = 1
    let g:syntastic_check_on_wq = 0

    " use validator as html-checker, w3 was super-slow for some reason
    let g:syntastic_html_checkers = ["validator"]

    " Some vimlint errors that are either wrong or inconvenient
    let g:syntastic_vim_vimlint_quiet_messages = { "regex" : "tnoremap" }
  endif " --------------------------------------------------------------}}}

  " Sourcer: -----------------------------------------------------------{{{
  if index(keys(g:plugs), "vim-sourcer") >= 0
    nnoremap <silent><Leader>s :Source<CR>
    nnoremap <silent><Leader><S-s> :SourceBufs<CR>
  endif " --------------------------------------------------------------}}}

endif " filereadable($MYVIMDIR."/autoload/plug.vim") -------------------}}}

" Options: -------------------------------------------------------------{{{
set title titlestring=%t   " set X-window title to name of active file
set clipboard=unnamedplus  " enables copy/paste from/to vim
set undofile               " saves undo-history between sessions

set hidden                 " buffer stays open when window is closed
set noequalalways          " splitting won't default to a 50/50 ratio

set sessionoptions-=tabpages " only save current tab in session
set sessionoptions-=help   " don't save help windows in session

set autoindent smartindent " autoindenting when starting a new line
set wildmode=longest,full  " tab-completion
set ignorecase smartcase   " ignore case except if uppercase in search phrase

set foldenable             " folds enabled by default
set foldmethod=marker      " define folds in code with {{{}}}

set number numberwidth=5   " line-number-bar, with width = 3 digits + padding
set cursorline             " highlight the line under the cursor
set colorcolumn=+1,+3      " highlighted columns to show too long lines

set wrap                   " don't wrap lines too long for window
set list                   " show symbols in listchars instead of some chars
set showbreak=↪\           " symbol before continuation of wrapped line
set listchars=tab:→\ ,nbsp:␣,trail:•,extends:⟩,precedes:⟨
" set listchars+=eol:↲     " show at every newline, too messy imo
" ----------------------------------------------------------------------}}}

" Autocommands: --------------------------------------------------------{{{
" set options for different filetypes
augroup fileTypes
  autocmd!
  autocmd FileType vim set et sw=2
  autocmd FileType sh,xdefaults,i3,html,markdown set et tw=80 sw=2
  autocmd FileType java set tw=80 sw=4
  autocmd FileType c set et sw=4
augroup END

" use current file's dir as working dir, except in some special cases
augroup workingDir
  autocmd!
  autocmd BufEnter * silent! lcd %:p:h
  autocmd BufEnter ~/workspace/vimscript/*/* silent! lcd %:p:h:h
augroup END
" ----------------------------------------------------------------------}}}

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
let g:term_open = 0
augroup terminalEmulator
  au!
  autocmd BufEnter term://* startinsert
  autocmd TermOpen * let g:term_open += 1
  autocmd TermClose * let g:term_open -= 1
augroup END

" Mappings: ------------------------------------------------------------{{{
" Vim help on word under cursor
nnoremap <C-\> :h <C-r><C-w><CR>

" bufswitch remaps for consistency with vimium
nnoremap <C-j> <S-j>
nnoremap <C-k> <S-k>
nnoremap <silent><S-j> :bprev<CR>
nnoremap <silent><S-k> :bnext<CR>

" traverse syntax-checker errors and toggle location list
nnoremap <silent><A-S-j> :lnext<CR>
nnoremap <silent><A-S-k> :lprev<CR>
nnoremap <silent><Leader><S-e> :call Toggler('A-e', 'lopen <Bar> wincmd k', 'wincmd x <Bar> lclose')<CR>

" insert one character without leaving normal-mode
nnoremap <silent><Space> :exec "normal i".nr2char(getchar())<CR>
nnoremap <silent><S-Space> :exec "normal a".nr2char(getchar())<CR>

" delete trailing whitespaces
nnoremap <silent><Leader><S-t> :%s/\s\+$//e<CR>

" attempt to enable GNU readline mappings
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-a> <C-b>
cnoremap <C-d> <Del>
cnoremap <C-y> <C-r>"<BS>
cnoremap <C-o> <C-f>

" Windows
tnoremap <Esc> <C-\><C-n>
tnoremap <A-w> <C-\><C-n><C-w>w
tnoremap <A-q> <C-\><C-n><C-w>q
tnoremap <A-o> <C-\><C-n><C-w>o
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
nnoremap <A-w> <C-w>w
nnoremap <A-q> <C-w>q
nnoremap <A-o> <C-w>o
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l
" ----------------------------------------------------------------------}}}
