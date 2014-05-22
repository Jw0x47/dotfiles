" Leader
" let mapleader = "\"

set backspace=2   " Backspace deletes like most programs in insert mode
set nocompatible  " Use Vim settings, rather then Vi settings
set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=50
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
  set guifont=Inconsolata-dz\ for\ Powerline:h11
  " set Ctrl-space for folds that doesn't work in iterm
  noremap <C-Space> zA
endif
" install bundles
if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

filetype on
filetype plugin indent on

" Enable folding by indentation
setlocal foldmethod=indent
noremap <Space> za
noremap <C-@> zA

augroup vimrcEx
  autocmd!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif


  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile Appraisals set filetype=ruby
  autocmd BufRead,BufNewFile *.md set filetype=markdown

  " Enable spellchecking for Markdown
  autocmd FileType markdown setlocal spell

  " Automatically wrap at 80 characters for Markdown
  autocmd BufRead,BufNewFile *.md setlocal textwidth=80
augroup END

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set expandtab

" Display extra whitespace
set list listchars=tab:»·,trail:·

" Color scheme
let iwantcolors=1
let gitcolors=expand('~/.vim/colors/github.vim')
let solarcolors=expand('~/.vim/colors/solarized.vim')
if !filereadable(gitcolors)
  echo "Installing Color"
  echo ""
  silent !mkdir -p ~/.vim/colors
  silent !wget https://raw.github.com/croaky/vim-colors-github/master/colors/github.vim -O ~/.vim/colors/github.vim
  let iwantcolors=0
endif

if !filereadable(solarcolors)
  echo "Installing Color"
  echo ""
  silent !mkdir -p ~/.dotfiles/vim/colors
  silent !wget https://raw.github.com/altercation/vim-colors-solarized/master/colors/solarized.vim -O ~/.vim/colors/solarized.vim
  let iwantcolors=0
endif

" syntax & Colors
syntax enable
colorscheme solarized
set background=dark
highlight Normal ctermbg=NONE

if &term =~ '^xterm'
  let &t_SI .= "\<Esc>[5 q"
  let &t_EI .= "\<Esc>[2 q"
endif

" Line Numbers
set number
set numberwidth=5

" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full
set complete=.,w,t
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <Tab> <c-r>=InsertTabWrapper()<cr>

" Switch between the last two files
nnoremap <leader><leader> <c-^>

" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" configure syntastic syntax checking to check on open as well as save
let g:syntastic_check_on_open=1
let g:syntastic_python_checkers = ['flake8']

" Remove trailing whitespace when a file is saved
" Source: <http://vim.wikia.com/wiki/Remove_unwanted_spaces>
function! TrimWhiteSpace()
  " Do not record the whitespace removal in the undo history
  " Source: <http://vim.1045645.n5.nabble.com/there-s-undojoin-how-about-dotjoin-td1203135.html>
  try
    undojoin
  catch
    " Probably an undo was just issued, and so there's no way to join the undo.
    " Which sucks.
  endtry
  %s/\s*$//
  ''
endfunction
autocmd! FileWritePre * :call TrimWhiteSpace()
autocmd! FileAppendPre * :call TrimWhiteSpace()
autocmd! FilterWritePre * :call TrimWhiteSpace()
autocmd! BufWritePre * :call TrimWhiteSpace()
