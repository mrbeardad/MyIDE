--------------------------------------------------------------------------------
-- vim options
--------------------------------------------------------------------------------
vim.opt.backupdir = join_paths(get_cache_dir(), "backup")
vim.opt.backup = true
vim.opt.swapfile = true
vim.opt.directory = join_paths(get_cache_dir(), "swap")
vim.opt.clipboard = ""
vim.opt.colorcolumn = "100"
vim.opt.confirm = true
vim.opt.guicursor = "n:block-blinkon10,i-ci:ver15-blinkon10,c:hor15-blinkon10,v-sm:block,ve:ver15,r-cr-o:hor10"
vim.opt.list = true
vim.opt.listchars = "tab:→ ,eol:↵,trail:·,extends:↷,precedes:↶"
vim.opt.relativenumber = true
vim.opt.timeoutlen = 500
vim.opt.wildignorecase = true
vim.opt.cursorline = true
-- Cursorline highlighting control, only have it on in the active buffer
local group = vim.api.nvim_create_augroup("CursorLineControl", { clear = true })
vim.api.nvim_create_autocmd("WinLeave", {
  group = group,
  callback = function()
    vim.opt_local.cursorline = false
    if vim.bo.buftype ~= "nofile" and vim.bo.buftype ~= "help" then
      vim.opt_local.relativenumber = false
    end
  end,
})
vim.api.nvim_create_autocmd("WinEnter", {
  group = group,
  callback = function()
    if vim.bo.buftype ~= "nofile" and vim.bo.buftype ~= "help" then
      vim.opt_local.cursorline = true
      vim.opt_local.relativenumber = true
    end
  end,
})

--------------------------------------------------------------------------------
-- lvim options
--------------------------------------------------------------------------------
lvim.builtin.lualine.sections.lualine_y = {
  { "fileformat" },
  { "encoding" },
}
lvim.builtin.lualine.sections.lualine_z = {
  { " %c  %l/%L", type = "stl" },
}
lvim.builtin.treesitter.matchup.enable = true
lvim.builtin.treesitter.rainbow.enable = true
lvim.builtin.terminal.open_mapping = "<C-Space>" -- ctrl+`
lvim.builtin.nvimtree.setup.view.mappings.list = {
  { key = { "<Tab>" },     action = "" },
  { key = { "l", "<CR>" }, action = "edit",      mode = "n" },
  { key = "h",             action = "close_node" },
}
lvim.builtin.telescope.defaults.layout_config.center = { width = 0.75 }
lvim.builtin.telescope.defaults.mappings = {
  i = {
    ["<Esc>"] = require("telescope.actions").close,
  },
}
lvim.builtin.gitsigns.opts.on_attach = function(bufnr)
  local gs = package.loaded.gitsigns
  vim.keymap.set('n', ']c', function()
    if vim.wo.diff then return ']c' end
    vim.schedule(function() gs.next_hunk() end)
    return '<Ignore>'
  end, { expr = true, buffer = bufnr })
  vim.keymap.set('n', '[c', function()
    if vim.wo.diff then return '[c' end
    vim.schedule(function() gs.prev_hunk() end)
    return '<Ignore>'
  end, { expr = true, buffer = bufnr })
end
lvim.format_on_save.enabled = true

--------------------------------------------------------------------------------
-- custom plugins
--------------------------------------------------------------------------------
local disabled_plugins = {
  "2html_plugin",
  "getscript",
  "getscriptPlugin",
  "gzip",
  "logipat",
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "matchit",
  "tar",
  "tarPlugin",
  "rrhelper",
  "spellfile_plugin",
  "vimball",
  "vimballPlugin",
  "zip",
  "zipPlugin",
}
for _, plugin in pairs(disabled_plugins) do
  vim.g["loaded_" .. plugin] = 1
end
lvim.plugins = {
  {
    "petertriho/nvim-scrollbar",
    event = "BufRead",
    config = true,
  },
  {
    "karb94/neoscroll.nvim",
    event = "WinScrolled",
    config = function()
      require("neoscroll").setup()
      vim.keymap.set({ "n", "v" }, "z<CR>", "zt", { remap = true })
    end,
  },
  {
    "phaazon/hop.nvim",
    event = "BufRead",
    init = function()
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
    end,
    config = true
  },
  {
    "andymass/vim-matchup",
    event = "BufRead",
    init = function()
      vim.g.matchup_surround_enabled = 1
      vim.g.matchup_transmute_enabled = 1
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
  },
  {
    "p00f/nvim-ts-rainbow",
    event = "BufRead"
  },
  {
    "norcalli/nvim-colorizer.lua",
    event = "BufRead",
    config = true,
  },
  {
    "ethanholz/nvim-lastplace",
    event = "BufRead",
    config = true,
  },
  {
    "MattesGroeger/vim-bookmarks",
    event = "BufRead",
    init = function()
      vim.g.bookmark_sign = ""
      vim.g.bookmark_annotation_sign = ""
      vim.g.bookmark_display_annotation = 1
      vim.g.bookmark_no_default_key_mappings = 1
      vim.g.bookmark_auto_save_file = join_paths(get_cache_dir(), "vim-bookmarks")
    end,
    config = function()
      vim.keymap.set("n", "mm", "<Plug>BookmarkToggle", { remap = true })
      vim.keymap.set("n", "mi", "<Plug>BookmarkAnnotate", { remap = true })
      vim.keymap.set("n", "mn", "<Plug>BookmarkNext", { remap = true })
      vim.keymap.set("n", "mp", "<Plug>BookmarkPrev", { remap = true })
      vim.keymap.set("n", "mc", "<Plug>BookmarkClear", { remap = true })
      vim.keymap.set("n", "mC", "<Plug>BookmarkClearAll", { remap = true })
      vim.keymap.set("n", "mj", "<Plug>BookmarkMoveDown", { remap = true })
      vim.keymap.set("n", "mk", "<Plug>BookmarkMoveUp", { remap = true })
      vim.keymap.set("n", "mg", "<Plug>BookmarkMoveToLine", { remap = true })
    end,
  },
  {
    "tom-anders/telescope-vim-bookmarks.nvim",
    keys = { "ml", "mL" },
    config = function()
      require("telescope").load_extension("vim_bookmarks")
      vim.keymap.set("n", "ml", "<cmd>Telescope vim_bookmarks current_file<CR>")
      vim.keymap.set("n", "mL", "<cmd>Telescope vim_bookmarks all<CR>")
    end,
  },
  {
    "bronson/vim-visual-star-search",
    keys = { { "*", mode = "v" }, { "#", mode = "v" } },
  },
  {
    "romainl/vim-cool",
    event = "CursorMoved",
  },
  {
    "mg979/vim-visual-multi",
    keys = { "<C-N>", { "<C-N>", mode = "v" }, "<C-S-L>", { "<C-S-L>", mode = "v" }, "ma", { "ma", mode = "v" } },
    init = function()
      vim.g.VM_set_statusline = 0
      vim.cmd([[
        " VM will override <BS>
        function! VM_Start()
          iunmap <buffer><BS>
        endf
        function! VM_Exit()
          exe 'inoremap <buffer><expr><BS> v:lua.MPairs.autopairs_bs('.bufnr().')'
        endf
       ]])
    end,
    config = function()
      vim.keymap.set("n", "<C-S-L>", "<Plug>(VM-Select-All)", { remap = true })
      vim.keymap.set("v", "<C-S-L>", "<Plug>(VM-Visual-All)", { remap = true })
      vim.keymap.set("n", "ma", "<Plug>(VM-Add-Cursor-At-Pos)", { remap = true })
      vim.keymap.set("v", "ma", "<Plug>(VM-Visual-Add)", { remap = true })
    end,
  },
  {
    "terryma/vim-expand-region",
    keys = { { "v", mode = "v" }, { "V", mode = "v" } },
    config = function()
      vim.keymap.set("v", "v", "<Plug>(expand_region_expand)", { remap = true })
      vim.keymap.set("v", "V", "<Plug>(expand_region_shrink)", { remap = true })
    end,
  },
  {
    "tpope/vim-repeat",
  },
  {
    "kana/vim-textobj-user",
  },
  {
    "kana/vim-textobj-entire",
    keys = { "c", "d", "y" },
  },
  {
    "kana/vim-textobj-indent",
    keys = { "c", "d", "y" },
  },
  {
    "kana/vim-textobj-line",
    keys = { "c", "d", "y" },
  },
  {
    "sgur/vim-textobj-parameter",
    keys = { "c", "d", "y" },
  },
  {
    "tpope/vim-surround",
    keys = { "c", "d", "y" },
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function()
      require('lsp_signature').setup({
        hint_prefix = " ",
      })
    end,
  },
  {
    "benfowler/telescope-luasnip.nvim",
    lazy = true,
    init = function()
      vim.keymap.set({ "n", "i" }, "<M-i>", "<cmd>lua require'telescope'.extensions.luasnip.luasnip{}<CR>")
    end,
    config = function()
      require('telescope').load_extension('luasnip')
    end
  },
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    init = function()
      lvim.builtin.which_key.mappings["S"] = { "<cmd>SymbolsOutline<CR>", "SymbolsOutline" }
    end,
    config = function()
      require("symbols-outline").setup({
        width = 20,
      })
    end
  },
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle" },
    init = function()
      lvim.builtin.which_key.mappings["t"] = {
        name = "Trouble",
        d = { "<cmd>TroubleToggle workspace_diagnostics<CR>", "Diagnostics" },
        t = { "<cmd>TodoTrouble<CR>", "TODOs" }
      }
      lvim.lsp.buffer_mappings.normal_mode['gd'] = { function() vim.cmd("Trouble lsp_definitions") end,
        "Goto definitions" }
      lvim.lsp.buffer_mappings.normal_mode['gr'] = { function() vim.cmd("Trouble lsp_references") end, "Goto references" }
      lvim.lsp.buffer_mappings.normal_mode['gI'] = { function() vim.cmd("Trouble lsp_implementations") end,
        "Goto implementations" }
      vim.keymap.set("n", "<M-LeftMouse>", "<LeftMouse><cmd>Trouble lsp_definitions<CR>")
    end,
    config = true,
  },
  {
    "folke/todo-comments.nvim",
    event = "BufRead",
    config = function()
      require("todo-comments").setup()
    end,
  },
  {
    "mbbill/undotree",
    cmd = { "UndotreeToggle" },
    init = function()
      lvim.builtin.which_key.mappings["u"] = { "<cmd>UndotreeToggle<CR>", "UndoTree" }
    end
  },
  {
    "stevearc/dressing.nvim",
    config = true,
  },
  { 'rcarriga/nvim-notify',
    config = function()
      local notify = require("notify")
      notify.setup({
        stages = "slide",
      })
      vim.notify = notify
    end
  },
  {
    'voldikss/vim-translator',
    keys = { { "<M-t>", mode = { "n", "v" } } },
    init = function()
      vim.g.translator_default_engines = { 'bing', 'haici' }
    end,
    config = function()
      vim.keymap.set("n", "<M-t>", "<Plug>TranslateW")
      vim.keymap.set("v", "<M-t>", "<Plug>TranslateWV")
    end
  }
}

--------------------------------------------------------------------------------
-- key bindings
--------------------------------------------------------------------------------
vim.keymap.set("c", "<C-A>", "<C-B>")

-- HACK: terminal map ctrl+i to alt+shift+i
vim.keymap.set("n", "<M-I>", "<C-I>")

vim.keymap.set("n", "n", "'Nn'[v:searchforward]", { expr = true })
vim.keymap.set("n", "N", "'nN'[v:searchforward]", { expr = true })
vim.keymap.set("n", "<C-L>", "<cmd>nohl<CR><C-L>")
vim.keymap.set("c", "<M-w>", "\\<\\><Left><Left>")
vim.keymap.set("c", "<M-r>", "\\v")
vim.keymap.set("c", "<M-c>", "\\C")
vim.keymap.set("n", "<C-S-F>", "<cmd>Telescope live_grep<CR>")

vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("n", "<", "<<")
vim.keymap.set("n", ">", ">>")
vim.keymap.set("i", "<C-S-J>", "<cmd>m .+1<CR><Cmd>normal ==<CR>")
vim.keymap.set("n", "<C-S-J>", "<cmd>m .+1<CR><Cmd>normal ==<CR>")
vim.keymap.set("i", "<C-S-K>", "<cmd>m .-2<CR><Cmd>normal ==<CR>")
vim.keymap.set("n", "<C-S-K>", "<cmd>m .-2<CR><Cmd>normal ==<CR>")
vim.keymap.set("i", "<C-J>", "<End><CR>")
vim.keymap.set("n", "<C-J>", "<cmd>put =repeat(nr2char(10), v:count1)<CR>")
vim.keymap.set("i", "<C-K>", "repeat('<Del>', strchars(getline('.')) - getcurpos()[2] + 1)", { expr = true })
vim.keymap.set("c", "<C-K>", "repeat('<Del>', strchars(getcmdline()) - getcmdpos() + 1)", { expr = true })
vim.keymap.set("i", "<C-L>", "<Esc>ea")
vim.keymap.set("c", "<C-L>", "<C-Right>")
vim.keymap.set("i", "<C-Z>", "<cmd>undo<CR>")
vim.keymap.set("i", "<C-S-z>", "<cmd>redo<CR>")

vim.keymap.set("n", "c", '"_c')
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
vim.keymap.set("n", "S", "i<CR><Esc>")

vim.keymap.set("i", "<C-V>", "<C-R>+")
vim.keymap.set("n", "Y", '"0y$')
vim.keymap.set("n", "zp", '"0p')
vim.keymap.set("v", "zp", '"0p')
vim.keymap.set("n", "zP", '"0P')
vim.keymap.set("n", "zo", "<cmd>put =@0<CR>")
vim.keymap.set("n", "zO", "<cmd>put! =@0<CR>")
lvim.builtin.which_key.mappings["<Space>"] = { '<cmd>let @+ = @0<CR>', "Copy last yank to clipboard" }
lvim.builtin.which_key.mappings["y"] = { '"+y', "Yank" }
lvim.builtin.which_key.vmappings["y"] = { '"+y', "Yank" }
lvim.builtin.which_key.mappings["Y"] = { '"+y$', "Yank EOL" }
lvim.builtin.which_key.mappings["p"] = { '"+p', "Paste (after)" }
lvim.builtin.which_key.vmappings["p"] = { '"+p', "Paste" }
lvim.builtin.which_key.mappings["P"] = { '"+P', "Paste (before)" }
lvim.builtin.which_key.mappings["o"] = { '<cmd>put =@+<CR>', "Paste (next line)" }
lvim.builtin.which_key.mappings["O"] = { '<cmd>put =@+<CR>', "Paste (previous line)" }
lvim.builtin.which_key.mappings["by"] = { "<cmd>%y +<CR>", "Yank whole buffer to clipboard" }
lvim.builtin.which_key.mappings["bp"] = { '<cmd>%d<CR>"+P', "Patse clipboard to whole buffer" }

lvim.builtin.cmp.confirm_opts.select = true
local cmp = require("cmp")
local luasnip = require("luasnip")
local lccm = require("lvim.core.cmp").methods
lvim.builtin.cmp.mapping["<C-J>"] = nil
lvim.builtin.cmp.mapping["<C-K>"] = nil
lvim.builtin.cmp.mapping["<C-D>"] = nil
lvim.builtin.cmp.mapping["<C-F>"] = nil
lvim.builtin.cmp.mapping["<C-E>"] = cmp.mapping.scroll_docs(4)
lvim.builtin.cmp.mapping["<C-Y>"] = cmp.mapping.scroll_docs( -4)
lvim.builtin.cmp.mapping["<M-I>"] = cmp.mapping(function()
  if cmp.visible() then
    cmp.abort()
  else
    cmp.complete()
  end
end)
lvim.builtin.cmp.mapping["<Tab>"] = cmp.mapping(function(fallback)
  if cmp.visible() then
    local confirm_opts = vim.deepcopy(lvim.builtin.cmp.confirm_opts) -- avoid mutating the original opts below
    local is_insert_mode = function()
      return vim.api.nvim_get_mode().mode:sub(1, 1) == "i"
    end
    if is_insert_mode() then -- prevent overwriting brackets
      confirm_opts.behavior = require("cmp.types.cmp").ConfirmBehavior.Insert
    end
    if cmp.confirm(confirm_opts) then
      return -- success, exit early
    end
  elseif luasnip.expand_or_locally_jumpable() then
    luasnip.expand_or_jump()
  elseif lccm.jumpable(1) then
    luasnip.jump(1)
  elseif lccm.has_words_before() then
    -- cmp.complete()
    fallback()
  else
    fallback()
  end
end, { "i", "s" })
vim.keymap.set({ "n", "i" }, "<M-F>", '<cmd>lua require("lvim.lsp.utils").format()<CR>')
vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<CR>")
vim.keymap.set("n", "<M-.>", "<cmd>lua vim.lsp.buf.code_action()<CR>")
vim.keymap.set("n", "<C-.>", "<cmd>lua vim.lsp.buf.code_action()<CR>")
vim.keymap.set("n", "<C-_>", "gcc", { remap = true })
vim.keymap.set("v", "<C-_>", "<Plug>(comment_toggle_linewise_visual)", { remap = true })
vim.keymap.set("i", "<C-_>", "<cmd>normal gcc<CR>")
vim.keymap.set("n", "<C-S-O>", "<cmd>Telescope lsp_document_symbols<CR>")
vim.keymap.set("n", "<C-T>", "<cmd>Telescope lsp_workspace_symbols<CR>")
vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>")

lvim.keys.normal_mode["<C-K>"] = false
lvim.builtin.which_key.mappings["/"] = nil
lvim.builtin.which_key.mappings["c"] = nil
lvim.builtin.which_key.mappings["f"] = nil
lvim.builtin.which_key.mappings["h"] = nil
lvim.builtin.which_key.mappings["w"] = nil
lvim.builtin.which_key.mappings["b<Tab>"] = { ":try | b# | catch | endtry<CR>", "Switch" }
lvim.builtin.which_key.mappings["bs"] = { "<cmd>Telescope buffers<CR>", "Search" }
lvim.builtin.which_key.mappings["bP"] = { "<cmd>BufferLineTogglePin<CR>", "Pin" }
lvim.builtin.which_key.mappings["bw"] = { "<cmd>noautocmd w<CR>", "Save without format" }
lvim.builtin.which_key.mappings["bW"] = nil
lvim.builtin.which_key.mappings["bd"] = { "<cmd>BufferKill<CR>", "Delete" }
vim.keymap.set("n", "H", "<cmd>BufferLineCyclePrev<CR>")
vim.keymap.set("n", "L", "<cmd>BufferLineCycleNext<CR>")
vim.keymap.set("n", "<C-K><C-O>", "<cmd>Telescope projects<CR>")
vim.keymap.set("n", "<C-K>o", ":e <C-R>=fnamemodify(expand('%:p'), ':p:h')<CR>/")
vim.keymap.set("n", "<C-K>n", "<cmd>enew<CR>")
vim.keymap.set("n", "<C-K>r", "<cmd>Telescope oldfiles<CR>")
vim.keymap.set("n", "<C-P>", "<cmd>Telescope find_files hidden=true<CR>")
vim.keymap.set("n", "<C-S>", "<cmd>w<CR>")
vim.keymap.set("n", "<C-S-S>", ":saveas <C-R>=fnamemodify('.',':p')<CR>")
vim.keymap.set("n", "<C-K>s", "<cmd>wa<CR>")
vim.keymap.set("n", "<C-K>u", "<cmd>set noconfirm<CR>:try | %bd | catch | endtry<CR><cmd>set confirm<CR>",
  { silent = true })
vim.keymap.set("n", "<C-K>w", "<cmd>%bd<CR>")
vim.keymap.set("n", "<Tab>", "<cmd>wincmd w<CR>")
vim.keymap.set("n", "<S-Tab>", "<cmd>wincmd W<CR>")
vim.keymap.set("n", "<C-W>z", function()
  local cur_win = vim.api.nvim_get_current_win()
  vim.api.nvim_set_var("non_float_total", 0)
  vim.cmd("windo if &buftype != 'nofile' | let g:non_float_total += 1 | endif")
  vim.api.nvim_set_current_win(cur_win or 0)
  if vim.api.nvim_get_var("non_float_total") == 1 then
    if vim.fn.tabpagenr("$") == 1 then
      return
    end
    vim.cmd("tabclose")
  else
    local last_cursor = vim.api.nvim_win_get_cursor(0)
    vim.cmd("tabedit %:p")
    vim.api.nvim_win_set_cursor(0, last_cursor)
  end
end)
lvim.builtin.which_key.mappings["q"] = { "<cmd>call SmartClose()<CR>", "Quit" }

vim.keymap.set("n", "<C-S-E>", "<cmd>NvimTreeFindFile<CR>")
vim.keymap.set("n", "<C-S-M>", "<cmd>Trouble workspace_diagnostics<CR>")
vim.keymap.set("n", "<C-S-U>", "<cmd>lua require('telescope').extensions.notify.notify()<CR>")

vim.keymap.set("n", "<M-e>", "<cmd>call Open_file_in_explorer()<CR>")
vim.keymap.set("n", "<M-z>", "<cmd>let &wrap=!&wrap<CR>")
vim.keymap.set("n", "<C-S-P>", "<cmd>Telescope commands<CR>")
vim.keymap.set("n", "<C-K><C-S>", "<cmd>Telescope keymaps<CR>")

lvim.builtin.which_key.mappings["sT"] = { "<cmd>TodoTelescope<CR>", "TODOs" }

vim.cmd([[
function! SmartClose() abort
  if &bt ==# 'nofile' || &bt ==# 'quickfix'
    quit
    return
  endif
  let num = winnr('$')
  for i in range(1, num)
    let buftype = getbufvar(winbufnr(i), '&buftype')
    if buftype ==# 'quickfix' || buftype ==# 'nofile'
      let num = num - 1
    elseif getwinvar(i, '&previewwindow') == 1 && winnr() !=# i
      let num = num - 1
    endif
  endfor
  if num == 1
    if len(getbufinfo({'buflisted':1,'bufloaded':1,'bufmodified':1})) > 0
      echohl WarningMsg
      echon 'There are some buffer modified! Quit/Save/Cancel'
      let rs = nr2char(getchar())
      echohl None
      if rs ==? 'q'
        qall!
      elseif rs ==? 's' || rs ==? 'w'
        redraw
        wall
        qall
      else
        redraw
        echohl ModeMsg
        echon 'canceled!'
        echohl None
      endif
    else
      qall
    endif
  else
    quit
  endif
endf

function! Open_file_in_explorer() abort
  if has('win32') || has('wsl')
    call jobstart('explorer.exe .')
  elseif has('unix')
    call jobstart('xdg-open .')
  endif
endf
]])
