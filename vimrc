"
" Kevin's vimrc file
"

" Use Vim settings, rather than Vi settings (much better!)
set nocompatible

set nobackup          " do not keep a backup file
set history=50        " 50 lines of command line history
set ruler             " show cursor position all the time
set showcmd           " display incomplete commands
set incsearch         " do incremental searching
set colorcolumn=81    " show red line past 80 chars
set tabstop=2         " Indent 2 spaces by default
set shiftwidth=2      " Indent 2 spaces by default
set expandtab         " Always expand tabs to spaces

" Use a mouse if it's available
if has('mouse')
  set mouse=a
endif

if has("autocmd")
  " Use syntax highlighting when available.
  " Also highlight last used search.
  if &t_Co > 2 || has("gui_running")
    syntax on
    set hlsearch
  endif

  " Enable file type detection.
  " Use the default filietype settings
  " Load indent files to do language-dependent indenting
  filetype plugin indent on

  " Put the following in an autocmd group
  augroup vimrcEx
  au!

  " For all text files set width to 80 chars.
  autocmd FileType text setlocal textwidth=80

  " For C/C++ set tabs to 4 spaces instead.
  autocmd FileType c setlocal shiftwidth=4 tabstop=4
  autocmd FileType cpp setlocal shiftwidth=4 tabstop=4

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  " Show trailing whitespace and unwanted tabs:
  autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
  autocmd ColorScheme * highlight UnwantedTab ctermbg=red guibg=red

  " Extra whitespace is any trailing whitespace except when typing it.
  autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
  autocmd InsertLeave * match ExtraWhitespace /\s\+$/

  " Tabs anywhere are unwanted.
  autocmd VimEnter * match UnwantedTab /\t/

  " Set colorscheme at end, so it doesn't clobber highlighting above.
  colorscheme jellybeans

  augroup END
else

set autoindent       " always set autoindent on.

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
      \ | wincmd p | diffthis
endif

" Install pathogen.
"  See https://github.com/tpope/vim-pathogen
execute pathogen#infect()

