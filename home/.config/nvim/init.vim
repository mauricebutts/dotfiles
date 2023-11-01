" TODO
" [X] coq
" [X] replace vim-devicons with https://github.com/nvim-tree/nvim-web-devicons
" [X] telescope with ripgrep
" [X] chadtree
" [X] neovim tmux nav
" [] new vim-fugitive?
" [] clear out old plugs
" [] change airline to lua line?
" [] TreeSitter colorscheme
" [] TreeSitter config
" [] nvim-ts-rainbow for {} highlights
" [] remap lsp cmds into telescope ui?
" [] full migrate over to lua and break this init file into modules pls :)
" [] Indents are a little wonky
" [] Get Lsp formatting to be configurable
" [] TreeSitter c++ wacked out

" [] format golang on save

" #### vim-plug ####
call plug#begin('~/.config/nvim/plugged')

" ### General Plugs ###
" Colors 
Plug 'morhetz/gruvbox'
Plug 'mhartington/oceanic-next'
Plug 'ayu-theme/ayu-vim'
Plug 'sainnhe/everforest'
Plug 'sainnhe/sonokai'

" Fugitive - Git Wrapper
Plug 'tpope/vim-fugitive' " TODO get lua version

" Devicons
Plug 'nvim-tree/nvim-web-devicons'

" Chad Tree
Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'} " note: this does not use devicons

" vim-airline! 
Plug 'vim-airline/vim-airline' " change to lualine

" TreeSitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" coq
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
Plug 'ms-jpq/coq.thirdparty', {'branch': '3p'}

" Lan Client
Plug 'neovim/nvim-lspconfig'

" Telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }

" FZF native for telescope
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }

Plug 'alexghergh/nvim-tmux-navigation'

"" Type Script
" Plug 'leafgarland/typescript-vim'
" Plug 'peitalin/vim-jsx-typescript'

"" Javascript 
" Plug 'pangloss/vim-javascript'

" qml (can't wait to remove)
Plug 'peterhoeg/vim-qml'

call plug#end()

" ########## Colors ########## 
syntax on
set t_Co=256
set termguicolors

" colorscheme Gruvbox
" let g:airline_theme = 'gruvbox'

" colorscheme OceanicNext
" let g:airline_theme = 'oceanicnext'
" let g:oceanic_next_terminal_bold = 1
" let g:oceanic_next_terminal_italic = 1

" colorscheme Everforest
" let g:airline_theme = 'everforest'

let g:sonokai_style = 'espresso' " 'default', 'atlantis', 'andromeda', 'shusia', 'maia', 'espresso'
let g:sonokai_better_performance = 1
colorscheme sonokai
let g:airline_theme='sonokai'

" Ayu-Theme Config
let ayucolor="light"  " for light version of theme
" let ayucolor="mirage" " for mirage version of theme
" let ayucolor="dark"   " for dark version of theme

" ########## General ########## 
" Leader
let mapleader = ","

" esc in insert mode
inoremap kj <esc>

" Reset increment since tmux is using <C-a>
inoremap <C-z> <C-a>

" Tired of swapfiles and backups
set noswapfile
set nobackup
set relativenumber
set number

" Setting clipboard to unnamed in order to use outside of nvim
set clipboard=unnamed

" Setting tabs to 4 spaces
" "set tabstop=8 expandtab shiftwidth=4 softtabstop=4 
" set autoindent
set showcmd
" set smartindent

set showmatch "you know... for showing linking ()

filetype plugin on
set hidden
set backspace=indent,eol,start

" set noequalalways so that window management is a little more custom and
" based on my actions
set noequalalways

" Spell check because I can't spell and my mom thinks I have mild dyslexia and
" she is probably right
set spelllang=en
" Setup a spellfile below 
" set spellfile=$HOME/.confg/nvim/spell/en.utf-8.add
setlocal spell

" ########## General Functions ########## 
" Dark Switch
function! Dark()
  colorscheme OceanicNext
endfunction
:command Dark :call Dark()

" Light Switch
function! Light()
  colorscheme ayu
endfunction
:command Light :call Light()

" Devout
function! Devout()
  :! ~/Util/devout.sh
endfunction
:command Devout :call Devout()

function! QuadSplit()
  :split
  :vsplit
  wincmd j
  :vsplit
endfunction
:command QuadS :call QuadSplit()

" The Zaq leader command to open explore window 
nnoremap <leader>e :Explore <C-R>=expand("%:p:h") . "/" <CR>

" On file save attempt to format based on lsp
lua <<EOF
  vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]
EOF

" ########## MOTES ###########
" open vert note buffer
nnoremap <C-W>N :5split .motes<CR>

"" An attempt to open a buffer and select a "#" header to jump to
" Jump to a header in .motes
" function! MoteJump()
" 
"   " let line_number = substitute(system('echo 3'), '\n\+$', '', '')
"   let line_number = system('rg --line-number -e "#" .motes | fzf'), '', '')
"   "   let line_number = 4
"   execute ":e +". line_number. " .motes" 
" endfunction
" :command MoJ :call MoteJump()


" ############################## NVIM TMUX Nav ####################################
lua << EOF
  require'nvim-tmux-navigation'.setup {
      disable_when_zoomed = true, -- defaults to false
      keybindings = {
          left = "<C-h>",
          down = "<C-j>",
          up = "<C-k>",
          right = "<C-l>",
          -- last_active = "<C-\\>",
          -- next = "<C-Space>",
      }
  }
EOF


" ############################## CHADTree ####################################
lua << EOF
  vim.api.nvim_set_keymap(
    "n",
    "<leader>v",
    "<cmd>CHADopen<cr>",
    { noremap = true, silent = true }
  )
EOF

" ############################## Autocompletion ##############################

" ################# COQ #################
lua <<EOF
  vim.g.coq_settings = { auto_start = true } -- must be before require

  require "coq"

  vim.g.coq_settings = {  -- must be after require?
      ["keymap.jump_to_mark"] = '<leader><space>l' -- I use <c-H> to nav around
  }
EOF

" autocmd BufEnter  *  call ncm2#enable_for_buffer()
" Affects the visual representation of what happens after you hit <C-x><C-o>
" https://neovim.io/doc/user/insert.html#i_CTRL-X_CTRL-O
" https://neovim.io/doc/user/options.html#'completeopt'
"
" This will show the popup menu even if there's only one match (menuone),
" prevent automatic selection (noselect) and prevent automatic text injection
" into the current line (noinsert).
set completeopt=noinsert,menuone,noselect

" suppress the annoying 'match x of y', 'The only match' and 'Pattern not
" found' messages
set shortmess+=c

" CTRL-C doesn't trigger the InsertLeave autocmd . map to <ESC> instead.
inoremap <c-c> <ESC>

" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" ################# Util-Snips #################
" Press enter key to trigger snippet expansion
" The parameters are the same as `:help feedkeys()`
" inoremap <silent> <expr> <CR> ncm2_ultisnips#expand_or("\<CR>", 'n')

" c-j c-k for moving in snippet
" let g:UltiSnipsExpandTrigger		= "<Plug>(ultisnips_expand)"
" let g:UltiSnipsExpandTrigger		= "<Tab>"
" let g:UltiSnipsJumpForwardTrigger	= "<c-j>"
" let g:UltiSnipsJumpBackwardTrigger	= "<c-k>"
" let g:UltiSnipsRemoveSelectModeMappings = 0

" ########## Python ########## 
" ### Jedi-Vim ###
" Let ncm2-jedi handle completions
" let g:jedi#completions_enabled = 0


" Neovim Python env references needed for any python related things
" let g:python_host_prog = '/usr/local/bin/python3'
" let g:python3_host_prog = '/Users/maurice/.config/nvim/bin/python3'

let g:python_host_prog  = '/usr/bin/python2'
let g:python3_host_prog = '/usr/local/bin/python3'

" Yapf hotkey 
" :nnoremap <leader>y :call Yapf()<cr>

" Debug hotkey
:autocmd FileType python nnoremap <leader>p oimport pdb;pdb.set_trace()<ESC>

" Add Self highlighting TOOO: Move this to a python syntax file
augroup PythonCustomization
  " highlight python self, when followed by a comma, a period or a parenth
   :autocmd FileType python syn match pythonStatement "\(\W\|^\)\@<=self\([\.,)]\)\@="
augroup END

" ########## NerdTree ###########
" Adding NerdTree customization to place in selected file
" autocmd VimEnter * wincmd p
" Nerdtree show hidden files
" let NERDTreeShowHidden=1
" Delete file in buffer if deleted in NERDTree
" let NERDTreeAutoDeleteBuffer = 1
" let NERDTreeMinimalUI = 1
" let NERDTreeDirArrows = 1


" Adding function() highlighting! #TODO Move to syntax file
" syntax match pythonFunction /\v[[:alpha:]_.]+\ze(\s?\()/
" hi def link pythonFunction Function

" NERDTreeSyntaxHighlighting
" let g:NERDTreeLimitedSyntax = 1


" ########### CRONTAB On OSX ###########
autocmd filetype crontab setlocal nobackup nowritebackup

" ########## Golang ###########

" ### VIM-GO ###
" Copied from https://hackernoon.com/my-neovim-setup-for-go-7f7b6e805876
" Another good resource: (https://github.com/fatih/vim-go-tutorial)
" Highlighting
" let g:go_highlight_build_constraints = 1
" let g:go_highlight_extra_types = 1
" let g:go_highlight_fields = 1
" let g:go_highlight_functions = 1
" let g:go_highlight_methods = 1
" let g:go_highlight_operators = 1
" let g:go_highlight_structs = 1
" let g:go_highlight_types = 1

" Highlight where you're hovering 
" let g:go_auto_sameids = 1

" Auto Import Dependencies 
" let g:go_fmt_command = "goimports"

" Error and warning signs.
" let g:ale_sign_error = '⤫'
" let g:ale_sign_warning = '⚠'
"
" Enable integration with airline.
" let g:airline#extensions#ale#enabled = 1

" Enable auto type show run every 100ms (default 800ms)
" let g:go_auto_type_info = 1
" set updatetime=100

" struct tags, use ':GoAddTags'. Maybe add leader hot key in future
" let g:go_addtags_transform = "snakecase"
" let g:go_metalinter_deadline = "5s"

" ########## FZF ###########
" Old style rip grep setup - could possibly remove as it is baked into the
" plugin now
" command! -bang -nargs=* Rg
"   \ call fzf#vim#grep(
"   \   'rg --column --line-number --hidden --ignore-case --no-heading --color=always '.shellescape(<q-args>), 1,
"   \   <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
"   \           : fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:50%:hidden', '?'),
"   \   <bang>0)

" Using FZF and Rg to search for text
" nnoremap <silent> <leader>F :Rg<cr>
" Find files with leader f
" nnoremap <silent> <leader>f :FZF<cr>

" ########## Ale ###########
" nnoremap <leader>ll :lnext<CR>
" nnoremap <leader>lp :lprevious<CR>
" nnoremap <leader>lr :lrewind<CR>

" Use specific linters if wanted
" let g:ale_linters = {'python': ['flake8']}

" ############################## DevIcons ##############################
lua <<EOF
  require'nvim-web-devicons'.setup {
   -- your personnal icons can go here (to override)
   -- you can specify color or cterm_color instead of specifying both of them
   -- DevIcon will be appended to `name`
   override = {
    zsh = {
      icon = "",
      color = "#428850",
      cterm_color = "65",
      name = "Zsh"
    }
   };
   -- globally enable different highlight colors per icon (default to true)
   -- if set to false all icons will have the default icon's color
   color_icons = true;
   -- globally enable default icons (default to false)
   -- will get overriden by `get_icons` option
   default = true;
  }
EOF

" ############################## Telescope ##############################
lua <<EOF
require('telescope').setup{
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    color_devicons = true,
    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        ["<C-h>"] = "which_key"
      }
    }
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "ignore_case",       -- or "smart_case" or "respect_case"
    }
  }
}

-- load-in the native-fzf extension
require('telescope').load_extension('fzf')
EOF

" Telescope keybindings for find file, live grep, and grep under cursor
lua <<EOF
  vim.api.nvim_set_keymap(
    "n",
    "<leader>f",
    ":Telescope fd<CR>",
    { noremap = true, silent = true }
  )
  vim.api.nvim_set_keymap(
    "n",
    "<leader>F",
    ":Telescope live_grep<CR>",
    { noremap = true, silent = true }
  )
  vim.api.nvim_set_keymap(
    "n",
    "<leader>t",
    ":Telescope grep_string<CR>",
    { noremap = true, silent = true }
  )
EOF


" ############################## TreeSitter ##############################
lua <<EOF
  require'nvim-treesitter.configs'.setup {
    -- A list of parser names, or "all"
    ensure_installed = { "c", "lua", "rust", "go", "python", "typescript", "javascript", "json" },
  
    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,
  
    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = true,
  
    -- List of parsers to ignore installing (for "all")
    ignore_install = { "" },
  
    ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
    -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!
  
    highlight = {
      -- `false` will disable the whole extension
      enable = true,
  
      -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
      -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
      -- the name of the parser)
      -- list of language that will be disabled
      disable = { },
      -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
      --[[
      disable = function(lang, buf)
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
              return true
          end
      end,
      -- ]]
  
      -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
      -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
      -- Using this option may slow down your editor, and you may see some duplicate highlights.
      -- Instead of true it can also be a list of languages
      additional_vim_regex_highlighting = false,
    },

    indent = {
      enable = true,
      disable = { "yaml" }
    },
  }

EOF



" ############################## LanguageClient ##############################

" lsp setup
lua <<EOF
  -- Mappings.
  -- See `:help vim.diagnostic.*` for documentation on any of the below functions
  local opts = { noremap=true, silent=true }
  vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
  vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

  
  -- Use an on_attach function to only map the following keys
  -- after the language server attaches to the current buffer
  local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  
    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', '<leader>d', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', '<leader>i', vim.lsp.buf.implementation, bufopts)
    -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    -- vim.keymap.set('n', '<leader>d', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, bufopts)
    -- vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', '<leader>n', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
  end
  
  local lsp_flags = {
    -- This is the default in Nvim 0.7+
    debounce_text_changes = 150,
  }
  -- golang

  require'lspconfig'.gopls.setup(coq.lsp_ensure_capabilities({
      on_attach = on_attach,
      flags = lsp_flags,
  }))

  -- c/c++
  require'lspconfig'.clangd.setup(coq.lsp_ensure_capabilities({
      on_attach = on_attach,
      flags = lsp_flags,
  }))

  -- python
  --[[ 
  require('lspconfig')['pyright'].setup{
      on_attach = on_attach,
      flags = lsp_flags,
  }
  --]]

  -- typescript/javascript
  require('lspconfig')['tsserver'].setup(coq.lsp_ensure_capabilities({
      on_attach = on_attach,
      flags = lsp_flags,
  }))

  -- rust
  --[[ 
  require('lspconfig')['rust_analyzer'].setup{
      on_attach = on_attach,
      flags = lsp_flags,
      -- Server-specific settings...
      settings = {
        ["rust-analyzer"] = {}
      }
  }
  --]]
EOF

" Autoformat on save using LSP
" lua <<EOF
"   vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.formatting_sync()]]
" EOF
