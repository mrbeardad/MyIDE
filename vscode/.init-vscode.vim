noremap <C-A> <Home>
noremap <C-E> <End>

nnoremap <S-Left> <<
nnoremap <S-Right> >>
inoremap <S-Left> <C-D>
inoremap <S-Right> <C-T>

inoremap <C-Return> <C-O>o

nnoremap <silent><C-S-Down> :m .+1<CR>==
nnoremap <silent><C-S-Up> :m .-2<CR>==
inoremap <silent><C-S-Down> <Esc>:m .+1<CR>==gi
inoremap <silent><C-S-Up> <Esc>:m .-2<CR>==gi
vnoremap <silent><C-S-Down> :m '>+1<CR>gv=gv
vnoremap <silent><C-S-Up> :m '<-2<CR>gv=gv

inoremap <C-L> <Right><BS>
inoremap <C-K> <Esc><Right>d$a

nnoremap Q <C-W>q

set ignorecase
set smartcase
nnoremap <silent><BS> :nohlsearch<CR>
nnoremap <expr> n  'Nn'[v:searchforward]
nnoremap <expr> N  'nN'[v:searchforward]
