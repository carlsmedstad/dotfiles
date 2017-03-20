" Vim Init Script

let g:nvim_dir = expand('~/.config/nvim')

" Plugins
if filereadable(g:nvim_dir.'/autoload/plug.vim')
  let g:plug_dir = g:nvim_dir.'/plugged'
  call plug#begin(g:plug_dir)
  Plug 'tpope/vim-sensible'
  Plug 'tpope/vim-commentary'
  Plug 'mkitt/tabline.vim'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'sheerun/vim-polyglot'
  Plug 'ynkdir/vim-vimlparser'
  Plug 'syngan/vim-vimlint'
  Plug 'vim-syntastic/syntastic'
  call plug#end()
endif

" Airline
if !empty(glob(g:plug_dir.'/vim-airline'))
  let g:airline_powerline_fonts=1
  let g:airline_section_y = ''
  let g:airline_section_z = '%3p%% %{g:airline_symbols.linenr}%4l:%3v'
endif

" Syntastic
if !empty(glob(g:plug_dir.'/syntastic'))
  let g:syntastic_always_populate_loc_list = 1
  let g:syntastic_check_on_open = 1
  let g:syntastic_check_on_wq = 0
  let g:syntastic_html_checkers = ['validator']
endif

" Colorscheme & Highlighting
if &t_Co > 2 || has("gui_running")
  " colorscheme
  colorscheme solarized
  set background=dark
  let g:airline_theme='solarized'
  " signcolumn
  hi SignColumn ctermbg=8
  " tabline
  hi TabLine ctermfg=7 ctermbg=11 cterm=NONE
  hi TabLineFill ctermfg=Black ctermbg=0 cterm=NONE
  hi TabLineSel ctermfg=15 ctermbg=14 cterm=bold
endif

" Use X clipboard
set clipboard=unnamedplus

" Window title
set title
set titlestring=%t

" Search
set ignorecase
set smartcase

" Editor look
set numberwidth=5
set number
set cursorline
set colorcolumn=+1,+3
set nowrap
set list

" Undofile
set undofile

" Wildcards
set wildmode=longest,full

" Indentation
set smartindent
augroup fileTypes
  au!
  au FileType vim set et sw=2
  au FileType html set tw=80 et sw=2
  au FileType java set tw=80 sw=4
augroup END
augroup numberWidth
  au!
  au WinEnter,BufEnter * if line('$') < 100 | setlocal numberwidth=4 | endif
augroup END

" Mappings
let g:mapleader=","
" source or open vim-files
nnoremap <silent><Leader>s :source $MYVIMRC <CR>
nnoremap <silent><Leader>v :tabe $MYVIMRC <BAR> tabm 0<CR>
nnoremap <silent><Leader>n :tabe $HOME/documents/vim.txt<BAR> tabm 0<CR>
" remap J and K
nnoremap <C-j> <S-j>
nnoremap <C-k> <S-k>
" switch tabs
nnoremap <silent><S-k> :tabnext<CR>
nnoremap <silent><S-j> :tabprev<CR>
" traverse syntax-checker errors
nnoremap <silent><A-j> :lprev<CR>
nnoremap <silent><A-k> :lnext<CR>
nnoremap <silent><A-e> :Errors<CR>
nnoremap <silent><A-S-e> :lclose<CR>
" insert one character
nnoremap <silent><Space> :exec "normal i".nr2char(getchar())<CR>
nnoremap <silent><NUL> :exec "normal a".nr2char(getchar())<CR>
" enable some common Ctrl mappings in command line
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-a> <C-b>
cnoremap <C-d> <Del>
cnoremap <C-y> <C-r>"<BS>
cnoremap <C-o> <C-f>
