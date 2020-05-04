
syntax on

set nocompatible
set hidden
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
"
" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=50

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey

call plug#begin('~/.vim/plugged')


Plug 'ycm-core/YouCompleteMe'
Plug 'morhetz/gruvbox'
Plug 'jremmen/vim-ripgrep'
Plug 'tpope/vim-fugitive'
Plug 'leafgarland/typescript-vim'
Plug 'vim-utils/vim-man'
Plug 'lyuts/vim-rtags'
Plug 'mbbill/undotree'

call plug#end()

colorscheme gruvbox
set background=dark

if executable('rg')
    let g:rg_derive_root='true'
endif

let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let mapleader = " "

let g:netrw_browse_split = 2
let g:netrw_banner = 0
let g:netrw_winsize = 25

let g:ctrlp_use_caching = 0

nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>u :UndotreeShow<CR>
nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
nnoremap <Leader>ps :Rg<SPACE>
nnoremap <silent> <Leader>+ :vertical resize +5<CR>
nnoremap <silent> <Leader>- :vertical resize -5<CR>

if exists('g:loaded_quickrun')
  finish
endif
let g:loaded_quickrun = 1

let s:save_cpo = &cpo
set cpo&vim


command! -nargs=* -range=0 -complete=customlist,quickrun#complete QuickRun
\ call quickrun#command(<q-args>, <count>, <line1>, <line2>)


nnoremap <silent> <Plug>(quickrun-op)
\        :<C-u>set operatorfunc=quickrun#operator<CR>g@

nnoremap <silent> <Plug>(quickrun) :<C-u>QuickRun -mode n<CR>
vnoremap <silent> <Plug>(quickrun) :<C-u>QuickRun -mode v<CR>

" Default key mappings.
if !hasmapto('<Plug>(quickrun)')
\  && (!exists('g:quickrun_no_default_key_mappings')
\      || !g:quickrun_no_default_key_mappings)
  silent! map <unique> <Leader>r <Plug>(quickrun)
endif

let &cpo = s:save_cpo
unlet s:save_cpo
