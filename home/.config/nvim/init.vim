" #### vim-plug ####
call plug#begin('~/.config/nvim/plugged')

" ### General Plugs ###
" Fugitive - Git Wrapper
Plug 'tpope/vim-fugitive'
" Command T - FuzzyFileFinder 
Plug 'git://git.wincent.com/command-t.git'
" Colors 
Plug 'morhetz/gruvbox'
Plug 'mhartington/oceanic-next'

" Nerd Tree
Plug 'scrooloose/nerdtree'
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
  \ 'do': 'bash install.sh',
  \ }

" UtilSnips engine
Plug 'ncm2/ncm2-ultisnips'
Plug 'sirver/ultisnips'

" The Snipets
Plug 'honza/vim-snippets'

" auto pairs
Plug 'jiangmiao/auto-pairs'

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

call plug#end()


" ########## General ########## 
" Leader
let mapleader = ","

" Set hybrid-relative line numbers
set rnu

" Reset increment since tmux is using <C-a>
inoremap <C-z> <C-a>

" Tired of swapfiles and backups
set noswapfile
set nobackup

" Colors
syntax on
set t_Co=256

" OceanNext Config
colorscheme OceanicNext
let g:airline_theme='oceanicnext'
let g:oceanic_next_terminal_bold = 1
let g:oceanic_next_terminal_italic = 1

let $NVIM_TUI_ENABLE_TRUE_COLOR=1

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
        \ }

let g:LanguageClient_serverCommands = {
    \ 'go': ['gopls'],
    \ 'javascript': ['javascript-typescript-stdio'],
    \ 'typescript': ['javascript-typescript-stdio'],
    \ 'javascript.jsx': ['javascript-typescript-stdio'],
    \ 'typescript.tsx': ['javascript-typescript-stdio'],
    \ }

let g:go_def_mapping_enabled = 0
nnoremap <leader>d :call LanguageClient#textDocument_definition()<CR>
nnoremap <leader>r :call LanguageClient#textDocument_rename()<CR>
nnoremap <c-]> :call LanguageClient#textDocument_hover()<CR>
nnoremap <leader>n :call LanguageClient#textDocument_references()<CR>


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

" ########## MOTES ###########
" open vert note buffer
nnoremap <C-W>N :5split .motes<CR>

" ########## Python ########## 
" ### Jedi-Vim ###
" Let ncm2-jedi handle completions
let g:jedi#completions_enabled = 0

" Neovim Python env references
let g:python_host_prog = '/usr/local/bin/python3'
let g:python3_host_prog = '/Users/maurice/.config/nvim/bin/python3'

" Yapf hotkey 
:nnoremap <leader>y :call Yapf()<cr>

" Debug hotkey
:autocmd FileType python nnoremap <leader>p oimport pdb;pdb.set_trace()<ESC>

" Add Self highlighting
augroup PythonCustomization
  " highlight python self, when followed by a comma, a period or a parenth
   :autocmd FileType python syn match pythonStatement "\(\W\|^\)\@<=self\([\.,)]\)\@="
augroup END

" Adding in run current file into new buffer
" Bind F5 to save file if modified and execute python script in a buffer.
nnoremap <silent> <F5> :call SaveAndExecutePython()<CR>
vnoremap <silent> <F5> :<C-u>call SaveAndExecutePython()<CR>

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

" Adding function() highlighting!
syntax match pythonFunction /\v[[:alpha:]_.]+\ze(\s?\()/
hi def link pythonFunction Function

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
