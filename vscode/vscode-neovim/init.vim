scriptencoding utf-8

call plug#begin('C:\Users\mrbea\AppData\Local\vscode-neovim\plugged')

" 光标移动
" f/F/t/T: smart f
let g:clever_f_smart_case = 1
let g:clever_f_fix_key_direction = 1
Plug 'rhysd/clever-f.vim'
" ;: easymotion
let g:EasyMotion_smartcase = 1
let g:EasyMotion_do_mapping = 0
Plug 'asvetliakov/vim-easymotion', { 'as': 'vsc-easymotion' }
map ; <Plug>(easymotion-bd-f2)
map , <Plug>(easymotion-bd-jk)
" %: match up
let g:matchup_matchparen_enabled = 0
Plug 'andymass/vim-matchup'

" 全文搜索
set ignorecase
set smartcase
Plug 'bronson/vim-visual-star-search'
Plug 'romainl/vim-cool'
nnoremap <expr> n 'Nn'[v:searchforward]
nnoremap <expr> N 'nN'[v:searchforward]
nnoremap <silent><Bs> :nohlsearch<CR>
nnoremap <silent><C-L> :nohlsearch<CR>
vnoremap <C-F> <Cmd>call VSCodeNotifyVisual('actions.find', 1)<CR><Esc>

" 标签跳转
nnoremap mm <Cmd>call VSCodeNotify('bookmarks.toggle')<CR>
nnoremap mi <Cmd>call VSCodeNotify('bookmarks.toggleLabeled')<CR>
nnoremap mn <Cmd>call VSCodeNotify('bookmarks.jumpToNext')<CR>
nnoremap mp <Cmd>call VSCodeNotify('bookmarks.jumpToPrevious')<CR>
nnoremap ml <Cmd>call VSCodeNotify('bookmarks.list')<CR>
nnoremap mL <Cmd>call VSCodeNotify('bookmarks.listFromAllFiles')<CR>
nnoremap mc <Cmd>call VSCodeNotify('bookmarks.clear')<CR>
nnoremap mC <Cmd>call VSCodeNotify('bookmarks.clearFromAllFiles')<CR>


" 插入编辑
" <: outdent line
nnoremap < <<
" >: indent line
nnoremap > >>
" ctrl+n/ctrl+shift+n/ctrl+shift+l: multi cursor edit
vnoremap <C-N> <Cmd>call VSCodeNotifyVisual('editor.action.addSelectionToNextFindMatch', 1)<CR><Esc>
vnoremap <C-S-N> <Cmd>call VSCodeNotifyVisual('editor.action.addSelectionToPreviousFindMatch', 1)<CR><Esc>
vnoremap <C-S-L> <Cmd>call VSCodeNotifyVisual('addCursorsAtSearchResults', 1)<CR><Esc>

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
Plug 'tpope/vim-repeat'
" u: vscode undo, must defined after load vim-repeat
nnoremap u <Cmd>call VSCodeNotifyVisual('undo', 1)<CR><Esc>

" 复制粘贴
" yank to 0
nnoremap  Y y$
nnoremap =p "0p
vnoremap =p "0p
nnoremap =P "0P
nnoremap <silent>=o :<C-U>put =@0<Cr>
nnoremap <silent>=O :<C-U>put! =@0<Cr>
" yank to +
nnoremap <Space>y "+y
vnoremap <Space>y "+y
nnoremap <Space>Y "+y$
nnoremap <Space><Space> :<C-U>let @+ = @0<Cr>
nnoremap <Space>p "+p
vnoremap <Space>p "+p
nnoremap <Space>P "+P
nnoremap <silent><Space>o :<C-U>put =@+<Cr>
nnoremap <silent><Space>O :<C-U>put! =@+<Cr>
" yank all to +
nnoremap <Space>by :%y +<Cr>
nnoremap <Space>bp :%d<Cr>"+P

" 语言服务
nnoremap gr <Cmd>call VSCodeNotify('editor.action.goToReferences')<CR>
nnoremap [c <Cmd>call VSCodeNotify('workbench.action.editor.previousChange')<CR>
nnoremap ]c <Cmd>call VSCodeNotify('workbench.action.editor.nextChange')<CR>
nnoremap [d <Cmd>call VSCodeNotify('editor.action.diffReview.prev')<CR>
nnoremap ]d <Cmd>call VSCodeNotify('editor.action.diffReview.next')<CR>
nnoremap [e <Cmd>call VSCodeNotify('editor.action.marker.prevInFiles')<CR>
nnoremap ]e <Cmd>call VSCodeNotify('editor.action.marker.nextInFiles')<CR>

" 其他按键
nnoremap za <Cmd>call VSCodeNotify('editor.toggleFold')<CR>
vnoremap <Space>t <Cmd>call VSCodeNotifyVisual('translator.translate', 1)<CR>
vnoremap <Space>T <Cmd>call VSCodeNotifyVisual('translator.replaceWithTranslation', 1)<CR>

call plug#end()
