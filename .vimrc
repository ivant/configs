set nocompatible              " be iMproved, required
filetype off                  " required

" Add Lilypond
let &rtp=&rtp . ',' . sort(glob('/usr/share/lilypond/[0-9]*/vim/', 0, 1))[-1]

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" " The following are examples of different formats supported.
" " Keep Plugin commands between vundle#begin/end.
" " plugin on GitHub repo
" Plugin 'tpope/vim-fugitive'
" " plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" " Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" " git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" " The sparkup vim script is in a subdirectory of this repo called vim.
" " Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" " Avoid a name conflict with L9
" Plugin 'user/L9', {'name': 'newL9'}

Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-unimpaired'
"Plugin 'Valloric/YouCompleteMe'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-session'
Plugin 'kien/ctrlp.vim'
Plugin 'FelikZ/ctrlp-py-matcher'
Plugin 'scrooloose/syntastic'
Plugin 'fidian/hexmode'
Plugin 'rking/ag.vim'
Plugin 'davidzchen/vim-bazel'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

source $VIMRUNTIME/macros/matchit.vim

syntax on
set ruler

set hlsearch incsearch ignorecase smartcase
set ts=2 sw=2 et
set bs=indent,eol,start
set number relativenumber
set autoindent smartindent
set scrolloff=3

set diffopt=iwhite

set formatoptions=croql1j

set wildmenu wildmode=list:longest,full
set title
set ruler

set guioptions-=l
set guioptions-=r
set guioptions-=L
set guioptions-=R

" See http://stackoverflow.com/questions/2158516/vim-delay-before-o-opens-a-new-line
set timeout timeoutlen=3000 ttimeoutlen=100

" See http://vim.wikia.com/wiki/Easy_edit_of_files_in_the_same_directory
cabbr <expr> %% expand('%:p:h')

au FileType java set foldmethod=syntax foldlevel=1000 colorcolumn=101,102
au FileType cpp set foldmethod=syntax foldlevel=1000 colorcolumn=81,82
au FileType python set foldmethod=syntax foldlevel=1000 colorcolumn=81,82 sw=2
au FileType lilypond set ts=2 sw=2 et foldmethod=indent

let g:ctrlp_extensions = ['buffertag', 'line', 'changes']
let g:ctrlp_buftag_ctags_bin = '/usr/bin/ctags'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.hg$\|\.svn\|\.DS_Store$',
  \ 'file': '\.exe$\|\.so$\|\.dll$',
  \ 'link': 'bazel-bin\|bazel-genfiles\|bazel-out\|bazel-testlogs\|WORKSPACE$',
  \ }
let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
  \ --ignore .git
  \ --ignore .svn
  \ --ignore .hg
  \ --ignore .DS_Store
  \ --ignore "**/*.pyc"
  \ -g ""'

let g:ycm_complete_in_comments=1

let g:session_autoload='no'
let g:session_autosave='no'

colorscheme darkblue

if filereadable($HOME . "/.vimrc.google")
  source $HOME/.vimrc.google
endif
