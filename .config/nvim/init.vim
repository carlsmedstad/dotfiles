" init.vim - My take on Vim-configuration
" Author:       Carl Smedstad
" Last Change:  Mars 16, 2018
" URL:          https://github.com/carlsmedstad/dotfiles

let g:mapleader=','


call plug#begin('~/.local/share/nvim/plugged')

Plug 'tpope/vim-sensible'       " barebones init-file
Plug 'tpope/vim-commentary'     " mappings for commenting code
Plug 'tpope/vim-surround'       " mappings for paranthesis, brackets etc.
Plug 'tpope/vim-repeat'         " make . work for plugins
Plug 'farmergreg/vim-lastplace' " save cursor pos between sessions

Plug 'vim-airline/vim-airline'          " fancier statusline
Plug 'vim-airline/vim-airline-themes'   " themes for the above
Plug 'altercation/vim-colors-solarized' " colorscheme

Plug 'w0rp/ale'                         " async syntax checker
Plug 'Vimjas/vim-python-pep8-indent'    " PEP8 auto-indentation
Plug 'craigemery/vim-autotag'           " ctags auto-generation

Plug 'alvan/vim-closetag'               " closing html tags
Plug 'JulesWang/css.vim'                " css3 syntax

Plug 'carlsmedstad/vim-sourcer' " commands for sourcing vimfiles

call plug#end()

  if (index(keys(g:plugs), 'vim-colors-solarized') >= 0)
        \ && (&t_Co > 2 || has('gui_running'))
    syntax on
    set background=dark
    colorscheme solarized
    hi SignColumn ctermbg=8
    hi Normal ctermbg=none
    let g:airline_theme='solarized'
  endif

  if index(keys(g:plugs), 'vim-airline') >= 0
    if !empty($DISPLAY)
      let g:airline_powerline_fonts = 1
    else
      let g:airline_symbols_ascii = 1
    endif
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#ale#enabled = 1
    let g:airline_section_y = ''               " remove encoding section
    let g:airline_section_z = '%3p%% %4l:%3v'  " line/column number section
  endif

  if index(keys(g:plugs), 'ale') >= 0
    let g:ale_linters = {'python': ['pylint', 'flake8']}
    " let g:ale_lint_on_enter = 0
  endif

  if index(keys(g:plugs), 'vim-autotag') >= 0
    let g:autotagTagsFile='.tags'
  endif


set title titlestring=%t   " set X-window title to name of active file
set clipboard=unnamedplus  " enables copy/paste from/to vim
set undofile               " saves undo-history between sessions
set mouse=a                " Enable scrolling with mouse-wheel

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
set et tw=80 sw=2 ts=4

set tags=./.tags;/         " look for tags file from pwd to root


augroup languageSpecific   " set options for different languages
  autocmd!
  autocmd FileType python,java,sql set tw=80 sw=4
  autocmd FileType c set et tw=0 sw=4
augroup END

augroup workingDir  " use current file's dir as working dir
  autocmd!
  autocmd BufEnter * silent! lcd %:p:h
augroup END


" bufswitch remaps for consistency with vimium
nnoremap <C-j> <S-j>
nnoremap <C-k> <S-k>
nnoremap <silent><S-j> :bprev<CR>
nnoremap <silent><S-k> :bnext<CR>

" move through display lines instead of actual lines
nnoremap <expr> j v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj'
nnoremap <expr> k v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk'

" walk through errors
nnoremap <C-n> :lnext<CR>
nnoremap <C-m> :lprev<CR>

" delete trailing whitespaces
nnoremap <silent><Leader><S-t> :%s/\s\+$//e<CR>

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
