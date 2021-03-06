scriptencoding utf-8

let g:mapleader=','

call plug#begin('~/.local/share/nvim/plugged')

Plug 'tpope/vim-commentary'     " mappings for commenting code
Plug 'tpope/vim-fugitive'       " git plugin
Plug 'tpope/vim-surround'       " mappings for paranthesis, brackets etc.
Plug 'tpope/vim-repeat'         " make . work for plugins
Plug 'farmergreg/vim-lastplace' " save cursor pos between sessions

Plug 'vim-airline/vim-airline'          " fancier statusline
Plug 'vim-airline/vim-airline-themes'   " themes for the above
Plug 'lifepillar/vim-solarized8'        " colorscheme

Plug 'w0rp/ale'                         " async syntax checker
Plug 'craigemery/vim-autotag'           " ctags auto-generation

Plug 'tbastos/vim-lua'                  " better lua
Plug 'Vimjas/vim-python-pep8-indent'    " better python indentation
Plug 'rust-lang/rust.vim'
Plug 'PProvost/vim-ps1'
Plug 'keith/swift.vim'
Plug 'tpope/vim-markdown'               " Syntax highlighting for code blocks
Plug 'mustache/vim-mustache-handlebars' " Syntax highlighting for Go templates
Plug 'cespare/vim-toml'
Plug 'ekalinin/Dockerfile.vim'

Plug 'mhinz/vim-signify'              " VCS info
Plug 'editorconfig/editorconfig-vim'  " Editorconfig support

call plug#end()

if ($COLORTERM ==# 'truecolor')
  set termguicolors
endif

if index(keys(g:plugs), 'vim-markdown') >= 0
  let g:markdown_fenced_languages = ['json', 'yaml', 'sh', 'bash=sh', 'python']
endif

if (index(keys(g:plugs), 'vim-solarized8') >= 0
    \ && (&t_Co > 2 || has('gui_running')))
  set background=dark
  colorscheme solarized8
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
  let g:ale_fixers = {
    \'*': ['remove_trailing_lines', 'trim_whitespace'],
    \'python': ['yapf'],
    \'rust': ['rustfmt'],
    \'go': ['gofmt'],
    \'cpp': ['clang-format'],
    \'swift': ['swiftformat'],
  \}
  let g:ale_lint_on_text_changed = 0
  let g:ale_echo_msg_format = '[%linter%] %code:% %s'
endif

if index(keys(g:plugs), 'vim-autotag') >= 0
  let g:autotagTagsFile='.tags'
endif

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
set colorcolumn=+2,+4      " highlighted columns to show too long lines

set list                   " show symbols in listchars instead of some chars
set showbreak=↪\           " symbol before continuation of wrapped line
set listchars=nbsp:␣,trail:•,extends:⟩,precedes:⟨,tab:\ \ ,
set expandtab tw=79 sw=2 ts=4

set tags=./.tags;/         " look for tags file from pwd to root

augroup languageSpecific   " set options for different languages
  autocmd!
  autocmd FileType swift set tw=119 sw=4 ts=4
  autocmd FileType python,java,sql,rust set tw=79 sw=4 ts=4
  autocmd FileType go set tw=79 sw=4 ts=4 noet
  autocmd FileType c,cc,h set et tw=79 sw=2 ts=2
  autocmd FileType asciidoc setlocal commentstring=//\ %s
  autocmd FileType html set tw=120
augroup END

augroup fileExtensions
  autocmd BufNewFile,BufRead *.tpl set filetype=mustache
augroup END

" Remove higlights
nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>

" toggle spell checking
nnoremap <silent> <F11> :set spell!<cr>

" bufswitch remaps for consistency with vimium
nnoremap <C-j> <S-j>
nnoremap <C-k> <S-k>
nnoremap <silent><S-j> :bprev<CR>
nnoremap <silent><S-k> :bnext<CR>

" move through display lines instead of actual lines
nnoremap <expr> j v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj'
nnoremap <expr> k v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk'
vnoremap <expr> j v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj'
vnoremap <expr> k v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk'

" walk through errors
nmap <silent> <C-m> <Plug>(ale_previous_wrap)
nmap <silent> <C-n> <Plug>(ale_next_wrap)

" Go to definition
xnoremap <leader>g :ALEGoToDefinition<CR>
nnoremap <leader>g :ALEGoToDefinition<CR>

" run linter
xnoremap <leader>l :ALELint<CR>
nnoremap <leader>l :ALELint<CR>

" run fixer
xnoremap <leader>f :ALEFix<CR>
nnoremap <leader>f :ALEFix<CR>

" exit insert mode in terminal with Esc
tnoremap <Esc> <C-\><C-n>
