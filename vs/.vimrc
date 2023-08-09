" use for VsVim
set ignorecase
set smartcase
set hlsearch
nnoremap <C-L> :nohl<CR>
nnoremap # *NN
nnoremap g# g*NN
nnoremap <C-T> :vsc Edit.GoToSymbol<CR>
" noremap <C-S-J> :vsc Edit.MoveSelectedLinesDown<CR>
" noremap <C-S-K> :vsc Edit.MoveSelectedLinesUp<CR>
nnoremap < <<
nnoremap > >>
vnoremap c "_c
nnoremap c "_c
nnoremap s "_s
nnoremap Y y$
nnoremap zp "0p
vnoremap zp "0p
nnoremap zP "0P
nnoremap zo o<Esc>"0p
nnoremap zO O<Esc>"0p
nnoremap zg :let @+ = @0<CR>
nnoremap gy "+y
vnoremap gy "+y
nnoremap gY "+y$
nnoremap gp "+p
vnoremap gp "+p
nnoremap gP "+P
nnoremap zo o<Esc>"+p
nnoremap zO O<Esc>"+p
