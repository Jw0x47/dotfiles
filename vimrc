" Leader
let mapleader='\'

set backspace=2   " Backspace deletes like most programs in insert mode
set nocompatible  " Use Vim settings, rather then Vi settings
set nobackup      " Do not back up files (.backup.txt~)
set nowritebackup " Changes default save behavior from 'write new file'->'delete old file'->'rename new file'
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=1000  "
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands
syntax on         " Enable syntax hilighting, always
syntax enable
set tabstop=2     " Softtabs, 2 spaces
set shiftwidth=2  " move 2 tabs at a time
set expandtab     " Tab turn into spaces
set guifont=Inconsolata-dz\ for\ Powerline:h11 "set guifont=font\ name:height##
filetype on       " Enable filetype detection
filetype plugin indent on            " Makes filetype plugin stuff be buffer specific?
set list listchars=tab:»·,trail:·    " Display extra whitespace
setlocal foldmethod=indent           " Enable folding by indentation
set number
set numberwidth=5
set splitbelow    " Open new split panes to right and bottom, which feels more natural
set splitright    " Open new split panes to right and bottom, which feels more natural
set runtimepath+=~/.vim/bundle/unite.vim/
set autochdir     " automatically switch to dir of file you are edititng
" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" ==== VUNDLE ===
  let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
  if !filereadable(vundle_readme)
      echo "Installing Vundle.."
      echo ""
      silent !mkdir -p ~/.vim/bundle
      silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
      BundleInstall
  endif
  set rtp+=~/.vim/bundle/vundle/
  call vundle#begin()
  " Let Vundle manage Vundle
  Plugin 'gmarik/vundle'
  " Define bundles via Github repos
  Plugin 'croaky/vim-colors-github'
  Plugin 'jelera/vim-javascript-syntax'
  Plugin 'scrooloose/syntastic'
  Plugin 'tpope/vim-endwise'
  Plugin 'tpope/vim-fugitive'
  Plugin 'tpope/vim-surround'
  " Plugin 'vim-scripts/tComment'
  Plugin 'chase/vim-ansible-yaml'
  Plugin 'godlygeek/tabular'
  Plugin 'rodjek/vim-puppet'
  Plugin 'Shougo/unite.vim'
  Plugin 'Shougo/vimproc.vim'
  call vundle#end()

" ==== Unite ====
  let g:unite_prompt='» '
  let g:unite_data_directory='~/.vim/.cache/unite'
  let g:unite_source_history_yank_enable=1
  nnoremap <c-p> :Unite -auto-preview -vertical -start-insert file_rec/async<cr>
  nnoremap <c-g> :Unite -auto-preview -vertical grep:.<cr>
  nnoremap <c-y> :Unite history/yank<cr>

  call unite#filters#sorter_default#use(['sorter_rank'])
  " let g:unite_source_history_yank_enable = 1
  call unite#filters#matcher_default#use(['matcher_fuzzy'])
  " nnoremap <C-p> :<C-u>Unite -no-split -buffer-name=files   -start-insert file_rec/async:!<cr>
  " nnoremap <leader>f :<C-u>Unite -no-split -buffer-name=files   -start-insert file<cr>
  " nnoremap <leader>r :<C-u>Unite -no-split -buffer-name=mru     -start-insert file_mru<cr>
  " nnoremap <leader>o :<C-u>Unite -no-split -buffer-name=outline -start-insert outline<cr>
  " nnoremap <leader>y :<C-u>Unite -no-split -buffer-name=yank    history/yank<cr>
  " nnoremap <leader>e :<C-u>Unite -no-split -buffer-name=buffer  buffer<cr>

  " Custom mappings for the unite buffer
  " autocmd FileType unite call s:unite_settings()
  " function! s:unite_settings()
  "   " Play nice with supertab
  "   let b:SuperTabDisabled=1
  "   " Enable navigation with control-j and control-k in insert mode
  "   imap <buffer> <C-j>   <Plug>(unite_select_next_line)
  "   imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
  " endfunction

" ==== Packages ====
  " install bundles
  if filereadable(expand("~/.vimrc.bundles"))
    source ~/.vimrc.bundles
  endif

" ==== Color scheme ====
  let iwantcolors=1
  let gitcolors=expand('~/.vim/colors/github.vim')
  let solarcolors=expand('~/.vim/colors/solarized.vim')
  " colorscheme solarized
  "set background=dark
  highlight Normal ctermbg=NONE

  if !filereadable(gitcolors)
    echo "Installing Color"
    echo ""
    silent !mkdir -p ~/.vim/colors
    silent !wget https://raw.github.com/croaky/vim-colors-github/master/colors/github.vim -O ~/.vim/colors/github.vim
  endif

  if !filereadable(solarcolors)
    echo "Installing Color"
    echo ""
    silent !mkdir -p ~/.dotfiles/vim/colors
    silent !wget https://raw.github.com/altercation/vim-colors-solarized/master/colors/solarized.vim -O ~/.vim/colors/solarized.vim
  endif

" ===== Key Maps =====
  " Iterm
  noremap <C-@> zA
  " MacVim
  noremap <C-Space> zA
  " Get off my lawn
  nnoremap <Left> :echoe "Use h"<CR>
  nnoremap <Right> :echoe "Use l"<CR>
  nnoremap <Up> :echoe "Use k"<CR>
  nnoremap <Down> :echoe "Use j"<CR>
  " Quicker window movement
  nnoremap <C-j> <C-w>j
  nnoremap <C-k> <C-w>k
  nnoremap <C-h> <C-w>h
  nnoremap <C-l> <C-w>l
  " Switch between the last two files
  nnoremap <Space><Space> <c-^>

" ==== NON JONATHAN MAGIC ===
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

  if &term =~ '^xterm'
    let &t_SI .= "\<Esc>[5 q"
    let &t_EI .= "\<Esc>[2 q"
  endif

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

" ==== Tab completion ====
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

" ==== Syntastic ===
  " configure syntastic syntax checking to check on open as well as save
  let g:syntastic_check_on_open=1
  let g:syntastic_python_checkers = ['flake8']

" ==== On write actions ====
  autocmd! FileWritePre * :call TrimWhiteSpace()
  autocmd! FileAppendPre * :call TrimWhiteSpace()
  autocmd! FilterWritePre * :call TrimWhiteSpace()
  autocmd! BufWritePre * :call TrimWhiteSpace()

" === Powerline ===
  set rtp+=/usr/local/lib/python2.7/site-packages/powerline/bindings/vim
