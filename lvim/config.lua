----------------------------------------
-- GENERAL
----------------------------------------
vim.opt.timeoutlen = 350
vim.opt.guicursor = 'n:block-blinkon10,i-ci:ver25-blinkon10,c:hor20-blinkon10,v-sm:block,ve:ver25,r-cr-o:hor20'
vim.opt.relativenumber = true
vim.opt.list = true
vim.opt.listchars = 'tab:→ ,eol:↵,trail:·,extends:↷,precedes:↶'
vim.opt.clipboard = ''
vim.opt.swapfile = true
vim.opt.directory = join_paths(get_cache_dir(), "swap")
vim.o.guifont = "NerdCodePro Font:h10"
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "onedarker"

----------------------------------------
-- KEYMAPPINGS
----------------------------------------
lvim.leader = "space"
-- 光标移动
vim.api.nvim_set_keymap('c', '<C-a>', '<C-b>', { noremap = true })
vim.api.nvim_set_keymap('i', '<C-e>', '<End>', { noremap = true })
vim.api.nvim_set_keymap('v', '<C-e>', '$', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-e>', '$', { noremap = true })
-- 全文搜索
vim.api.nvim_set_keymap('n', '<Bs>', '<Cmd>nohl<Cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<Cmd>nohl<Cr><C-l>', { noremap = true })
vim.api.nvim_set_keymap('n', 'n', "'Nn'[v:searchforward]", { noremap = true, expr = true })
vim.api.nvim_set_keymap('n', 'N', "'nN'[v:searchforward]", { noremap = true, expr = true })
vim.api.nvim_set_keymap('c', '<M-c>', "\\<\\><Left><Left>", { noremap = true })
vim.api.nvim_set_keymap('n', '<C-f>', '<Cmd>Telescope current_buffer_fuzzy_find<Cr>', { noremap = true })
vim.cmd([[
  function! s:VSetSearch() abort
    let temp = @s
    norm! gv"sy
    let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g')
    let @s = temp
  endf
  vnoremap <C-h> :<C-u>call <SID>VSetSearch()<CR>:,$s/<C-R>=@/<CR>//gc<left><left><left>
  nnoremap <C-h> viw:<C-u>call <SID>VSetSearch()<CR>:,$s/<C-R>=@/<CR>//gc<left><left><left>
]])
-- terminal map: ctrl+shift+f -> alt+f
vim.api.nvim_set_keymap('n', '<M-f>', '<Cmd>Telescope live_grep<Cr>', { noremap = true })
-- 标签跳转
-- terminal map: ctrl+i -> alt+shift+i
vim.api.nvim_set_keymap('n', '<M-I>', '<C-i>', { noremap = true })
-- 插入编辑
vim.api.nvim_set_keymap('n', '<', '<<', { noremap = true })
vim.api.nvim_set_keymap('n', '>', '>>', { noremap = true })
-- terminal map: ctrl+shift+j -> alt+shift+j
vim.api.nvim_set_keymap('i', '<M-J>', '<Cmd>m .+1<CR><Cmd>normal ==<Cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<M-J>', '<Cmd>m .+1<CR><Cmd>normal ==<Cr>', { noremap = true })
-- terminal map: ctrl+shift+k -> alt+shift+k
vim.api.nvim_set_keymap('i', '<M-K>', '<Cmd>m .-2<CR><Cmd>normal ==<Cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<M-K>', '<Cmd>m .-2<CR><Cmd>normal ==<Cr>', { noremap = true })
vim.api.nvim_set_keymap('i', '<C-j>', '<End><Cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-j>', '<Cmd>put =repeat(nr2char(10), v:count1)<CR>', { noremap = true })
vim.api.nvim_set_keymap('i', '<C-k>', "repeat('<Del>', strchars(getline('.')) - getcurpos()[2] + 1)", { noremap = true, expr = true })
vim.api.nvim_set_keymap('c', '<C-k>', "repeat('<Del>', strchars(getcmdline()) - getcmdpos() + 1)", { noremap = true, expr = true })
vim.api.nvim_set_keymap('i', '<C-l>', '<C-Right>', { noremap = true })
vim.api.nvim_set_keymap('c', '<C-l>', '<C-Right>', { noremap = true })
vim.api.nvim_set_keymap('i', '<C-z>', '<Cmd>undo<Cr>', { noremap = true })
vim.api.nvim_set_keymap('i', '<C-r><C-r>', '<Cmd>redo<Cr>', { noremap = true })
-- 复制粘贴
vim.api.nvim_set_keymap('n', 'Y', 'y$', { noremap = true })
vim.api.nvim_set_keymap('v', '=p', '"0p', { noremap = true })
vim.api.nvim_set_keymap('n', '=p', '"0p', { noremap = true })
vim.api.nvim_set_keymap('n', '=P', '"0P', { noremap = true })
vim.api.nvim_set_keymap('n', '=o', '<Cmd>put =@0<Cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '=O', '<Cmd>put! =@0<Cr>', { noremap = true })
vim.api.nvim_set_keymap('v', '<Space>y', '"+y', { noremap = true })
vim.api.nvim_set_keymap('v', '<Space>p', '"+p', { noremap = true })
lvim.builtin.which_key.mappings["<Space>"] = { "<Cmd>let @+ = @0<Cr>", "Copy Register 0 to Clipboard" }
lvim.builtin.which_key.mappings["y"] = { '"+y', "Yank to Clipboard" }
lvim.builtin.which_key.mappings["Y"] = { '"+y$', "Yank All Right to Clipboard" }
lvim.builtin.which_key.mappings["p"] = { '"+p', "Paste Clipboard After Cursor" }
lvim.builtin.which_key.mappings["P"] = { '"+P', "Paste Clipboard Before Cursor" }
lvim.builtin.which_key.mappings["o"] = { "<Cmd>put =@+<Cr>", "Paste Clipboard to Next Line" }
lvim.builtin.which_key.mappings["O"] = { "<Cmd>put! =@+<Cr>", "Paste Clipboard to Previous Line" }
lvim.builtin.which_key.mappings["by"] = { "<Cmd>%y +<Cr>", "Yank Whole Buffer to Clipboard" }
lvim.builtin.which_key.mappings["bp"] = { "<Cmd>%d<Cr>\"+P", "Patse Clipboard to Whole Buffer" }
-- 文件操作
lvim.keys.normal_mode["<C-k>"] = false
vim.api.nvim_set_keymap('n', '<C-k><C-o>', '<Cmd>Telescope projects<Cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-k>o', ":e <C-r>=expand('%:p')<Cr>", { noremap = true })
vim.api.nvim_set_keymap('n', '<C-k>n', '<Cmd>enew<Cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-k>r', '<Cmd>Telescope oldfiles<Cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-p>', '<Cmd>Telescope find_files<Cr>', { noremap = true })
lvim.builtin.which_key.mappings["<Tab>"] = { ":try | b# | catch | endtry<Cr>", "Switch Buffer" }
vim.api.nvim_set_keymap('n', '<C-s>', '<Cmd>w<Cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-k>s', '<Cmd>wa<Cr>', { noremap = true })
vim.cmd([[
function! s:save_as_new_file() abort
  let current_fname = bufname()
  let separator = has('win32') ? '\' : '/'
  if !empty(current_fname)
    let dir = fnamemodify(current_fname, ':h') . separator
  else
    let dir = getcwd() . separator
  endif
  let input = input('save as: ', dir, 'file')
  noautocmd normal! :
  if !empty(input)
    exe 'silent! write ' . input
    exe 'e ' . input
    if v:errmsg !=# ''
      echohl ErrorMsg
      echo  v:errmsg
      echohl None
    else
      echohl Delimiter
      echo  fnamemodify(bufname(), ':.:gs?[\\/]?/?') . ' written'
      echohl None
    endif
  else
    echo 'canceled!'
  endif
endfunction
nnoremap <M-S> <Cmd>call <SID>save_as_new_file()<Cr>
]])
vim.api.nvim_set_keymap('n', '<C-k>x', '<Cmd>BufferKill<Cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-k>u', ':try | %bd | catch | endtry<Cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-k>w', '<Cmd>%bd<Cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Tab>', '<Cmd>wincmd w<Cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<S-Tab>', '<Cmd>wincmd p<Cr>', { noremap = true })
-- 语言服务
lvim.builtin.cmp.mapping["<C-j>"] = nil
lvim.builtin.cmp.mapping["<C-k>"] = nil
lvim.builtin.cmp.mapping["<C-e>"] = nil
lvim.builtin.cmp.confirm_opts.select = true
local cmp = require("cmp")
local luasnip = require("luasnip")
local lccm = require("lvim.core.cmp").methods
-- terminal map: ctrl+i -> alt+shift+i
lvim.builtin.cmp.mapping["<M-I>"] = cmp.mapping.complete()
lvim.builtin.cmp.mapping["<Tab>"] = cmp.mapping(function(fallback)
  if luasnip.expandable() then
    luasnip.expand()
  elseif lccm.jumpable() then
    luasnip.jump(1)
  elseif cmp.visible() then
    cmp.confirm(lvim.builtin.cmp.confirm_opts)
  elseif lccm.check_backspace() then
    fallback()
  elseif lccm.is_emmet_active() then
    return vim.fn["cmp#complete"]()
  else
    fallback()
  end
end, { "i", "s", }
)
vim.api.nvim_set_keymap('n', '<C-_>', 'gcc', {})
vim.api.nvim_set_keymap('i', '<C-_>', '<Cmd>normal gcc<Cr>', {})
vim.api.nvim_set_keymap('n', '<F2>', "<Cmd>lua require('which-key').execute(3)<CR>", { noremap = true })
-- terminal map: ctrl+. -> alt+.
vim.api.nvim_set_keymap('n', '<M-.>', '<Cmd>lua vim.lsp.buf.code_action()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<M-F>', '<Cmd>lua require("lvim.lsp.utils").format()<Cr>', { noremap = true })
vim.api.nvim_set_keymap('i', '<M-F>', '<Cmd>lua require("lvim.lsp.utils").format()<Cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-t>', '<Cmd>Telescope lsp_workspace_symbols<Cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '[e', "<Cmd>lua vim.diagnostic.goto_prev()<CR>", { noremap = true })
vim.api.nvim_set_keymap('n', ']e', "<Cmd>lua vim.diagnostic.goto_next()<CR>", { noremap = true })
vim.api.nvim_set_keymap('n', '[h', "<Cmd>Gitsigns next_hunk<CR>", { noremap = true })
vim.api.nvim_set_keymap('n', ']h', "<Cmd>Gitsigns prev_hunk<CR>", { noremap = true })
-- 界面元素
-- terminal map: ctrl+shift+n -> alt+shift+n
vim.api.nvim_set_keymap('n', '<M-N>', "<Cmd>lua require('telescope').extensions.notify.notify()<Cr>", { noremap = true })
-- terminal map: ctrl+shift+p -> alt+shift+p
vim.api.nvim_set_keymap('n', '<M-P>', "<Cmd>Telescope commands<Cr>", { noremap = true })
vim.api.nvim_set_keymap('n', '<C-k><C-s>', "<Cmd>Telescope keymaps<Cr>", { noremap = true })
vim.api.nvim_set_keymap('n', '<M-z>', "<Cmd>let &wrap=!&wrap<Cr>", { noremap = true })
vim.cmd([[
function! s:open_file_in_explorer() abort
  if has('win32') || has('wsl')
    call jobstart('explorer.exe .')
  elseif has('unix')
    call jobstart('xdg-open .')
  endif
endf
nnoremap <M-E> <Cmd>call <SID>open_file_in_explorer()<Cr>
]])
-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
local _, actions = pcall(require, "telescope.actions")
lvim.builtin.telescope.defaults.mappings = {
  -- for input mode
  i = {
    ["<Esc>"] = actions.close,
    ["<C-b>"] = actions.preview_scrolling_up,
    ["<C-u>"] = nil
  },
  -- for normal mode
  n = {
  },
}
-- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }


----------------------------------------
-- TODO: User Config for predefined plugins
----------------------------------------
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.alpha.dashboard.section.buttons.entries[1][1] = "Ctrl+K n"
lvim.builtin.alpha.dashboard.section.buttons.entries[1][2] = "  New File"
lvim.builtin.alpha.dashboard.section.buttons.entries[1][3] = "<CMD>ene!<CR>"
lvim.builtin.alpha.dashboard.section.buttons.entries[2][1] = "Ctrl+P"
lvim.builtin.alpha.dashboard.section.buttons.entries[2][2] = "  Find File"
lvim.builtin.alpha.dashboard.section.buttons.entries[2][3] = "<CMD>Telescope find_files<CR>"
lvim.builtin.alpha.dashboard.section.buttons.entries[3][1] = "Ctrl+K Ctrl+O"
lvim.builtin.alpha.dashboard.section.buttons.entries[3][2] = "  Recent Projects "
lvim.builtin.alpha.dashboard.section.buttons.entries[3][3] = "<CMD>Telescope projects<CR>"
lvim.builtin.alpha.dashboard.section.buttons.entries[4][1] = "Ctrl+K r"
lvim.builtin.alpha.dashboard.section.buttons.entries[4][2] = "  Recently Used Files"
lvim.builtin.alpha.dashboard.section.buttons.entries[4][3] = "<CMD>Telescope oldfiles<CR>"
lvim.builtin.alpha.dashboard.section.buttons.entries[5][1] = "SPC S l"
lvim.builtin.alpha.dashboard.section.buttons.entries[5][2] = "  Restore Session"
lvim.builtin.alpha.dashboard.section.buttons.entries[5][3] = "<CMD>lua require('persistence').load({ last = true })<CR>"
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = false
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.show_icons.git = 1
lvim.builtin.bufferline.options.always_show_bufferline = true
local components = require("lvim.core.lualine.components")
lvim.builtin.lualine.options = { globalstatus = true }
lvim.builtin.lualine.sections.lualine_a = {
  {
    '',
    separator = { right = '' },
    type = 'stl'
  }
}
lvim.builtin.lualine.sections.lualine_b = {
  function()
    return "  " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t") .. " "
  end,
  {
    'branch',
    separator = { right = ' ' }
  },
}
lvim.builtin.lualine.sections.lualine_x = {
  components.diagnostics,
  {
    function(msg)
      local lsp = components.lsp[1](msg)
      if lsp == 'LS Inactive' then
        return '[LS Inactive]'
      else
        return '  ' .. lsp:gsub("^%[(.-)%]$", "%1")
      end
    end,
    color = components.lsp.color,
    cond = components.lsp.cond,
  },
  components.treesitter,
  components.filetype,
  "fileformat"
}
lvim.builtin.lualine.sections.lualine_y = {
  { ' %l/%L  %c', type = 'stl' }
}
-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.highlight.enabled = true
lvim.builtin.treesitter.rainbow.enable = true
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "vim",
  "lua",
  "c",
  "cpp",
  "cmake",
  "go",
  "python",
  "javascript",
  "typescript",
  "tsx",
  "html",
  "css",
  "markdown",
  "json",
  "yaml",
}


----------------------------------------
-- generic LSP settings
----------------------------------------

-- ---@usage disable automatic installation of servers
-- lvim.lsp.automatic_servers_installation = false

-- ---configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
-- ---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. !!Requires `:LvimCacheReset` to take effect!!
-- ---`:LvimInfo` lists which server(s) are skiipped for the current filetype
-- vim.tbl_map(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   { command = "black", filetypes = { "python" } },
--   { command = "isort", filetypes = { "python" } },
--   {
--     -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "prettier",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--print-with", "100" },
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "typescript", "typescriptreact" },
--   },
-- }

-- -- set additional linters
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "shellcheck",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--severity", "warning" },
--   },
--   {
--     command = "codespell",
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "javascript", "python" },
--   },
-- }

----------------------------------------
-- Additional Plugins
-- Tip 1. Don't use keys to lazy load an set key maps in setup, packer.nvim will unmap your keys
-- Tip 2. When you need to map keys to command, use cmd lazy load an set key maps in setup
----------------------------------------
lvim.plugins = {
  {
    "karb94/neoscroll.nvim",
    event = "WinScrolled",
    config = function()
      require('neoscroll').setup({
        mappings = { '<C-d>', 'zz' },
        respect_scrolloff = true,
        easing_function = "circular", -- quadratic, cubic, quartic, quintic, circular, sine
      })
      vim.api.nvim_set_keymap("n", "<C-b>", "<Cmd>lua require('neoscroll').scroll(-vim.wo.scroll, true, 250)<CR>", { noremap = true })
      vim.api.nvim_set_keymap("v", "<C-b>", "<Cmd>lua require('neoscroll').scroll(-vim.wo.scroll, true, 250)<CR>", { noremap = true })
      vim.api.nvim_set_keymap("s", "<C-b>", "<Cmd>lua require('neoscroll').scroll(-vim.wo.scroll, true, 250)<CR>", { noremap = true })
    end
  }, {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufRead",
    setup = function()
      vim.g.indentLine_enabled = 1
      vim.g.indent_blankline_char = "▏"
      vim.g.indent_blankline_filetype_exclude = { "help", "terminal", "dashboard", "alpha" }
      vim.g.indent_blankline_buftype_exclude = { "terminal" }
      vim.g.indent_blankline_show_trailing_blankline_indent = false
      vim.g.indent_blankline_show_first_indent_level = false
    end
  }, {
    "rhysd/clever-f.vim",
    keys = { "f", "F", "t", "T" },
    setup = function()
      vim.g.clever_f_smart_case = 1
      vim.g.clever_f_fix_key_direction = 1
    end
  }, {
    'phaazon/hop.nvim',
    cmd = "Hop*",
    branch = 'v1', -- optional but strongly recommended
    setup = function()
      vim.api.nvim_set_keymap("", ";", "<Cmd>HopChar2<Cr>", { noremap = true })
      vim.api.nvim_set_keymap("", ",", "<Cmd>HopLineStartMW<Cr>", { noremap = true })
    end,
    config = function()
      require("hop").setup({
        char2_fallback_key = "<Esc>"
      })
    end
  }, {
    "bronson/vim-visual-star-search",
    keys = { { "v", "*" }, { "v", "#" }, { "v", "g*" }, { "v", "g#" } },
  }, {
    "romainl/vim-cool",
    event = "CursorMoved"
  }, {
    "windwp/nvim-spectre",
    -- terminal map: ctrl+shift+h -> alt+shift+h
    keys = { "<M-H>" },
    config = function()
      require("spectre").setup({
        line_sep_start = '╭─────────────────────────────────────────────────────────',
        result_padding = '│  ',
        line_sep       = '╰─────────────────────────────────────────────────────────',
        mapping        = {
          ['run_replace'] = {
            -- terminal map: ctrl+alt+enter -> alt+enter
            map = "<M-CR>",
            cmd = "<cmd>lua require('spectre.actions').run_replace()<CR>",
            desc = "replace all"
          },
          ['toggle_ignore_case'] = {
            map = "<M-c>",
            cmd = "<cmd>lua require('spectre').change_options('ignore-case')<CR>",
            desc = "toggle ignore case"
          },
        }
      })
      vim.api.nvim_set_keymap('n', '<M-H>', ":lua require('spectre').open_visual({select_word=true})<CR>", { noremap = true, silent = true })
    end
  }, {
    "ethanholz/nvim-lastplace",
    event = "BufRead",
    config = function()
      require("nvim-lastplace").setup({
        lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
        lastplace_ignore_filetype = {
          "gitcommit", "gitrebase", "svn", "hgcommit",
        },
        lastplace_open_folds = true,
      })
    end,
  }, {
    "MattesGroeger/vim-bookmarks",
    event = "BufRead",
    setup = function()
      vim.g.bookmark_sign = ''
      vim.g.bookmark_annotation_sign = ''
      vim.g.bookmark_auto_save_file = join_paths(get_cache_dir(), "bookmark")
    end,
    config = function()
      vim.cmd [[hi link BookmarkSign SignColumn]]
      vim.cmd [[hi link BookmarkAnnotationSign SignColumn]]
      vim.api.nvim_set_keymap('n', 'ma', '', {})
      vim.api.nvim_set_keymap('n', 'mx', '', {})
      vim.api.nvim_set_keymap('n', 'mC', '<Cmd>BookmarkClearAll<Cr>', { noremap = true })
    end
  }, {
    "tom-anders/telescope-vim-bookmarks.nvim",
    keys = { "ml", "mL" },
    config = function()
      require('telescope').load_extension('vim_bookmarks')
      vim.api.nvim_set_keymap('n', 'ml', '<Cmd>lua require("telescope").extensions.vim_bookmarks.current_file()<Cr>', { noremap = true })
      vim.api.nvim_set_keymap('n', 'mL', '<Cmd>lua require("telescope").extensions.vim_bookmarks.all()<Cr>', { noremap = true })
    end
  },
  { "terryma/vim-expand-region",
    keys = { { "v", "v" }, { "v", "V" } },
    config = function()
      vim.api.nvim_set_keymap('v', 'v', '<Plug>(expand_region_expand)', {})
      vim.api.nvim_set_keymap('v', 'V', '<Plug>(expand_region_shrink)', {})
    end
  },
  { 'kana/vim-textobj-user' },
  { 'kana/vim-textobj-entire' },
  { 'kana/vim-textobj-function' },
  { 'kana/vim-textobj-indent' },
  { 'kana/vim-textobj-line' },
  { 'sgur/vim-textobj-parameter' },
  { "tpope/vim-repeat" },
  {
    "tpope/vim-surround",
    keys = { "c", "d", "y" }
  },
  {
    "lambdalisue/suda.vim",
    cmd = { "SudaRead", "SudaWrite" },
    setup = function()
      vim.api.nvim_set_keymap('n', '<M-s>', '<Cmd>SudaWrite<Cr>', { noremap = true })
    end
  }, {
    "benfowler/telescope-luasnip.nvim",
    keys = { "<M-i>" },
    config = function()
      require('telescope').load_extension('luasnip')
      vim.api.nvim_set_keymap('n', '<M-i>', "<Cmd>lua require'telescope'.extensions.luasnip.luasnip{}<Cr>", { noremap = true })
      vim.api.nvim_set_keymap('i', '<M-i>', "<Cmd>lua require'telescope'.extensions.luasnip.luasnip{}<Cr>", { noremap = true })
    end
  }, {
    "ray-x/lsp_signature.nvim",
    event = "InsertEnter",
    config = function()
      require "lsp_signature".setup()
    end
  }, {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    setup = function()
      -- terminal map: ctrl+shift+o -> alt+shift+o
      vim.api.nvim_set_keymap('n', '<M-O>', '<Cmd>SymbolsOutline<Cr>', { noremap = true })
    end
  }, {
    "folke/trouble.nvim",
    cmd = { "Trouble*" },
    setup = function()
      -- terminal map: ctrl+shift+m -> alt+shift+m
      vim.api.nvim_set_keymap('n', '<M-M>', "<Cmd>TroubleToggle<Cr>", { noremap = true })
    end
  }, {
    "folke/persistence.nvim",
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    module = "persistence",
    setup = function()
      lvim.builtin.which_key.mappings["S"] = {
        name = "Session",
        c = { "<cmd>lua require('persistence').load()<cr>", "Restore last session for current dir" },
        l = { "<cmd>lua require('persistence').load({ last = true })<cr>", "Restore last session" },
        Q = { "<cmd>lua require('persistence').stop()<cr>", "Quit without saving session" },
      }
    end,
    config = function()
      require("persistence").setup {
        dir = join_paths(get_cache_dir(), "session"),
        options = { "buffers", "curdir", "tabpages", "winsize" },
      }
    end,
  }, {
    "voldikss/vim-translator",
    cmd = { "Translate*" },
    setup = function()
      vim.g.translator_default_engines = { 'bing', 'youdao' }
      vim.api.nvim_set_keymap('n', '<M-t>', '<Cmd>TranslateW<Cr>', { noremap = true })
      vim.api.nvim_set_keymap('v', '<M-t>', ':TranslateW<Cr>', { noremap = true, silent = true })
    end,
  }, {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({ "*" }, {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        rgb_fn = true, -- CSS rgb() and rgba() functions
        hsl_fn = true, -- CSS hsl() and hsla() functions
        css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
      })
    end,
  },
  {
    "mg979/vim-visual-multi",
    keys = {
      { "n", "<C-n>" },
      { "v", "<C-n>" },
      { "n", "<M-L>" },
      { "v", "<M-L>" },
      { "n", "ma" },
      { "v", "ma" }
    },
    setup = function()
      vim.cmd [[
        function! VM_Start()
          iunmap <buffer><Bs>
        endf
        function! VM_Exit()
          exe 'inoremap <buffer><expr><BS> v:lua.MPairs.autopairs_bs('.bufnr().')'
        endf
      ]]
    end,
    config = function()
      -- terminal map: ctrl+shift+l -> alt+shift+l
      vim.api.nvim_set_keymap('n', '<M-L>', '<Plug>(VM-Select-All)', {})
      vim.api.nvim_set_keymap('v', '<M-L>', '<Plug>(VM-Visual-All)', {})
      vim.api.nvim_set_keymap('n', 'ma', '<Plug>(VM-Add-Cursor-At-Pos)', {})
      vim.api.nvim_set_keymap('v', 'ma', '<Plug>(VM-Visual-Add)', {})
    end
  }, {
    "fedorenchik/VimCalc3",
    cmd = { "Calc" }
  }, {
    "folke/todo-comments.nvim",
    event = "BufRead",
    config = function()
      require("todo-comments").setup()
    end,
  },
}

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- vim.cmd [[
--   function! AutoOpenAlpha()
--     let bufs = getbufinfo({'buflisted':1})
--     let g:fuck_bufs = bufs
--     let g:fuck_bufnr = bufnr()
--     if len(bufs) == 1 && bufnr() == bufs[0].bufnr
--       Alpha
--     endif
--   endf
-- ]]
-- lvim.autocommands.custom_groups = {
-- { "BufUnload", "*", [[call AutoOpenAlpha()]] },
-- }
