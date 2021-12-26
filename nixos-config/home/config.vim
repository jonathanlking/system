" ==================
"  General Settings
" ==================

" Enable color syntaxing
syntax on

" Show line numbers
set number

" Display long lines as just one line
set nowrap

" Indicates input or replace mode at bottom
set showmode

" Set the text width for automatic word wrapping to 80 characters
set tw=80

set smartcase
set smarttab
set smartindent
set autoindent

" Use 2 spaces to indent
set softtabstop=2
set shiftwidth=2
set expandtab

" Incremental search
set incsearch

" Highlight search results
set hlsearch

" Make backspace 'work' as expected
set backspace=indent,eol,start

set mouse=a
set history=1000

set completeopt=menuone,menu,longest

set wildignore+=*\\tmp\\*,*.swp,*.swo,*.zip,.git,.cabal-sandbox
set wildmode=longest,list,full
set wildmenu
set completeopt+=longest

set t_Co=256

set cmdheight=1
set noswapfile

" Disable annoying beeping
set noerrorbells
set vb t_vb=

" Show trailing whitespace as an error
match Error /s\s+$/

set omnifunc=syntaxcomplete#Complete

" Solarized
set background=dark
let g:solarized_termcolors=256
colorscheme solarized

map <silent> <Leader>b :Gblame<CR>

" Shortcut to toggle nerdtree
noremap <C-\> :NERDTreeTabsToggle<CR>

" https://stackoverflow.com/questions/356126/how-can-you-automatically-remove-trailing-whitespace-in-vim
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

" Liyang's conflict
nmap <Leader>c /^[<\|=>]\{7\}\%( .*\)\?$<cr>

" Resizing shortcuts (thanks Liyang!)
nmap <silent> <C-j>     <C-w>j
nmap <silent> <C-k>     <C-w>k
nmap <silent> <Esc><C-j>        :resize -1<cr>
nmap <silent> <Esc><C-k>        :resize +1<cr>

" Ormolu options
let g:ormolu_options=["-o -XTypeApplications", "-o -XInstanceSigs", "-o -XBangPatterns", "-o -XPatternSynonyms", "-o -XUnicodeSyntax", "-o -XDerivingVia"]
nnoremap to :call ToggleOrmolu()<CR>

" Update tags locations
set tags+=$MONOREPO/tags;

" fzf settings (thanks Alex!)
let g:fzf_layout = { 'down': '~15%' }
map <C-p> :Files<CR>
nnoremap <leader>b :Buffers<CR>

command -nargs=+ Ggr execute 'silent Ggrep!' <q-args> | cw | redraw!
nnoremap <C-F> :Ggr <cword><CR>

" Show a live preview of substitution commands
set inccommand=nosplit

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
" Formatting selected code.
xmap <leader>F <Plug>(coc-format)

let g:ormolu_ghc_opt=["-XTypeApplications", "-XRankNTypes", "-XDerivingVia"]
nnoremap <C-l> :Neoformat <CR>
