call plug#begin('~/.vim/plugged')

Plug 'sickill/vim-monokai'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'

call plug#end()

" Create directories required for temporary files (swap, backup, etc)
if !isdirectory($HOME . "/.vim/swap")
	call mkdir($HOME . "/.vim/swap", "p")
endif

if !isdirectory($HOME . "/.vim/undo")
	call mkdir($HOME . "/.vim/undo", "p")
endif

if !isdirectory($HOME . "/.vim/backup")
	call mkdir($HOME . "/.vim/backup", "p")
endif

" Use swap files to protect only between writes
" Use default values of updatecount(200 keystrokes) and updatetime(4s)
set swapfile
" Save swap files under the vim directory, not next to the file
set directory^=~/.vim/swap//

" Protect against crash-during-write
set writebackup
" But do not persist backup after successful write
set nobackup
" Use rename-and-write-new method whenever safe
set backupcopy=auto
" Patch required to honor double slash at end
if has("patch-8.1.0251")
    " Consolidate the writebackups -- not a big
    " deal either way, since they usually get deleted
    set backupdir^=~/.vim/backup//
end

" Persist the undo tree for each file
set undofile
set undodir^=~/.vim/undo//

" Configure wildcard search menu
set wildmenu
set wildmode=longest:full,full

" Configure default h/v split direction
set splitbelow
set splitright

" Show line numbers
set number

" Configure tabs as 4 spaces
set tabstop=4
set shiftwidth=4
set expandtab

" Configure searching
set hlsearch "Highlight results
set incsearch "Start searching while you type

" Configure theme
set background=dark
colorscheme monokai

" Configure status line
set laststatus=2
let g:lightline={
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'modified' ] ]
      \ },
      \ }

" Use CTRL+p for file fuzzy search
map <C-p> :Files .<CR>

" Search highlight
nnoremap <C-n> :nohlsearch<CR>

" Move between panes without CTRL+w prefix
nnoremap <C-j> <C-W><C-J>
nnoremap <C-k> <C-W><C-K>
nnoremap <C-l> <C-W><C-L>
nnoremap <C-h> <C-W><C-H>

" Open folder explorer
nnoremap <C-e> :Ex<Enter>

" Move line/block up/down using Alt-K/J
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" Toggle line numbers
nnoremap <C-t> :set invnumber<Enter>

" Toggle paste mode
set pastetoggle=<C-y>

" Auto-toggle paste with extra handling for t-mux
function! WrapForTmux(s)
  if !exists('$TMUX')
    return a:s
  endif

  let tmux_start = "\<Esc>Ptmux;"
  let tmux_end = "\<Esc>\\"

  return tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . tmux_end
endfunction

let &t_SI .= WrapForTmux("\<Esc>[?2004h")
let &t_EI .= WrapForTmux("\<Esc>[?2004l")

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

" Automatically remove all trailing spaces when saving
autocmd BufWritePre * %s/\s\+$//e

syntax on
