scriptencoding utf-8

call plug#begin('C:\Users\mrbea\AppData\Local\vscode-neovim\plugged')

" 光标移动
let g:clever_f_smart_case = 1
let g:clever_f_fix_key_direction = 1
Plug 'rhysd/clever-f.vim'

let g:EasyMotion_smartcase = 1
let g:EasyMotion_do_mapping = 0
Plug 'asvetliakov/vim-easymotion', { 'as': 'vsc-easymotion' }
nmap ; <Plug>(easymotion-bd-f)
vmap ; <Plug>(easymotion-bd-f)

let g:matchup_matchparen_enabled = 0
Plug 'andymass/vim-matchup'

" 快速编辑
nnoremap <silent> [<Space>  :<C-u>put! =repeat(nr2char(10), v:count1)<cr>
nnoremap <silent> ]<Space>  :<C-U>put =repeat(nr2char(10), v:count1)<cr>
vnoremap <C-N> <Cmd>call VSCodeNotifyVisual('editor.action.addSelectionToNextFindMatch', 0)<CR>
vnoremap <C-S-N> <Cmd>call VSCodeNotifyVisual('editor.action.addSelectionToPreviousFindMatch', 0)<CR>
vnoremap <C-S-L> <Cmd>call VSCodeNotifyVisual('addCursorsAtSearchResults', 1)<CR>

" 普通模式
Plug 'terryma/vim-expand-region'
vmap v <Plug>(expand_region_expand)
vmap V <Plug>(expand_region_shrink)
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-function'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-line'
Plug 'sgur/vim-textobj-parameter'
Plug 'tpope/vim-surround'
nnoremap  Y y$
nnoremap <Leader>y "+y
nnoremap <Leader>Y "+y$
vnoremap <Leader>y "+y
nnoremap <Space>y gg"+yG''
nnoremap =p "0p
nnoremap =P "0P
vnoremap =p "0p
nnoremap <silent>=o :<C-U>put =@0<Cr>
nnoremap <silent>=O :<C-U>put! =@0<Cr>
nnoremap <Leader>p "+p
nnoremap <Leader>P "+P
vnoremap <Leader>p "+p
nnoremap <silent><Leader>o :<C-U>put =@+<Cr>
nnoremap <silent><Leader>O :<C-U>put! =@+<Cr>
nnoremap <Space>p ggdG"+P

" 搜索导航
set ignorecase
set smartcase
nnoremap <expr> n  'Nn'[v:searchforward]
nnoremap <expr> N  'nN'[v:searchforward]
nnoremap <silent><C-L> :nohlsearch<CR><C-L>
vnoremap <C-F> <Cmd>call VSCodeNotifyVisual('actions.find', 1)<CR>

" Editor
nnoremap <Leader>n <Cmd>call VSCodeNotify('workbench.action.previousEditorInGroup', 1)<CR>
nnoremap <Leader>b <Cmd>call VSCodeNotify('workbench.action.nextEditorInGroup', 1)<CR>

" Other
nnoremap <silent>g& :s/<up><cr>:nohl<cr>
vnoremap <Leader>t <Cmd>call VSCodeNotifyVisual('translator.replaceWithTranslation', 1)<CR>

call plug#end()


