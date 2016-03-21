set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
Plugin 'L9'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
" Plugin 'user/L9', {'name': 'newL9'}
" vim-node
Plugin 'git@github.com:moll/vim-node.git'
" jshint
Plugin 'git@github.com:walm/jshint.vim.git'
" vim-javascript
Plugin 'pangloss/vim-javascript'
" vim-jsbeautify
Plugin 'maksimr/vim-jsbeautify'
Plugin 'einars/js-beautify'
" tern
Plugin 'git@github.com:ternjs/tern_for_vim.git'
" SnipMate
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'
" SnipMate-nodejs
Plugin 'git@github.com:jamescarr/snipmate-nodejs.git'
" command-t
Plugin 'wincent/command-t'
" FuzzyFinder"
Plugin 'FuzzyFinder'
" mango
Plugin 'mango.vim'
" scala
Plugin 'derekwyatt/vim-scala'
" rainbow parentheses
Plugin 'kien/rainbow_parentheses.vim'
" auto pair
Plugin 'jiangmiao/auto-pairs'
" surround.vim
Plugin 'tpope/vim-surround'
" javascript
Plugin 'jelera/vim-javascript-syntax'
" Status line
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
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

" vim-jsbeautify config
autocmd FileType javascript noremap <buffer>  <c-f> :call JsBeautify()<cr>
  " for json 
autocmd FileType json noremap <buffer> <c-f> :call JsonBeautify()<cr>
  " for jsx 
autocmd FileType jsx noremap <buffer> <c-f> :call JsxBeautify()<cr>
  " for html
autocmd FileType html noremap <buffer> <c-f> :call HtmlBeautify()<cr>
  " for css or scss
autocmd FileType css noremap <buffer> <c-f> :call CSSBeautify()<cr>

" esformatter config
nnoremap <silent> <leader>e :call JSFormat()<cr>

function! JSFormat()
  " Preparation: save last search, and cursor position.
  let l:win_view = winsaveview()
  let l:last_search = getreg('/')
  let fileWorkingDirectory = expand('%:p:h')
  let currentWorkingDirectory = getcwd()
  execute ':lcd' . fileWorkingDirectory
  execute ':silent' . '%!esformatter'
  if v:shell_error
    undo
    "echo "esformatter error, using builtin vim formatter"
    " use internal formatting command
    execute ":silent normal! gg=G<cr>"
  endif
  " Clean up: restore previous search history, and cursor position
  execute ':lcd' . currentWorkingDirectory
  call winrestview(l:win_view)
  call setreg('/', l:last_search)
endfunction
" end esformatter config

set background=dark " you can use `dark` or `light` as your background
syntax on
color mango

" map <leader>
:let mapleader=","
set hlsearch
nnoremap tj :%!python -m json.tool<CR>

" size of a hard tabstop
set tabstop=2
" size of an indent
set shiftwidth=2
" a combination of spaces and tabs are used to simulate tab stops at a width
" other than the (hard)tabstop
set softtabstop=2

set number

" tab
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>
nnoremap <silent> <A-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <A-Right> :execute 'silent! tabmove ' . tabpagenr()<CR>

let notabs = 0
nnoremap <silent> <F8> :let notabs=!notabs<Bar>:if notabs<Bar>:tabo<Bar>:else<Bar>:tab ball<Bar>:tabn<Bar>:endif<CR>

nnoremap tt  :tabedit<Space>

"status line
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
set laststatus=2

"Command T
set wildignore+=node_modules
set autochdir

"no swap file
set noswapfile
