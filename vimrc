""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM Configuration File
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible               " be iMproved
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" [Vundle]
"
" Initial installation:
"  Start with a clean ~/.vim
"  % git clone http://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
"  Add lines from [Vundle] to [Vundle.end] in .vimrc
"  % vim +BundleInstall +qall
"  :help vundle for more details
"
filetype off                   " required!

let $GIT_SSL_NO_VERIFY = 'true'

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" My Bundles here:
"
Bundle 'altercation/vim-colors-solarized'
Bundle 'hsitz/VimOrganizer'
Bundle 'wincent/Command-T'
Bundle 'Rip-Rip/clang_complete'
Bundle 'scrooloose/nerdtree'
Bundle 'tomtom/tcomment_vim'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-repeat'
Bundle 'scrooloose/nerdcommenter'

" enable file-type specific plugins (eg. C/C++ code completion)
filetype plugin indent on     " required!

"
" [Vundle.end]
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" map leader
let mapleader = ","

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" [CommandT]
"
let g:CommandTCancelMap='<C-x>'
set wildignore+=~/builds,~/REMOTE_ROOT,~/log


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" [clang_complete]
"
let g:clang_library_path = expand("$LLVM_PATH/lib")

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" [NERDTree]
"
nnoremap <leader>nt :NERDTreeToggle<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" [VimOrganizer]
"
let g:ft_ignore_pat = '\.org'
au! BufRead,BufWrite,BufWritePost,BufNewFile *.org
au  BufEnter *.org call org#SetOrgFileType()
command! OrgCapture :call org#CaptureBuffer()
command! OrgCaptureFile :call org#OpenCaptureFile()

" [Terminal and Gui options]
"
if !has("gui_running")
  set term=xterm-color
  set background=dark
  let g:solarized_bold=0
  colorscheme solarized
else
"endif
  set background=dark
  set cursorline
  set colorcolumn=80
  let g:solarized_bold=1
  colorscheme solarized
endif
"set lines=50 columns=88
" turn syntax highlighting on
syntax enable

" set UTF-8 encoding
set enc=utf-8
set fenc=utf-8
set termencoding=utf-8
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" [Indentation and tabstops]
"
set autoindent
set smartindent
" configure tabwidth and replace tabs with spaces
set tabstop=4        " tab width is 4 spaces
set shiftwidth=4     " indent also with 4 spaces
set expandtab        " expand tabs to spaces

set listchars=tab:¬·,extends:»,trail:·

set textwidth=80
set nowrap
" turn line numbers on
set number            " also see keyboard mapping to toggle
" highlight matching braces
:let loaded_matchparen = 1 " don't load the match-parens plugin
set showmatch
" intelligent comments
set comments=sl:/*,mb:\ *,elx:\ */
" show current mode in status line
set showmode

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enhanced keyboard mappings (non-plugin specific)
"
" jk - Enter normal mode with minimal hand movement
inoremap <silent>jk <ESC>

" <leader>ev - edit vimrc
nnoremap <leader>ev :split $MYVIMRC<CR>
nnoremap <leader>sv :so $MYVIMRC<CR>

" F2 - Save file
nnoremap <silent><F2> :w<CR>
inoremap <silent><F2> <ESC>:w<CR>i

" F3 - Toggle line numbers
function! ToggleNumber()
    if (&relativenumber == 1)
        set number
    elseif (&number == 1)
        set nonumber
    else
        set relativenumber
    endif
endfunction
nnoremap <silent><F3> :call ToggleNumber()<CR>
inoremap <silent><F3> <ESC>:call ToggleNumber()<CR>i

" F4 - Toggle list mode
nnoremap <silent><F4> :set list!<CR>
inoremap <silent><F4> <ESC>:set list!<CR>i

" F5 - Toggle show match
nnoremap <silent><F5> :set showmatch!<CR>
inoremap <silent><F5> <ESC>:set showmatch!<CR>i

" F6 - Toggle paste mode
nnoremap <silent><F6> :set paste!<CR>
inoremap <silent><F6> <ESC>:set paste!<CR>i

" F12 - Toggle header/source (.h <=> .cc) .c/.cpp not supported
nnoremap <silent><F12> :e %:p:s,.h$,.X123X,:s,.cc$,.h,:s,.X123X$,.cc,<CR>

" Ctrl+F12 - Toggle gui with menu
let g:GuiWithMenu=0
set guioptions-=m  " Remove menu
set guioptions-=T  " Remove Toolbar
set guioptions-=r  " Remove right-scrollbar
set guioptions+=c  " Use console dialog instead of pop-ups
function! ToggleGuiWithMenu()
if (g:GuiWithMenu)
  set guioptions-=mTr
  let g:GuiWithMenu=0
else
  set guioptions+=mTr
  let g:GuiWithMenu=1
endif
endfunction
nnoremap <silent><C-F12> :call ToggleGuiWithMenu()<CR>

" Alt+U - Convert current word to uppercase
"nnoremap <silent><A-U> viwU<ESC>wa
"inoremap <silent><A-U> <ESC>viwU<ESC>wa
"
" "" - quote visual selection
" vnoremap <silent>"" <esc>`<i"<esc>`>a"<esc>

" (( - parenthesize visual selection
" vnoremap <silent>(( <esc>`<i(<esc>`>a)<esc>

" Alt+Left/Alt+Right - Rearrange window-tabs
nnoremap <silent> <A-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <A-Right> :execute 'silent! tabmove ' . tabpagenr()<CR>

" unmap the ESC key - learn to use jk :-)
inoremap <esc> <nop>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Abbreviations

" loremipsum  - See http://lipsum.com
iabbrev loremipsum Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum
