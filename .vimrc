set nocompatible

let mapleader=","

" Automatic reloading of .vimrc
autocmd! bufwritepost .vimrc source %
map <F9> :e $HOME/.vimrc<CR>

"Toggle pastemode (no autoindent/formating) during paste
set pastetoggle=<F2>

"hides buffers instead of closing them. This means that you can have unwritten
"changes to a file and open a new file using :e, without being forced to write
"or undo your changes first. Also, undo buffers and marks are preserved while
"the buffer is open
set hidden

"filetype off
filetype plugin indent on
set clipboard=unnamed
set mouse=a
set backspace=indent,eol,start
set nofoldenable

set cursorline

" tabs and spaces handling
set expandtab
set tabstop=4
" indent with 4 spaces with TAB
set softtabstop=4
" indent with 4 spaces using <<, >>, ==, ...
set shiftwidth=4

" use multiple of shiftwidth when indenting with '<' and '>'
set shiftround

" always show status bar
set ls=2
" when scrolling, keep cursor 3 lines away from screen border
set scrolloff=3

" incremental search
set incsearch
set ignorecase
" highlighted search results
set hlsearch
" clear serach highlight
nnoremap <F3> :let @/ = ""<CR>

syntax on
set number
set nowrap
set title                " change the terminal's title
set visualbell           " don't beep
set noerrorbells         " don't beep
set undolevels=1000
set nobackup
set noswapfile

" better backup, swap and undos storage
set directory=~/.vim/dirs/tmp     " directory to place swap files in
set backup                        " make backup files
set backupdir=~/.vim/dirs/backups " where to put backup files
set undofile                      " persistent undos - undo after you re-open the file
set undodir=~/.vim/dirs/undos
set viminfo+=n~/.vim/dirs/viminfo

" create needed directories if they don't exist
if !isdirectory(&backupdir)
    call mkdir(&backupdir, "p")
endif
if !isdirectory(&directory)
    call mkdir(&directory, "p")
endif
if !isdirectory(&undodir)
    call mkdir(&undodir, "p")
endif


" Vim-Plug
" https://github.com/junegunn/vim-plug
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" :PlugInstall to install declared plugins

" --- VimPlug Settings ----------------------------------

"  Auto install Vim-Plug if neeeded
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.vim/plugged')
" Make sure you use single quotes (may also use git url)

" --- Plugin  / Colorschemes ----------
Plug 'vim-scripts/wombat256.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'tomasr/molokai'


" --- Plugin ----------
Plug 'scrooloose/nerdtree'

" toggle nerdtree display
map <F8> :NERDTreeToggle<CR>

" open nerdtree with the current file selected
nmap <leader-F8> :NERDTreeFind<CR>

" doni't show these f,le types
let NERDTreeIgnore = ['\.pyc$', '\.pyo$']

" --- Plugin ----------
Plug 'fisadev/FixedTaskList.vim'

map <F7> :TaskList<CR>
let g:tlTokenList = ['todo', 'todo:', 'TODO', 'TODO:', 'debug', 'debug:', 'DEBUG', 'DEBUG:']

" --- Plugin ----------
" https://github.com/scrooloose/nerdcommenter
Plug 'scrooloose/nerdcommenter'

" --- Plugin ----------
" https://github.com/majutsushi/tagbar
Plug 'majutsushi/tagbar'

map <F4> :TagbarToggle<CR>

" autofocus on tagbar open
"let g:tagbar_autofocus = 1

" --- Plugin -----------
" https://github.com/scrooloose/syntastic
Plug 'scrooloose/syntastic'

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Ignore spaces around operators, longs lines, under indented subline
let g:syntastic_quiet_messages = {
    \ "regex":   ['\m\[E225]', '\m\[E501]', '\m\[E128]'],
    \ }

" --- Plugin ------------
" https://github.com/t9md/vim-choosewin
Plug 't9md/vim-choosewin'

nmap  -  <Plug>(choosewin)

" show big letters
let g:choosewin_overlay_enable = 1


" --- Plugin -------------
" https://github.com/bling/vim-airline
Plug 'bling/vim-airline'

let g:airline#extensions#tabline#enabled = 1


" --- Plugin -------------
" https://github.com/kien/ctrlp.vim
Plug 'kien/ctrlp.vim'
Plug 'fisadev/vim-ctrlp-cmdpalette'

" file finder mapping
let g:ctrlp_map = '<leader>e'
" tags (symbols) in current file finder mapping
nmap <leader>g :CtrlPBufTag<CR>
" tags (symbols) in all files finder mapping
nmap <leader>G :CtrlPBufTagAll<CR>
" general code finder in all files mapping
nmap <leader>f :CtrlPLine<CR>
" recent files finder mapping
nmap <leader>m :CtrlPMRUFiles<CR>
" commands finder mapping
nmap <leader>c :CtrlPCmdPalette<CR>
" to be able to call CtrlP with default search text
function! CtrlPWithSearchText(search_text, ctrlp_command_end)
    execute ':CtrlP' . a:ctrlp_command_end
    call feedkeys(a:search_text)
endfunction
" same as previous mappings, but calling with current word as default text
nmap <leader>wg :call CtrlPWithSearchText(expand('<cword>'), 'BufTag')<CR>
nmap <leader>wG :call CtrlPWithSearchText(expand('<cword>'), 'BufTagAll')<CR>
nmap <leader>wf :call CtrlPWithSearchText(expand('<cword>'), 'Line')<CR>
nmap <leader>we :call CtrlPWithSearchText(expand('<cword>'), '')<CR>
nmap <leader>pe :call CtrlPWithSearchText(expand('<cfile>'), '')<CR>
nmap <leader>wm :call CtrlPWithSearchText(expand('<cword>'), 'MRUFiles')<CR>
nmap <leader>wc :call CtrlPWithSearchText(expand('<cword>'), 'CmdPalette')<CR>
" don't change working directory
let g:ctrlp_working_path_mode = 0
" ignore these files and folders on file finder
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.git|\.hg|\.svn)$',
  \ 'file': '\.pyc$\|\.pyo$',
  \ }


" --- Plugin -------------"

" Track the engine.
Plug 'SirVer/ultisnips'

" Snippets are separated from the engine. Add this if you want them:
Plug 'honza/vim-snippets'

" Trigger configuration. Do not use <tab> if you use
" https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" --- Plugin -----------"
Plug 'valloric/youcompleteme'

let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']

" --- Plugin ------------
Plug 'airblade/vim-gitgutter'

" --- Plugin ------------
" http://sjl.bitbucket.org/gundo.vim/

Plug 'sjl/gundo.vim'
nnoremap <F5> :GundoToggle<CR>


call plug#end()

" --- General Settings ----------------------------------

" shift+arrow selection
nmap <S-Up> v<Up>
nmap <S-Down> v<Down>
nmap <S-Left> v<Left>
nmap <S-Right> v<Right>
vmap <S-Up> <Up>
vmap <S-Down> <Down>
vmap <S-Left> <Left>
vmap <S-Right> <Right>
imap <S-Up> <Esc>v<Up>
imap <S-Down> <Esc>v<Down>
imap <S-Left> <Esc>v<Left>
imap <S-Right> <Esc>v<Right>

map tn :tabn<CR>
map tp :tabp<CR>
map tm :tabm
map tt :tabnew
map ts :tab split<CR>
map <C-S-Right> :tabn<CR>
imap <C-S-Right> <ESC>:tabn<CR>
map <C-S-Left> :tabp<CR>
imap <C-S-Left> <ESC>:tabp<CR>

" navigate windows with meta+arrows
map <M-Right> <c-w>l
map <M-Left> <c-w>h
map <M-Up> <c-w>k
map <M-Down> <c-w>j
imap <M-Right> <ESC><c-w>l
imap <M-Left> <ESC><c-w>h
imap <M-Up> <ESC><c-w>k
imap <M-Down> <ESC><c-w>j

" use 256 colors when possible
if &term =~? 'mlterm\|xterm\|xterm-256\|screen-256'
  let &t_Co = 256
  " colorscheme wombat256mod
  colorscheme molokai
  let g:molokai_original = 1
endif

" set background=dark
" colorscheme solarized
" let g:solarized_termcolors=256

" colors for gvim
if has('gui_running')
   colorscheme wombat256mod
endif
