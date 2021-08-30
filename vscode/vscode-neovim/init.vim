" 插入模式
inoremap <C-A> <Home>
inoremap <C-E> <End>
imap <C-C> <Esc>

" 普通模式
nnoremap <C-A> <Home>
nnoremap <C-E> <End>
nnoremap <S-Left> <<
nnoremap <S-Right> >>
nnoremap <silent> [<Space>  :<c-u>put! =repeat(nr2char(10), v:count1)<cr>
nnoremap <silent> ]<Space>  :<c-u>put =repeat(nr2char(10), v:count1)<cr>

" 可视模式
vnoremap <C-A> <Home>
vnoremap <C-E> <End>

" 复制粘贴
let $PATH=$HOME.'/.local/bin/:'.$PATH   " 将win32yank.exe解压到~/.local/bin下
inoremap <c-y> <c-r>"
nnoremap  , yl
nnoremap  Y y$
nnoremap <Leader>, "+yl
nnoremap <Leader>Y "+y$
nnoremap <Leader>y "+y
vnoremap <Leader>y "+y
nnoremap <Space>y ggVG"+y<C-O>
nnoremap <Leader>p "+p
nnoremap <Leader>P "+P
vnoremap <Leader>p "+p
nnoremap <silent><leader>o :<C-U>put =@+<CR>
nnoremap <silent><leader>O :<C-U>put! =@+<CR>
nnoremap <Space>p ggdG"+P
nnoremap =p "0p
nnoremap =P "0P
vnoremap =p "0p
nnoremap <silent>=o :<C-U>put =@0<CR>
nnoremap <silent>=O :<C-U>put! =@0<CR>

" fast wrap
func! s:getline()
  let line = getline('.')
  let pos = col('.') - 1
  let before = strpart(line, 0, pos)
  let after = strpart(line, pos)
  let afterline = after
  if 1
    let n = line('$')
    let i = line('.')+1
    while i <= n
      let line = getline(i)
      let after = after.' '.line
      if !(line =~ '\v^\s*$')
        break
      end
      let i = i+1
    endwhile
  end
  return [before, after, afterline]
endf
func! AutoPairsFastWrap()
  let c = @"
  normal! x
  let [before, after, ig] = s:getline()
  if after[0] =~ '\v[\{\[\(\<]'
    normal! %
    normal! p
  else
    for [open, close, opt] in [['\v^\s*\zs"', '', {'key': '', 'mapclose': 1, 'multiline': 1}], ['```', '```', {'key': '`', 'mapclose': 1, 'multiline': 0}], ['''''''', '''''''', {'key': '''', 'mapclose': 1, 'multiline': 0}], ['"""', '"""', {'key': '"', 'mapclose': 1, 'multiline': 0}], ['`', '`', {'key': '`', 'mapclose': 1, 'multiline': 0}], ['"', '"', {'key': '"', 'mapclose': 1, 'multiline': 0}], ['[', ']', {'key': ']', 'mapclose': 1, 'multiline': 1}], ['\v(^|\W)\zs''', '''', {'key': '''', 'mapclose': 1, 'multiline': 0}], ['(', ')', {'key': ')', 'mapclose': 1, 'multiline': 1}], ['{', '}', {'key': '}', 'mapclose': 1, 'multiline': 1}]]
      if close == ''
        continue
      end
      if after =~ '^\s*\V'.open
        call search(close, 'We')
        normal! p
        let @" = c
        return ""
      end
    endfor
    if after[1:1] =~ '\v\w'
      normal! e
      normal! p
    else
      normal! p
    end
  end
  let @" = c
  return ""
endf
inoremap <silent><M-e> <C-R>=AutoPairsFastWrap()<CR>

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
Plug 'asvetliakov/vim-easymotion', { 'as': 'vsc-easymotion' }
nmap ; <Plug>(easymotion-bd-f)
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
