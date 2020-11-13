" #### vim-plug ####
call plug#begin('~/.config/nvim/plugged')

" ### General Plugs ###
" Colors 
Plug 'morhetz/gruvbox'
Plug 'mhartington/oceanic-next'
Plug 'ayu-theme/ayu-vim'
" Fugitive - Git Wrapper
Plug 'tpope/vim-fugitive'
" Command T - FuzzyFileFinder 
Plug 'git://git.wincent.com/command-t.git'

" Nerd Tree
Plug 'scrooloose/nerdtree'
" Devicons
Plug 'ryanoasis/vim-devicons'
" Nerd Tree highlighting
" Plug 'tiagofumo/vim-nerdtree-syntax-highlight' " Has neat highlights but seems to slow things down

" vim-airline! 
Plug 'vim-airline/vim-airline'

"" ncm2
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'

Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-tmux'
Plug 'ncm2/ncm2-path'

Plug 'ncm2/ncm2-jedi'

" Python Formatter
Plug 'mindriot101/vim-yapf'

" Lan Client
Plug 'autozimu/LanguageClient-neovim', {
  \ 'branch': 'next',
  \ 'do': 'bash install.sh && npm install -g flow-bin',
  \ }

" UtilSnips engine
Plug 'ncm2/ncm2-ultisnips'
Plug 'sirver/ultisnips'

" The Snipets
Plug 'honza/vim-snippets'

" auto pairs
" Plug 'jiangmiao/auto-pairs' " Not using because it sucks... and randomly indents 

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

"" Type Script
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'

"" Javascript 
Plug 'pangloss/vim-javascript'

" ### Linting ###
Plug 'w0rp/ale'

" ### Python Plugs ###
" Jedi-Vim For Python Completion 
Plug 'davidhalter/jedi-vim'

" ### TMUX Plugs ### 
" VIM-TMUX-Navigator to allow to VIM/Tmux to sync
Plug 'christoomey/vim-tmux-navigator'

" ### GOLANG PLUGS ###
Plug 'fatih/vim-go'

" ### Floobits ###
Plug 'floobits/floobits-neovim'

call plug#end()


" ########## General ########## 
" Leader
let mapleader = ","

" Reset increment since tmux is using <C-a>
inoremap <C-z> <C-a>

" Tired of swapfiles and backups
set noswapfile
set nobackup

" Colors
syntax on
set t_Co=256
set termguicolors

" OceanNext Config
colorscheme OceanicNext
let g:airline_theme='oceanicnext'
let g:oceanic_next_terminal_bold = 1
let g:oceanic_next_terminal_italic = 1

" Ayu-Theme config color scheme
let ayucolor="light"  " for light version of theme
"let ayucolor="mirage" " for mirage version of theme
"let ayucolor="dark"   " for dark version of theme

set number
let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"

" Setting clipboard to unnamed in order to use outside of nvim
set clipboard=unnamed

" Setting tabs to 4 spaces
" "set tabstop=8 expandtab shiftwidth=4 softtabstop=4 
set autoindent
set showcmd
set smartindent

set showmatch "you know... for showing linking ()

filetype plugin on
set hidden
set backspace=indent,eol,start

" esc in insert mode
inoremap kj <esc>

" set noequalalways so that window management is a little more custom and
" based on my actions
set noequalalways

" The Zaq leader command to open explore window 
nnoremap <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

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


" ############################## Autocompletion ##############################
"
autocmd BufEnter  *  call ncm2#enable_for_buffer()
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

" ############################## LanguageClient ##############################


let g:LanguageClient_rootMarkers = {
        \ 'go': ['.git', 'go.mod'],
        \ 'javascript': ['.flowconfig', 'package.json'],
        \ }

let g:LanguageClient_serverCommands = {
    \ 'go': ['gopls'],
    \ 'javascript': ['flow', 'lsp'],
    \ 'javascript.jsx': ['flow', 'lsp']
    \ }

let g:go_def_mapping_enabled = 0
nnoremap <leader>d :call LanguageClient#textDocument_definition()<CR>
nnoremap <leader>r :call LanguageClient#textDocument_rename()<CR>
nnoremap <c-]> :call LanguageClient#textDocument_hover()<CR>
nnoremap <leader>n :call LanguageClient#textDocument_references()<CR>

let g:LanguageClient_loggingFile =  expand('~/.local/share/nvim/LanguageClient.log') 

" ################# Util-Snips #################
" Press enter key to trigger snippet expansion
" The parameters are the same as `:help feedkeys()`
inoremap <silent> <expr> <CR> ncm2_ultisnips#expand_or("\<CR>", 'n')

" c-j c-k for moving in snippet
" let g:UltiSnipsExpandTrigger		= "<Plug>(ultisnips_expand)"
let g:UltiSnipsExpandTrigger		= "<Tab>"
let g:UltiSnipsJumpForwardTrigger	= "<c-j>"
let g:UltiSnipsJumpBackwardTrigger	= "<c-k>"
" let g:UltiSnipsRemoveSelectModeMappings = 0

" ########## Python ########## 
" ### Jedi-Vim ###
" Let ncm2-jedi handle completions
let g:jedi#completions_enabled = 0

" Neovim Python env references needed for yarp
" let g:python_host_prog = '/usr/local/bin/python3'
" let g:python3_host_prog = '/Users/maurice/.config/nvim/bin/python3'
"
let g:python_host_prog  = '/usr/bin/python2'
let g:python3_host_prog = '/usr/local/bin/python3'

" Yapf hotkey 
:nnoremap <leader>y :call Yapf()<cr>

" Debug hotkey
:autocmd FileType python nnoremap <leader>p oimport pdb;pdb.set_trace()<ESC>

" Add Self highlighting TOOO: Move this to a python syntax file
augroup PythonCustomization
  " highlight python self, when followed by a comma, a period or a parenth
   :autocmd FileType python syn match pythonStatement "\(\W\|^\)\@<=self\([\.,)]\)\@="
augroup END

" ########## NerdTree ###########
" Adding NerdTree customization to place in selected file
autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p
" Nerdtree show hidden files
let NERDTreeShowHidden=1
" Delete file in buffer if deleted in NERDTree
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" Adding function() highlighting! #TODO Move to syntax file
syntax match pythonFunction /\v[[:alpha:]_.]+\ze(\s?\()/
hi def link pythonFunction Function

" NERDTreeSyntaxHighlighting
" let g:NERDTreeLimitedSyntax = 1


" ########### CRONTAB On OSX ###########
autocmd filetype crontab setlocal nobackup nowritebackup

" ########## Golang ###########

" ### VIM-GO ###
" Copied from https://hackernoon.com/my-neovim-setup-for-go-7f7b6e805876
" Another good resource: (https://github.com/fatih/vim-go-tutorial)
" Highlighting
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1

" Highlight where you're hovering 
let g:go_auto_sameids = 1

" Auto Import Dependencies 
let g:go_fmt_command = "goimports"

" Error and warning signs.
let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'
" Enable integration with airline.
let g:airline#extensions#ale#enabled = 1

" Enable auto type show run every 100ms (default 800ms)
let g:go_auto_type_info = 1
set updatetime=100

" struct tags, use ':GoAddTags'. Maybe add leader hot key in future
let g:go_addtags_transform = "snakecase"
let g:go_metalinter_deadline = "5s"

" ########## FZF ###########
" Old style rip grep setup - could possibly remove as it is baked into the
" plugin now
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --hidden --ignore-case --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
  \           : fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:50%:hidden', '?'),
  \   <bang>0)

" Using FZF and Rg to search for text
nnoremap <silent> <leader>F :Rg<cr>
" Find files with leader f
nnoremap <silent> <leader>f :FZF<cr>

" ########## Ale ###########
nnoremap <leader>ll :lnext<CR>
nnoremap <leader>lp :lprevious<CR>
nnoremap <leader>lr :lrewind<CR>

" Use specific linters if wanted
let g:ale_linters = {'python': ['flake8']}
