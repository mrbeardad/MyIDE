let $XDG_DATA_HOME = $APPDATA
let $XDG_CONFIG_HOME = $LOCALAPPDATA
let $XDG_CACHE_HOME = $TEMP
let $LUNARVIM_RUNTIME_DIR = $XDG_DATA_HOME.'\lunarvim'
let $LUNARVIM_CONFIG_DIR = $XDG_CONFIG_HOME.'\lvim'
let $LUNARVIM_CACHE_DIR = $XDG_CACHE_HOME.'\lvim'
let $LUNARVIM_BASE_DIR = $LUNARVIM_RUNTIME_DIR.'\lvim'

if !exists('g:vscode')
  exe 'luafile '.$LUNARVIM_BASE_DIR.'\init.lua'
else
  set noswapfile
  set nobackup
  set shadafile=NONE
  set ignorecase
  set smartcase

  let disabled_plugins = [
    \ "2html_plugin",
    \ "getscript",
    \ "getscriptPlugin",
    \ "gzip",
    \ "logipat",
    \ "netrw",
    \ "netrwPlugin",
    \ "netrwSettings",
    \ "netrwFileHandlers",
    \ "matchit",
    \ "tar",
    \ "tarPlugin",
    \ "rrhelper",
    \ "spellfile_plugin",
    \ "vimball",
    \ "vimballPlugin",
    \ "zip",
    \ "zipPlugin",
    \ ]
  for plugin in disabled_plugins 
    exe 'let g:loaded_'.plugin.' = 1'
  endfor

  " init plugins
  let g:matchup_matchparen_enabled = 0
  let g:matchup_surround_enabled = 1

  " load plugins
  function s:load_plugin(plugin)
    exe 'set rtp+='.$LUNARVIM_RUNTIME_DIR.'\site\pack\lazy\opt\'.a:plugin
  endf
  call s:load_plugin('hop.nvim')
  call s:load_plugin('vim-matchup')
  call s:load_plugin('vim-visual-star-search')
  call s:load_plugin('vim-cool')
  call s:load_plugin('vim-expand-region')
  call s:load_plugin('vim-repeat')
  call s:load_plugin('vim-textobj-user')
  call s:load_plugin('vim-textobj-entire')
  call s:load_plugin('vim-textobj-indent')
  call s:load_plugin('vim-textobj-line')
  call s:load_plugin('vim-textobj-parameter')
  call s:load_plugin('vim-surround')

  " config plugins
  lua << EOF
    require('hop').setup()
    vim.keymap.set('', 'f', function()
      require("hop").hint_char1({
        direction = require("hop.hint").HintDirection.AFTER_CURSOR,
        current_line_only = true
      })
    end)
    vim.keymap.set('', 'F', function()
      require("hop").hint_char1({
        direction = require("hop.hint").HintDirection.BEFORE_CURSOR,
        current_line_only = true
      })
    end)
    vim.keymap.set('', 't', function()
      require("hop").hint_char1({
        direction = require("hop.hint").HintDirection.AFTER_CURSOR,
        current_line_only = true,
        hint_offset = -1
      })
    end)
    vim.keymap.set('', 'T', function()
      require("hop").hint_char1({
        direction = require("hop.hint").HintDirection.BEFORE_CURSOR,
        current_line_only = true,
        hint_offset = 1
      })
    end)
    vim.keymap.set('', ';', function()
      require("hop").hint_char2()
    end)
    vim.keymap.set('', ',', function()
      require("hop").hint_lines({ multi_windows = true })
    end)
    vim.keymap.set("n", "cw", function()
      local prefix = '"_dw'
      local len = string.len(vim.api.nvim_get_current_line())
      local col = vim.api.nvim_win_get_cursor(0)[2]
      if col + 1 == len then
        return prefix .. "a"
      else
        return prefix .. "i"
      end
    end, { expr = true })
EOF
  nnoremap <expr> n 'Nn'[v:searchforward]
  nnoremap <expr> N 'nN'[v:searchforward]
  nnoremap <silent><C-L> :nohlsearch<CR>
  nnoremap mm <cmd>call VSCodeNotify('bookmarks.toggle')<CR>
  nnoremap mi <cmd>call VSCodeNotify('bookmarks.toggleLabeled')<CR>
  nnoremap mn <cmd>call VSCodeNotify('bookmarks.jumpToNext')<CR>
  nnoremap mp <cmd>call VSCodeNotify('bookmarks.jumpToPrevious')<CR>
  nnoremap ml <cmd>call VSCodeNotify('bookmarks.list')<CR>
  nnoremap mL <cmd>call VSCodeNotify('bookmarks.listFromAllFiles')<CR>
  nnoremap mc <cmd>call VSCodeNotify('bookmarks.clear')<CR>
  nnoremap mC <cmd>call VSCodeNotify('bookmarks.clearFromAllFiles')<CR>
  nnoremap [c <cmd>call VSCodeNotify('workbench.action.editor.previousChange')<CR><Cmd>call VSCodeNotify('workbench.action.compareEditor.previousChange')<CR>
  nnoremap ]c <cmd>call VSCodeNotify('workbench.action.editor.nextChange')<CR><Cmd>call VSCodeNotify('workbench.action.compareEditor.nextChange')<CR>
  vmap v <Plug>(expand_region_expand)
  vmap V <Plug>(expand_region_shrink)
  vnoremap <C-H> <cmd>call VSCodeNotifyVisual('editor.action.startFindReplaceAction', 1)<CR><Esc>
  nnoremap < <<
  nnoremap > >>
  inoremap <C-Z> <cmd>undo<CR>
  inoremap <C-S-Z> <cmd>redo<CR>
  vnoremap <C-N> <cmd>call VSCodeNotifyVisual('editor.action.addSelectionToNextFindMatch', 1)<CR><Esc>
  vnoremap <C-S-N> <cmd>call VSCodeNotifyVisual('editor.action.addSelectionToPreviousFindMatch', 1)<CR><Esc>
  vnoremap <C-S-L> <cmd>call VSCodeNotifyVisual('editor.action.selectHighlights', 1)<CR>
  nnoremap c "_c
  nnoremap s "_s
  nnoremap S i<CR><Esc>
  nnoremap Y y$
  nnoremap zp "0p
  vnoremap zp "0p
  nnoremap zP "0P
  nnoremap zo <cmd>put =@0<CR>
  nnoremap zO <cmd>put! =@0<CR>
  nnoremap <Space><Space> <cmd>let @+ = @0<CR>
  nnoremap <Space>y "+y
  vnoremap <Space>y "+y
  nnoremap <Space>Y "+y$
  nnoremap <Space>p "+p
  vnoremap <Space>p "+p
  nnoremap <Space>P "+P
  nnoremap <Space>o <cmd>put =@+<CR>
  nnoremap <Space>O <cmd>put! =@+<CR>
  nnoremap <Space>by <cmd>%y +<CR>
  nnoremap <Space>bp <cmd>%d<CR>"+P
  nnoremap gr <cmd>call VSCodeNotify('editor.action.goToReferences')<CR>
  nnoremap gI <cmd>call VSCodeNotify('editor.action.goToImplementation')<CR>
  nnoremap [d <cmd>call VSCodeNotify('editor.action.marker.prev')<CR>
  nnoremap ]d <cmd>call VSCodeNotify('editor.action.marker.next')<CR>
  nnoremap H <cmd>call VSCodeNotify('workbench.action.previousEditorInGroup')<CR> 
  nnoremap L <cmd>call VSCodeNotify('workbench.action.nextEditorInGroup')<CR> 
  nnoremap za <cmd>call VSCodeNotify('editor.fold')<CR>
endif
