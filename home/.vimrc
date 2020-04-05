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

set splitbelow
set splitright

set number

set tabstop=4
set shiftwidth=4
set expandtab

set background=dark
colorscheme palenight

set laststatus=2
let g:lightline={'colorscheme': 'palenight'}

map <C-P> :Files .<CR>

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Open folder explorer

nnoremap <C-e> :Ex<Enter>

" Move line/block up/down using Alt-K/J
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" Traps compilation mappings
nnoremap <F2> :! (cd nix; ./mktraps.sh -j 6)
nnoremap <F3> :! (cd nix; rm traps_linux-*.sh; ./mkinstall.sh -n; ./mkcloud.sh traps_linux-*-dbg.sh "17157de12e8c9e43ae9bfa8458b150c3" "https://ch-ll-nix.mybrz.net")
nnoremap <F4> :! cp nix/traps_linux-*-cloud.sh ../junk
nnoremap <F5> :! (cd nix; . env.txt; ./scripts/mkproto.sh)
nnoremap <F6> :! (cd nix; ./mktraps.sh all -j 6)
nnoremap <F9> :! make

" Automatically remove all trailing spaces when saving
autocmd BufWritePre * %s/\s\+$//e

syntax on
