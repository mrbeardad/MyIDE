" 插入模式
inoremap <C-Return> <C-O>o

" 普通模式
nnoremap <S-Left> <<
nnoremap <S-Right> >>
nnoremap <silent>[<Space> :<C-U>put! =repeat(nr2char(10), v:count1)<CR>
nnoremap <silent>]<Space> :<C-U>put =repeat(nr2char(10), v:count1)<CR>

" 复制粘贴
set clipboard+=unnamedplus
let $PATH=$HOME.'/.local/bin/:'.$PATH   " win32yank.exe在~/.local/bin下
inoremap <c-y> <c-r>"
nnoremap  , yl
nnoremap  Y y$
nnoremap <Leader>, "+yl
nnoremap <Leader>Y "+y$
nnoremap <Leader>y "+y
vnoremap <Leader>y "+y
nnoremap <Leader>p "+p
nnoremap <Leader>P "+P
vnoremap <Leader>p "+p
nnoremap <silent><leader>o :<C-U>put =@+<CR>
nnoremap <silent><leader>O :<C-U>put! =@+<CR>
nnoremap =p "0p
nnoremap =P "0P
vnoremap =p "0p
nnoremap <silent>=o :<C-U>put =@0<CR>
nnoremap <silent>=O :<C-U>put! =@0<CR>

set ignorecase
set smartcase
nnoremap <silent><BS> :nohlsearch<CR>
nnoremap <expr> n  'Nn'[v:searchforward]
nnoremap <expr> N  'nN'[v:searchforward]

nnoremap <silent>g& :s/<up><cr>:nohl<cr>

call plug#begin('~/.vscode-neovim/plugged/')
"==================================================================================================
let g:clever_f_smart_case = 1
let g:clever_f_fix_key_direction = 1
Plug 'rhysd/clever-f.vim'
"==================================================================================================
let g:EasyMotion_smartcase = 1
let g:EasyMotion_do_mapping = 0
Plug 'asvetliakov/vim-easymotion'
nmap ; <Plug>(easymotion-overwin-f2)
"==================================================================================================
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-function'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-line'
Plug 'sgur/vim-textobj-parameter'
"==================================================================================================
Plug 'tpope/vim-surround'
"==================================================================================================
Plug 'terryma/vim-expand-region'
vmap v <Plug>(expand_region_expand)
vmap V <Plug>(expand_region_shrink)
"==================================================================================================
call plug#end()
