local opt = vim.opt

-- Show line numbers
opt.number = true

-- Display long lines as just one line
opt.wrap = false

-- Set the text width for automatic word wrapping to 80 characters
opt.tw = 80

opt.smartcase = true
opt.smarttab = true
opt.smartindent = true
opt.autoindent = true

-- Show a live preview of substitution commands
opt.inccommand = "nosplit"

local map = vim.api.nvim_set_keymap
local options = { noremap = true }
map('n', '<C-p>', ':Telescope git_files <CR>', options)
map('n', '<C-f>', ':Telescope live_grep <CR>', options)
map('n', '<Leader>b', ':Telescope buffers <CR>', options)
map('n', '<Leader>c', '/^[<|=>]\\{7\\}\\%( .*\\)\\?$<CR>', options)

vim.cmd [[
  set tags+=$MONOREPO/tags;
]]


vim.cmd [[
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
]]
