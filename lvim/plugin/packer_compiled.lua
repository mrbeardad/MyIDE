-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/beardad/.cache/lvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/beardad/.cache/lvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/beardad/.cache/lvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/beardad/.cache/lvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/beardad/.cache/lvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["Comment.nvim"] = {
    after_files = { "/home/beardad/.local/share/lunarvim/site/pack/packer/opt/Comment.nvim/after/plugin/Comment.lua" },
    config = { "\27LJ\2\2?\0\0\2\0\3\0\0066\0\0\0'\1\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\22lvim.core.comment\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/beardad/.local/share/lunarvim/site/pack/packer/opt/Comment.nvim",
    url = "https://github.com/numToStr/Comment.nvim"
  },
  ["FixCursorHold.nvim"] = {
    loaded = true,
    path = "/home/beardad/.local/share/lunarvim/site/pack/packer/start/FixCursorHold.nvim",
    url = "https://github.com/antoinemadec/FixCursorHold.nvim"
  },
  LuaSnip = {
    config = { "\27LJ\2\2�\3\0\0\t\0\18\2-6\0\0\0'\1\1\0B\0\2\0024\1\3\0009\2\2\0006\3\3\0B\3\1\2'\4\4\0'\5\5\0'\6\6\0'\a\a\0'\b\b\0B\2\a\0?\2\0\0009\2\2\0006\3\t\0B\3\1\2'\4\n\0B\2\3\0029\3\v\0\18\4\2\0B\3\2\2\15\0\3\0X\4\3�\21\3\1\0\22\3\1\3<\2\3\0016\3\0\0'\4\f\0B\3\2\0029\3\r\3B\3\1\0016\3\0\0'\4\14\0B\3\2\0029\3\r\0035\4\15\0=\1\16\4B\3\2\0016\3\0\0'\4\17\0B\3\2\0029\3\r\3B\3\1\1K\0\1\0\"luasnip.loaders.from_snipmate\npaths\1\0\0 luasnip.loaders.from_vscode\14lazy_load\29luasnip.loaders.from_lua\17is_directory\rsnippets\19get_config_dir\22friendly-snippets\nstart\vpacker\tpack\tsite\20get_runtime_dir\15join_paths\15lvim.utils\frequire\3����\4\2\0" },
    loaded = true,
    path = "/home/beardad/.local/share/lunarvim/site/pack/packer/start/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  VimCalc3 = {
    commands = { "Calc" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/beardad/.local/share/lunarvim/site/pack/packer/opt/VimCalc3",
    url = "https://github.com/fedorenchik/VimCalc3"
  },
  ["alpha-nvim"] = {
    config = { "\27LJ\2\2=\0\0\2\0\3\0\0066\0\0\0'\1\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\20lvim.core.alpha\frequire\0" },
    loaded = true,
    path = "/home/beardad/.local/share/lunarvim/site/pack/packer/start/alpha-nvim",
    url = "https://github.com/goolord/alpha-nvim"
  },
  ["bufferline.nvim"] = {
    config = { "\27LJ\2\2B\0\0\2\0\3\0\0066\0\0\0'\1\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\25lvim.core.bufferline\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/beardad/.local/share/lunarvim/site/pack/packer/opt/bufferline.nvim",
    url = "https://github.com/akinsho/bufferline.nvim"
  },
  ["clever-f.vim"] = {
    keys = { { "", "f" }, { "", "F" }, { "", "t" }, { "", "T" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/beardad/.local/share/lunarvim/site/pack/packer/opt/clever-f.vim",
    url = "https://github.com/rhysd/clever-f.vim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/home/beardad/.local/share/lunarvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/home/beardad/.local/share/lunarvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/home/beardad/.local/share/lunarvim/site/pack/packer/start/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  cmp_luasnip = {
    loaded = true,
    path = "/home/beardad/.local/share/lunarvim/site/pack/packer/start/cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  ["friendly-snippets"] = {
    loaded = true,
    path = "/home/beardad/.local/share/lunarvim/site/pack/packer/start/friendly-snippets",
    url = "https://github.com/rafamadriz/friendly-snippets"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\2@\0\0\2\0\3\0\0066\0\0\0'\1\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\23lvim.core.gitsigns\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/beardad/.local/share/lunarvim/site/pack/packer/opt/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["hop.nvim"] = {
    commands = { "Hop*" },
    config = { "\27LJ\2\2Q\0\0\2\0\4\0\a6\0\0\0'\1\1\0B\0\2\0029\0\2\0005\1\3\0B\0\2\1K\0\1\0\1\0\1\23char2_fallback_key\n<Esc>\nsetup\bhop\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/beardad/.local/share/lunarvim/site/pack/packer/opt/hop.nvim",
    url = "https://github.com/phaazon/hop.nvim"
  },
  ["indent-blankline.nvim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/beardad/.local/share/lunarvim/site/pack/packer/opt/indent-blankline.nvim",
    url = "https://github.com/lukas-reineke/indent-blankline.nvim"
  },
  ["lsp_signature.nvim"] = {
    config = { "\27LJ\2\2;\0\0\2\0\3\0\0066\0\0\0'\1\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\18lsp_signature\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/beardad/.local/share/lunarvim/site/pack/packer/opt/lsp_signature.nvim",
    url = "https://github.com/ray-x/lsp_signature.nvim"
  },
  ["lua-dev.nvim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/beardad/.local/share/lunarvim/site/pack/packer/opt/lua-dev.nvim",
    url = "https://github.com/max397574/lua-dev.nvim"
  },
  ["lualine.nvim"] = {
    config = { "\27LJ\2\2?\0\0\2\0\3\0\0066\0\0\0'\1\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\22lvim.core.lualine\frequire\0" },
    loaded = true,
    path = "/home/beardad/.local/share/lunarvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["neoscroll.nvim"] = {
    config = { "\27LJ\2\2�\2\0\0\5\0\17\0!6\0\0\0'\1\1\0B\0\2\0029\0\2\0005\1\4\0005\2\3\0=\2\5\1B\0\2\0016\0\6\0009\0\a\0009\0\b\0'\1\t\0'\2\n\0'\3\v\0005\4\f\0B\0\5\0016\0\6\0009\0\a\0009\0\b\0'\1\r\0'\2\n\0'\3\v\0005\4\14\0B\0\5\0016\0\6\0009\0\a\0009\0\b\0'\1\15\0'\2\n\0'\3\v\0005\4\16\0B\0\5\1K\0\1\0\1\0\1\fnoremap\2\6s\1\0\1\fnoremap\2\6v\1\0\1\fnoremap\2H<Cmd>lua require('neoscroll').scroll(-vim.wo.scroll, true, 250)<CR>\n<C-b>\6n\20nvim_set_keymap\bapi\bvim\rmappings\1\0\2\22respect_scrolloff\2\20easing_function\rcircular\1\3\0\0\n<C-d>\azz\nsetup\14neoscroll\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/beardad/.local/share/lunarvim/site/pack/packer/opt/neoscroll.nvim",
    url = "https://github.com/karb94/neoscroll.nvim"
  },
  ["nlsp-settings.nvim"] = {
    loaded = true,
    path = "/home/beardad/.local/share/lunarvim/site/pack/packer/start/nlsp-settings.nvim",
    url = "https://github.com/tamago324/nlsp-settings.nvim"
  },
  ["null-ls.nvim"] = {
    loaded = true,
    path = "/home/beardad/.local/share/lunarvim/site/pack/packer/start/null-ls.nvim",
    url = "https://github.com/jose-elias-alvarez/null-ls.nvim"
  },
  ["nvim-autopairs"] = {
    config = { "\27LJ\2\2A\0\0\2\0\3\0\0066\0\0\0'\1\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\24lvim.core.autopairs\frequire\0" },
    loaded = true,
    path = "/home/beardad/.local/share/lunarvim/site/pack/packer/start/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-cmp"] = {
    config = { "\27LJ\2\2`\0\0\2\0\6\0\v6\0\0\0009\0\1\0009\0\2\0\15\0\0\0X\1\5�6\0\3\0'\1\4\0B\0\2\0029\0\5\0B\0\1\1K\0\1\0\nsetup\18lvim.core.cmp\frequire\bcmp\fbuiltin\tlvim\0" },
    loaded = true,
    path = "/home/beardad/.local/share/lunarvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-colorizer.lua"] = {
    config = { "\27LJ\2\2|\0\0\3\0\5\0\b6\0\0\0'\1\1\0B\0\2\0029\0\2\0005\1\3\0005\2\4\0B\0\3\1K\0\1\0\1\0\a\bcss\2\vrgb_fn\2\rRRGGBBAA\2\vhsl_fn\2\vcss_fn\2\bRGB\2\vRRGGBB\2\1\2\0\0\6*\nsetup\14colorizer\frequire\0" },
    loaded = true,
    path = "/home/beardad/.local/share/lunarvim/site/pack/packer/start/nvim-colorizer.lua",
    url = "https://github.com/norcalli/nvim-colorizer.lua"
  },
  ["nvim-lastplace"] = {
    config = { "\27LJ\2\2�\1\0\0\3\0\b\0\v6\0\0\0'\1\1\0B\0\2\0029\0\2\0005\1\4\0005\2\3\0=\2\5\0015\2\6\0=\2\a\1B\0\2\1K\0\1\0\30lastplace_ignore_filetype\1\5\0\0\14gitcommit\14gitrebase\bsvn\rhgcommit\29lastplace_ignore_buftype\1\0\1\25lastplace_open_folds\2\1\4\0\0\rquickfix\vnofile\thelp\nsetup\19nvim-lastplace\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/beardad/.local/share/lunarvim/site/pack/packer/opt/nvim-lastplace",
    url = "https://github.com/ethanholz/nvim-lastplace"
  },
  ["nvim-lsp-installer"] = {
    loaded = true,
    path = "/home/beardad/.local/share/lunarvim/site/pack/packer/start/nvim-lsp-installer",
    url = "https://github.com/williamboman/nvim-lsp-installer"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/beardad/.local/share/lunarvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-notify"] = {
    config = { "\27LJ\2\2>\0\0\2\0\3\0\0066\0\0\0'\1\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\21lvim.core.notify\frequire\0" },
    loaded = true,
    path = "/home/beardad/.local/share/lunarvim/site/pack/packer/start/nvim-notify",
    url = "https://github.com/rcarriga/nvim-notify"
  },
  ["nvim-spectre"] = {
    config = { "\27LJ\2\2�\6\0\0\5\0\17\0\0216\0\0\0'\1\1\0B\0\2\0029\0\2\0005\1\3\0005\2\5\0005\3\4\0=\3\6\0025\3\a\0=\3\b\2=\2\t\1B\0\2\0016\0\n\0009\0\v\0009\0\f\0'\1\r\0'\2\14\0'\3\15\0005\4\16\0B\0\5\1K\0\1\0\1\0\2\vsilent\2\fnoremap\2@:lua require('spectre').open_visual({select_word=true})<CR>\n<M-H>\6n\20nvim_set_keymap\bapi\bvim\fmapping\23toggle_ignore_case\1\0\3\bmap\n<M-c>\bcmdB<cmd>lua require('spectre').change_options('ignore-case')<CR>\tdesc\23toggle ignore case\16run_replace\1\0\0\1\0\3\bmap\v<M-CR>\bcmd:<cmd>lua require('spectre.actions').run_replace()<CR>\tdesc\16replace all\1\0\3\rline_sep�\1╰─────────────────────────────────────────────────────────\19line_sep_start�\1╭─────────────────────────────────────────────────────────\19result_padding\n│  \nsetup\fspectre\frequire\0" },
    keys = { { "", "<M-H>" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/beardad/.local/share/lunarvim/site/pack/packer/opt/nvim-spectre",
    url = "https://github.com/windwp/nvim-spectre"
  },
  ["nvim-tree.lua"] = {
    config = { "\27LJ\2\2@\0\0\2\0\3\0\0066\0\0\0'\1\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\23lvim.core.nvimtree\frequire\0" },
    loaded = true,
    path = "/home/beardad/.local/share/lunarvim/site/pack/packer/start/nvim-tree.lua",
    url = "https://github.com/kyazdani42/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\2\2B\0\0\2\0\3\0\0066\0\0\0'\1\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\25lvim.core.treesitter\frequire\0" },
    loaded = true,
    path = "/home/beardad/.local/share/lunarvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-ts-context-commentstring"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/beardad/.local/share/lunarvim/site/pack/packer/opt/nvim-ts-context-commentstring",
    url = "https://github.com/JoosepAlviste/nvim-ts-context-commentstring"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/beardad/.local/share/lunarvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["onedarker.nvim"] = {
    config = { "\27LJ\2\2�\1\0\0\2\0\t\0\0196\0\0\0\15\0\0\0X\1\15�6\0\0\0009\0\1\0\a\0\2\0X\0\v�6\0\3\0'\1\2\0B\0\2\0029\0\4\0B\0\1\0016\0\0\0009\0\5\0009\0\6\0009\0\a\0'\1\2\0=\1\b\0K\0\1\0\ntheme\foptions\flualine\fbuiltin\nsetup\frequire\14onedarker\16colorscheme\tlvim\30\1\0\2\0\2\0\0046\0\0\0003\1\1\0B\0\2\1K\0\1\0\0\npcall\0" },
    loaded = true,
    path = "/home/beardad/.local/share/lunarvim/site/pack/packer/start/onedarker.nvim",
    url = "https://github.com/lunarvim/onedarker.nvim"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/beardad/.local/share/lunarvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["persistence.nvim"] = {
    config = { "\27LJ\2\2�\1\0\0\5\0\n\0\0156\0\0\0'\1\1\0B\0\2\0029\0\2\0005\1\6\0006\2\3\0006\3\4\0B\3\1\2'\4\5\0B\2\3\2=\2\a\0015\2\b\0=\2\t\1B\0\2\1K\0\1\0\foptions\1\5\0\0\fbuffers\vcurdir\rtabpages\fwinsize\bdir\1\0\0\fsession\18get_cache_dir\15join_paths\nsetup\16persistence\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/beardad/.local/share/lunarvim/site/pack/packer/opt/persistence.nvim",
    url = "https://github.com/folke/persistence.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/beardad/.local/share/lunarvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/home/beardad/.local/share/lunarvim/site/pack/packer/start/popup.nvim",
    url = "https://github.com/nvim-lua/popup.nvim"
  },
  ["project.nvim"] = {
    config = { "\27LJ\2\2?\0\0\2\0\3\0\0066\0\0\0'\1\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\22lvim.core.project\frequire\0" },
    loaded = true,
    path = "/home/beardad/.local/share/lunarvim/site/pack/packer/start/project.nvim",
    url = "https://github.com/ahmedkhalf/project.nvim"
  },
  ["schemastore.nvim"] = {
    loaded = true,
    path = "/home/beardad/.local/share/lunarvim/site/pack/packer/start/schemastore.nvim",
    url = "https://github.com/b0o/schemastore.nvim"
  },
  ["structlog.nvim"] = {
    loaded = true,
    path = "/home/beardad/.local/share/lunarvim/site/pack/packer/start/structlog.nvim",
    url = "https://github.com/Tastyep/structlog.nvim"
  },
  ["suda.vim"] = {
    commands = { "SudaRead", "SudaWrite" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/beardad/.local/share/lunarvim/site/pack/packer/opt/suda.vim",
    url = "https://github.com/lambdalisue/suda.vim"
  },
  ["symbols-outline.nvim"] = {
    commands = { "SymbolsOutline" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/beardad/.local/share/lunarvim/site/pack/packer/opt/symbols-outline.nvim",
    url = "https://github.com/simrat39/symbols-outline.nvim"
  },
  ["telescope-fzf-native.nvim"] = {
    loaded = true,
    path = "/home/beardad/.local/share/lunarvim/site/pack/packer/start/telescope-fzf-native.nvim",
    url = "https://github.com/nvim-telescope/telescope-fzf-native.nvim"
  },
  ["telescope-luasnip.nvim"] = {
    config = { "\27LJ\2\2�\2\0\0\5\0\r\0\0236\0\0\0'\1\1\0B\0\2\0029\0\2\0'\1\3\0B\0\2\0016\0\4\0009\0\5\0009\0\6\0'\1\a\0'\2\b\0'\3\t\0005\4\n\0B\0\5\0016\0\4\0009\0\5\0009\0\6\0'\1\v\0'\2\b\0'\3\t\0005\4\f\0B\0\5\1K\0\1\0\1\0\1\fnoremap\2\6i\1\0\1\fnoremap\2A<Cmd>lua require'telescope'.extensions.luasnip.luasnip{}<Cr>\n<M-i>\6n\20nvim_set_keymap\bapi\bvim\fluasnip\19load_extension\14telescope\frequire\0" },
    keys = { { "", "<M-i>" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/beardad/.local/share/lunarvim/site/pack/packer/opt/telescope-luasnip.nvim",
    url = "https://github.com/benfowler/telescope-luasnip.nvim"
  },
  ["telescope-vim-bookmarks.nvim"] = {
    config = { "\27LJ\2\2�\2\0\0\5\0\14\0\0236\0\0\0'\1\1\0B\0\2\0029\0\2\0'\1\3\0B\0\2\0016\0\4\0009\0\5\0009\0\6\0'\1\a\0'\2\b\0'\3\t\0005\4\n\0B\0\5\0016\0\4\0009\0\5\0009\0\6\0'\1\a\0'\2\v\0'\3\f\0005\4\r\0B\0\5\1K\0\1\0\1\0\1\fnoremap\2E<Cmd>lua require(\"telescope\").extensions.vim_bookmarks.all()<Cr>\amL\1\0\1\fnoremap\2N<Cmd>lua require(\"telescope\").extensions.vim_bookmarks.current_file()<Cr>\aml\6n\20nvim_set_keymap\bapi\bvim\18vim_bookmarks\19load_extension\14telescope\frequire\0" },
    keys = { { "", "ml" }, { "", "mL" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/beardad/.local/share/lunarvim/site/pack/packer/opt/telescope-vim-bookmarks.nvim",
    url = "https://github.com/tom-anders/telescope-vim-bookmarks.nvim"
  },
  ["telescope.nvim"] = {
    config = { "\27LJ\2\2A\0\0\2\0\3\0\0066\0\0\0'\1\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\24lvim.core.telescope\frequire\0" },
    loaded = true,
    path = "/home/beardad/.local/share/lunarvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["todo-comments.nvim"] = {
    config = { "\27LJ\2\2;\0\0\2\0\3\0\0066\0\0\0'\1\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\18todo-comments\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/beardad/.local/share/lunarvim/site/pack/packer/opt/todo-comments.nvim",
    url = "https://github.com/folke/todo-comments.nvim"
  },
  ["trouble.nvim"] = {
    commands = { "Trouble*" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/beardad/.local/share/lunarvim/site/pack/packer/opt/trouble.nvim",
    url = "https://github.com/folke/trouble.nvim"
  },
  ["vim-bookmarks"] = {
    config = { "\27LJ\2\2�\2\0\0\5\0\r\0!6\0\0\0009\0\1\0'\1\2\0B\0\2\0016\0\0\0009\0\1\0'\1\3\0B\0\2\0016\0\0\0009\0\4\0009\0\5\0'\1\6\0'\2\a\0'\3\b\0004\4\0\0B\0\5\0016\0\0\0009\0\4\0009\0\5\0'\1\6\0'\2\t\0'\3\b\0004\4\0\0B\0\5\0016\0\0\0009\0\4\0009\0\5\0'\1\6\0'\2\n\0'\3\v\0005\4\f\0B\0\5\1K\0\1\0\1\0\1\fnoremap\2\30<Cmd>BookmarkClearAll<Cr>\amC\amx\5\ama\6n\20nvim_set_keymap\bapi.hi link BookmarkAnnotationSign SignColumn$hi link BookmarkSign SignColumn\bcmd\bvim\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/beardad/.local/share/lunarvim/site/pack/packer/opt/vim-bookmarks",
    url = "https://github.com/MattesGroeger/vim-bookmarks"
  },
  ["vim-cool"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/beardad/.local/share/lunarvim/site/pack/packer/opt/vim-cool",
    url = "https://github.com/romainl/vim-cool"
  },
  ["vim-expand-region"] = {
    config = { "\27LJ\2\2�\1\0\0\5\0\a\0\0176\0\0\0009\0\1\0009\0\2\0'\1\3\0'\2\3\0'\3\4\0004\4\0\0B\0\5\0016\0\0\0009\0\1\0009\0\2\0'\1\3\0'\2\5\0'\3\6\0004\4\0\0B\0\5\1K\0\1\0!<Plug>(expand_region_shrink)\6V!<Plug>(expand_region_expand)\6v\20nvim_set_keymap\bapi\bvim\0" },
    keys = { { "v", "v" }, { "v", "V" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/beardad/.local/share/lunarvim/site/pack/packer/opt/vim-expand-region",
    url = "https://github.com/terryma/vim-expand-region"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/home/beardad/.local/share/lunarvim/site/pack/packer/start/vim-repeat",
    url = "https://github.com/tpope/vim-repeat"
  },
  ["vim-surround"] = {
    keys = { { "", "c" }, { "", "d" }, { "", "y" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/beardad/.local/share/lunarvim/site/pack/packer/opt/vim-surround",
    url = "https://github.com/tpope/vim-surround"
  },
  ["vim-textobj-entire"] = {
    loaded = true,
    path = "/home/beardad/.local/share/lunarvim/site/pack/packer/start/vim-textobj-entire",
    url = "https://github.com/kana/vim-textobj-entire"
  },
  ["vim-textobj-function"] = {
    loaded = true,
    path = "/home/beardad/.local/share/lunarvim/site/pack/packer/start/vim-textobj-function",
    url = "https://github.com/kana/vim-textobj-function"
  },
  ["vim-textobj-indent"] = {
    loaded = true,
    path = "/home/beardad/.local/share/lunarvim/site/pack/packer/start/vim-textobj-indent",
    url = "https://github.com/kana/vim-textobj-indent"
  },
  ["vim-textobj-line"] = {
    loaded = true,
    path = "/home/beardad/.local/share/lunarvim/site/pack/packer/start/vim-textobj-line",
    url = "https://github.com/kana/vim-textobj-line"
  },
  ["vim-textobj-parameter"] = {
    loaded = true,
    path = "/home/beardad/.local/share/lunarvim/site/pack/packer/start/vim-textobj-parameter",
    url = "https://github.com/sgur/vim-textobj-parameter"
  },
  ["vim-textobj-user"] = {
    loaded = true,
    path = "/home/beardad/.local/share/lunarvim/site/pack/packer/start/vim-textobj-user",
    url = "https://github.com/kana/vim-textobj-user"
  },
  ["vim-translator"] = {
    commands = { "Translate*" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/beardad/.local/share/lunarvim/site/pack/packer/opt/vim-translator",
    url = "https://github.com/voldikss/vim-translator"
  },
  ["vim-visual-multi"] = {
    config = { "\27LJ\2\2�\1\0\0\5\0\a\0\0176\0\0\0009\0\1\0009\0\2\0'\1\3\0'\2\4\0'\3\5\0004\4\0\0B\0\5\0016\0\0\0009\0\1\0009\0\2\0'\1\6\0'\2\4\0'\3\5\0004\4\0\0B\0\5\1K\0\1\0\6v\26<Plug>(VM-Select-All)\n<M-L>\6n\20nvim_set_keymap\bapi\bvim\0" },
    keys = { { "n", "<C-n>" }, { "v", "<C-n>" }, { "n", "<M-L>" }, { "n", "<M-L>" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/beardad/.local/share/lunarvim/site/pack/packer/opt/vim-visual-multi",
    url = "https://github.com/mg979/vim-visual-multi"
  },
  ["vim-visual-star-search"] = {
    keys = { { "v", "*" }, { "v", "#" }, { "v", "g*" }, { "v", "g#" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/beardad/.local/share/lunarvim/site/pack/packer/opt/vim-visual-star-search",
    url = "https://github.com/bronson/vim-visual-star-search"
  },
  ["which-key.nvim"] = {
    config = { "\27LJ\2\2A\0\0\2\0\3\0\0066\0\0\0'\1\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\24lvim.core.which-key\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/beardad/.local/share/lunarvim/site/pack/packer/opt/which-key.nvim",
    url = "https://github.com/max397574/which-key.nvim"
  }
}

time([[Defining packer_plugins]], false)
local module_lazy_loads = {
  ["^lua%-dev"] = "lua-dev.nvim",
  ["^persistence"] = "persistence.nvim"
}
local lazy_load_called = {['packer.load'] = true}
local function lazy_load_module(module_name)
  local to_load = {}
  if lazy_load_called[module_name] then return nil end
  lazy_load_called[module_name] = true
  for module_pat, plugin_name in pairs(module_lazy_loads) do
    if not _G.packer_plugins[plugin_name].loaded and string.match(module_name, module_pat) then
      to_load[#to_load + 1] = plugin_name
    end
  end

  if #to_load > 0 then
    require('packer.load')(to_load, {module = module_name}, _G.packer_plugins)
    local loaded_mod = package.loaded[module_name]
    if loaded_mod then
      return function(modname) return loaded_mod end
    end
  end
end

if not vim.g.packer_custom_loader_enabled then
  table.insert(package.loaders, 1, lazy_load_module)
  vim.g.packer_custom_loader_enabled = true
end

-- Setup for: hop.nvim
time([[Setup for hop.nvim]], true)
try_loadstring("\27LJ\2\2�\1\0\0\5\0\n\0\0176\0\0\0009\0\1\0009\0\2\0'\1\3\0'\2\4\0'\3\5\0005\4\6\0B\0\5\0016\0\0\0009\0\1\0009\0\2\0'\1\3\0'\2\a\0'\3\b\0005\4\t\0B\0\5\1K\0\1\0\1\0\1\fnoremap\2\28<Cmd>HopLineStartMW<Cr>\6,\1\0\1\fnoremap\2\22<Cmd>HopChar2<Cr>\6;\5\20nvim_set_keymap\bapi\bvim\0", "setup", "hop.nvim")
time([[Setup for hop.nvim]], false)
-- Setup for: symbols-outline.nvim
time([[Setup for symbols-outline.nvim]], true)
try_loadstring("\27LJ\2\2o\0\0\5\0\a\0\t6\0\0\0009\0\1\0009\0\2\0'\1\3\0'\2\4\0'\3\5\0005\4\6\0B\0\5\1K\0\1\0\1\0\1\fnoremap\2\28<Cmd>SymbolsOutline<Cr>\n<M-O>\6n\20nvim_set_keymap\bapi\bvim\0", "setup", "symbols-outline.nvim")
time([[Setup for symbols-outline.nvim]], false)
-- Setup for: indent-blankline.nvim
time([[Setup for indent-blankline.nvim]], true)
try_loadstring("\27LJ\2\2�\2\0\0\2\0\v\0\0256\0\0\0009\0\1\0)\1\1\0=\1\2\0006\0\0\0009\0\1\0'\1\4\0=\1\3\0006\0\0\0009\0\1\0005\1\6\0=\1\5\0006\0\0\0009\0\1\0005\1\b\0=\1\a\0006\0\0\0009\0\1\0+\1\1\0=\1\t\0006\0\0\0009\0\1\0+\1\1\0=\1\n\0K\0\1\0-indent_blankline_show_first_indent_level4indent_blankline_show_trailing_blankline_indent\1\2\0\0\rterminal%indent_blankline_buftype_exclude\1\5\0\0\thelp\rterminal\14dashboard\nalpha&indent_blankline_filetype_exclude\b▏\26indent_blankline_char\23indentLine_enabled\6g\bvim\0", "setup", "indent-blankline.nvim")
time([[Setup for indent-blankline.nvim]], false)
-- Setup for: vim-visual-multi
time([[Setup for vim-visual-multi]], true)
try_loadstring("\27LJ\2\2�\3\0\0\2\0\3\0\0056\0\0\0009\0\1\0'\1\2\0B\0\2\1K\0\1\0�\2        function! VM_Start()\n          let b:autopairs_bs_map_number = substitute(execute('imap <bs>'),'.*autopairs_bs(\\(\\d\\)).*','\\1','')\n          iunmap <buffer><Bs>\n        endf\n        function! VM_Exit()\n          exe 'inoremap <buffer><expr><BS> v:lua.MPairs.autopairs_bs('.b:autopairs_bs_map_number.')'\n          unlet b:autopairs_bs_map_number\n        endf\n      \bcmd\bvim\0", "setup", "vim-visual-multi")
time([[Setup for vim-visual-multi]], false)
-- Setup for: vim-translator
time([[Setup for vim-translator]], true)
try_loadstring("\27LJ\2\2�\1\0\0\5\0\r\0\0216\0\0\0009\0\1\0005\1\3\0=\1\2\0006\0\0\0009\0\4\0009\0\5\0'\1\6\0'\2\a\0'\3\b\0005\4\t\0B\0\5\0016\0\0\0009\0\4\0009\0\5\0'\1\n\0'\2\a\0'\3\v\0005\4\f\0B\0\5\1K\0\1\0\1\0\2\vsilent\2\fnoremap\2\20:TranslateW<Cr>\6v\1\0\1\fnoremap\2\24<Cmd>TranslateW<Cr>\n<M-t>\6n\20nvim_set_keymap\bapi\1\3\0\0\tbing\vyoudao\31translator_default_engines\6g\bvim\0", "setup", "vim-translator")
time([[Setup for vim-translator]], false)
-- Setup for: suda.vim
time([[Setup for suda.vim]], true)
try_loadstring("\27LJ\2\2j\0\0\5\0\a\0\t6\0\0\0009\0\1\0009\0\2\0'\1\3\0'\2\4\0'\3\5\0005\4\6\0B\0\5\1K\0\1\0\1\0\1\fnoremap\2\23<Cmd>SudaWrite<Cr>\n<M-s>\6n\20nvim_set_keymap\bapi\bvim\0", "setup", "suda.vim")
time([[Setup for suda.vim]], false)
-- Setup for: trouble.nvim
time([[Setup for trouble.nvim]], true)
try_loadstring("\27LJ\2\2�\4\0\0\5\0\25\0\0276\0\0\0009\0\1\0009\0\2\0'\1\3\0'\2\4\0'\3\5\0005\4\6\0B\0\5\0016\0\a\0009\0\b\0009\0\t\0009\0\n\0005\1\f\0005\2\r\0=\2\14\0015\2\15\0=\2\16\0015\2\17\0=\2\18\0015\2\19\0=\2\20\0015\2\21\0=\2\22\0015\2\23\0=\2\24\1=\1\v\0K\0\1\0\6w\1\3\0\0+<cmd>Trouble workspace_diagnostics<cr>\26Wordspace Diagnostics\6l\1\3\0\0\29<cmd>Trouble loclist<cr>\17LocationList\6q\1\3\0\0\30<cmd>Trouble quickfix<cr>\rQuickFix\6d\1\3\0\0*<cmd>Trouble document_diagnostics<cr>\16Diagnostics\6f\1\3\0\0%<cmd>Trouble lsp_definitions<cr>\16Definitions\6r\1\3\0\0$<cmd>Trouble lsp_references<cr>\15References\1\0\1\tname\r+Trouble\6t\rmappings\14which_key\fbuiltin\tlvim\1\0\1\fnoremap\2\27<Cmd>TroubleToggle<Cr>\n<M-M>\6n\20nvim_set_keymap\bapi\bvim\0", "setup", "trouble.nvim")
time([[Setup for trouble.nvim]], false)
-- Setup for: clever-f.vim
time([[Setup for clever-f.vim]], true)
try_loadstring("\27LJ\2\2`\0\0\2\0\4\0\t6\0\0\0009\0\1\0)\1\1\0=\1\2\0006\0\0\0009\0\1\0)\1\1\0=\1\3\0K\0\1\0\31clever_f_fix_key_direction\24clever_f_smart_case\6g\bvim\0", "setup", "clever-f.vim")
time([[Setup for clever-f.vim]], false)
-- Setup for: persistence.nvim
time([[Setup for persistence.nvim]], true)
try_loadstring("\27LJ\2\2�\2\0\0\3\0\f\0\r6\0\0\0009\0\1\0009\0\2\0009\0\3\0005\1\5\0005\2\6\0=\2\a\0015\2\b\0=\2\t\0015\2\n\0=\2\v\1=\1\4\0K\0\1\0\6Q\1\3\0\0/<cmd>lua require('persistence').stop()<cr> Quit without saving session\6l\1\3\0\0><cmd>lua require('persistence').load({ last = true })<cr>\25Restore last session\6c\1\3\0\0/<cmd>lua require('persistence').load()<cr>)Restore last session for current dir\1\0\1\tname\fSession\6S\rmappings\14which_key\fbuiltin\tlvim\0", "setup", "persistence.nvim")
time([[Setup for persistence.nvim]], false)
-- Setup for: vim-bookmarks
time([[Setup for vim-bookmarks]], true)
try_loadstring("\27LJ\2\2�\1\0\0\4\0\n\0\0176\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0'\1\5\0=\1\4\0006\0\0\0009\0\1\0006\1\a\0006\2\b\0B\2\1\2'\3\t\0B\1\3\2=\1\6\0K\0\1\0\rbookmark\18get_cache_dir\15join_paths\28bookmark_auto_save_file\b\29bookmark_annotation_sign\b\18bookmark_sign\6g\bvim\0", "setup", "vim-bookmarks")
time([[Setup for vim-bookmarks]], false)
-- Config for: LuaSnip
time([[Config for LuaSnip]], true)
try_loadstring("\27LJ\2\2�\3\0\0\t\0\18\2-6\0\0\0'\1\1\0B\0\2\0024\1\3\0009\2\2\0006\3\3\0B\3\1\2'\4\4\0'\5\5\0'\6\6\0'\a\a\0'\b\b\0B\2\a\0?\2\0\0009\2\2\0006\3\t\0B\3\1\2'\4\n\0B\2\3\0029\3\v\0\18\4\2\0B\3\2\2\15\0\3\0X\4\3�\21\3\1\0\22\3\1\3<\2\3\0016\3\0\0'\4\f\0B\3\2\0029\3\r\3B\3\1\0016\3\0\0'\4\14\0B\3\2\0029\3\r\0035\4\15\0=\1\16\4B\3\2\0016\3\0\0'\4\17\0B\3\2\0029\3\r\3B\3\1\1K\0\1\0\"luasnip.loaders.from_snipmate\npaths\1\0\0 luasnip.loaders.from_vscode\14lazy_load\29luasnip.loaders.from_lua\17is_directory\rsnippets\19get_config_dir\22friendly-snippets\nstart\vpacker\tpack\tsite\20get_runtime_dir\15join_paths\15lvim.utils\frequire\3����\4\2\0", "config", "LuaSnip")
time([[Config for LuaSnip]], false)
-- Config for: nvim-cmp
time([[Config for nvim-cmp]], true)
try_loadstring("\27LJ\2\2`\0\0\2\0\6\0\v6\0\0\0009\0\1\0009\0\2\0\15\0\0\0X\1\5�6\0\3\0'\1\4\0B\0\2\0029\0\5\0B\0\1\1K\0\1\0\nsetup\18lvim.core.cmp\frequire\bcmp\fbuiltin\tlvim\0", "config", "nvim-cmp")
time([[Config for nvim-cmp]], false)
-- Config for: nvim-tree.lua
time([[Config for nvim-tree.lua]], true)
try_loadstring("\27LJ\2\2@\0\0\2\0\3\0\0066\0\0\0'\1\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\23lvim.core.nvimtree\frequire\0", "config", "nvim-tree.lua")
time([[Config for nvim-tree.lua]], false)
-- Config for: alpha-nvim
time([[Config for alpha-nvim]], true)
try_loadstring("\27LJ\2\2=\0\0\2\0\3\0\0066\0\0\0'\1\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\20lvim.core.alpha\frequire\0", "config", "alpha-nvim")
time([[Config for alpha-nvim]], false)
-- Config for: onedarker.nvim
time([[Config for onedarker.nvim]], true)
try_loadstring("\27LJ\2\2�\1\0\0\2\0\t\0\0196\0\0\0\15\0\0\0X\1\15�6\0\0\0009\0\1\0\a\0\2\0X\0\v�6\0\3\0'\1\2\0B\0\2\0029\0\4\0B\0\1\0016\0\0\0009\0\5\0009\0\6\0009\0\a\0'\1\2\0=\1\b\0K\0\1\0\ntheme\foptions\flualine\fbuiltin\nsetup\frequire\14onedarker\16colorscheme\tlvim\30\1\0\2\0\2\0\0046\0\0\0003\1\1\0B\0\2\1K\0\1\0\0\npcall\0", "config", "onedarker.nvim")
time([[Config for onedarker.nvim]], false)
-- Config for: nvim-colorizer.lua
time([[Config for nvim-colorizer.lua]], true)
try_loadstring("\27LJ\2\2|\0\0\3\0\5\0\b6\0\0\0'\1\1\0B\0\2\0029\0\2\0005\1\3\0005\2\4\0B\0\3\1K\0\1\0\1\0\a\bcss\2\vrgb_fn\2\rRRGGBBAA\2\vhsl_fn\2\vcss_fn\2\bRGB\2\vRRGGBB\2\1\2\0\0\6*\nsetup\14colorizer\frequire\0", "config", "nvim-colorizer.lua")
time([[Config for nvim-colorizer.lua]], false)
-- Config for: lualine.nvim
time([[Config for lualine.nvim]], true)
try_loadstring("\27LJ\2\2?\0\0\2\0\3\0\0066\0\0\0'\1\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\22lvim.core.lualine\frequire\0", "config", "lualine.nvim")
time([[Config for lualine.nvim]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
try_loadstring("\27LJ\2\2A\0\0\2\0\3\0\0066\0\0\0'\1\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\24lvim.core.telescope\frequire\0", "config", "telescope.nvim")
time([[Config for telescope.nvim]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
try_loadstring("\27LJ\2\2B\0\0\2\0\3\0\0066\0\0\0'\1\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\25lvim.core.treesitter\frequire\0", "config", "nvim-treesitter")
time([[Config for nvim-treesitter]], false)
-- Config for: nvim-notify
time([[Config for nvim-notify]], true)
try_loadstring("\27LJ\2\2>\0\0\2\0\3\0\0066\0\0\0'\1\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\21lvim.core.notify\frequire\0", "config", "nvim-notify")
time([[Config for nvim-notify]], false)
-- Config for: nvim-autopairs
time([[Config for nvim-autopairs]], true)
try_loadstring("\27LJ\2\2A\0\0\2\0\3\0\0066\0\0\0'\1\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\24lvim.core.autopairs\frequire\0", "config", "nvim-autopairs")
time([[Config for nvim-autopairs]], false)
-- Config for: project.nvim
time([[Config for project.nvim]], true)
try_loadstring("\27LJ\2\2?\0\0\2\0\3\0\0066\0\0\0'\1\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\22lvim.core.project\frequire\0", "config", "project.nvim")
time([[Config for project.nvim]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file SudaRead lua require("packer.load")({'suda.vim'}, { cmd = "SudaRead", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[au CmdUndefined Trouble* ++once lua require"packer.load"({'trouble.nvim'}, {}, _G.packer_plugins)]])
pcall(vim.cmd, [[au CmdUndefined Translate* ++once lua require"packer.load"({'vim-translator'}, {}, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file SudaWrite lua require("packer.load")({'suda.vim'}, { cmd = "SudaWrite", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[au CmdUndefined Hop* ++once lua require"packer.load"({'hop.nvim'}, {}, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file SymbolsOutline lua require("packer.load")({'symbols-outline.nvim'}, { cmd = "SymbolsOutline", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Calc lua require("packer.load")({'VimCalc3'}, { cmd = "Calc", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
time([[Defining lazy-load commands]], false)

-- Keymap lazy-loads
time([[Defining lazy-load keymaps]], true)
vim.cmd [[noremap <silent> f <cmd>lua require("packer.load")({'clever-f.vim'}, { keys = "f", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[vnoremap <silent> v <cmd>lua require("packer.load")({'vim-expand-region'}, { keys = "v", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[vnoremap <silent> # <cmd>lua require("packer.load")({'vim-visual-star-search'}, { keys = "#", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> t <cmd>lua require("packer.load")({'clever-f.vim'}, { keys = "t", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <M-L> <cmd>lua require("packer.load")({'vim-visual-multi'}, { keys = "<lt>M-L>", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> mL <cmd>lua require("packer.load")({'telescope-vim-bookmarks.nvim'}, { keys = "mL", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <M-i> <cmd>lua require("packer.load")({'telescope-luasnip.nvim'}, { keys = "<lt>M-i>", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[vnoremap <silent> g# <cmd>lua require("packer.load")({'vim-visual-star-search'}, { keys = "g#", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> T <cmd>lua require("packer.load")({'clever-f.vim'}, { keys = "T", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[vnoremap <silent> g* <cmd>lua require("packer.load")({'vim-visual-star-search'}, { keys = "g*", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[vnoremap <silent> V <cmd>lua require("packer.load")({'vim-expand-region'}, { keys = "V", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> F <cmd>lua require("packer.load")({'clever-f.vim'}, { keys = "F", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[vnoremap <silent> <C-n> <cmd>lua require("packer.load")({'vim-visual-multi'}, { keys = "<lt>C-n>", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <M-L> <cmd>lua require("packer.load")({'vim-visual-multi'}, { keys = "<lt>M-L>", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> ml <cmd>lua require("packer.load")({'telescope-vim-bookmarks.nvim'}, { keys = "ml", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> y <cmd>lua require("packer.load")({'vim-surround'}, { keys = "y", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <C-n> <cmd>lua require("packer.load")({'vim-visual-multi'}, { keys = "<lt>C-n>", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> d <cmd>lua require("packer.load")({'vim-surround'}, { keys = "d", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <M-H> <cmd>lua require("packer.load")({'nvim-spectre'}, { keys = "<lt>M-H>", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[vnoremap <silent> * <cmd>lua require("packer.load")({'vim-visual-star-search'}, { keys = "*", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> c <cmd>lua require("packer.load")({'vim-surround'}, { keys = "c", prefix = "" }, _G.packer_plugins)<cr>]]
time([[Defining lazy-load keymaps]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au BufReadPost * ++once lua require("packer.load")({'nvim-ts-context-commentstring'}, { event = "BufReadPost *" }, _G.packer_plugins)]]
vim.cmd [[au WinScrolled * ++once lua require("packer.load")({'neoscroll.nvim'}, { event = "WinScrolled *" }, _G.packer_plugins)]]
vim.cmd [[au CursorMoved * ++once lua require("packer.load")({'vim-cool'}, { event = "CursorMoved *" }, _G.packer_plugins)]]
vim.cmd [[au BufWinEnter * ++once lua require("packer.load")({'bufferline.nvim', 'which-key.nvim'}, { event = "BufWinEnter *" }, _G.packer_plugins)]]
vim.cmd [[au BufReadPre * ++once lua require("packer.load")({'persistence.nvim'}, { event = "BufReadPre *" }, _G.packer_plugins)]]
vim.cmd [[au InsertEnter * ++once lua require("packer.load")({'lsp_signature.nvim'}, { event = "InsertEnter *" }, _G.packer_plugins)]]
vim.cmd [[au BufRead * ++once lua require("packer.load")({'nvim-lastplace', 'vim-bookmarks', 'indent-blankline.nvim', 'gitsigns.nvim', 'todo-comments.nvim', 'Comment.nvim'}, { event = "BufRead *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
