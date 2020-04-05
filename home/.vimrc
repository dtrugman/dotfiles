call plug#begin('~/.vim/plugged')

Plug 'drewtempelmeyer/palenight.vim'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'

call plug#end()

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
colorscheme palenight

" Configure status line
set laststatus=2
let g:lightline={'colorscheme': 'palenight'}

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

" Traps compilation mappings
nnoremap <F2> :! (cd nix; ./mktraps.sh -j 8)
nnoremap <F3> :! (cd nix; rm cortex-agent-*.sh; XDR_ENV=dev ./mkinstall.sh --shell --no-strip --dist-id 92d50a8f0b834e5887cc52df3cbef166)
nnoremap <F5> :! (cd nix; . env.txt; ./scripts/mkproto.sh)
nnoremap <F6> :! (cd nix; ./mktraps.sh all -j 6)
nnoremap <F9> :! make

" Automatically remove all trailing spaces when saving
autocmd BufWritePre * %s/\s\+$//e

syntax on
