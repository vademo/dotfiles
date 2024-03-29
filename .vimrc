" Common sense settings {{{
  set nocompatible             " do not maintain vi compatibility
    let mapleader=","
    inoremap jj <ESC>
    set backspace=2             " Backspace deletes like most programs in insert mode
    set history=50
    set laststatus=2            " Always display the status line
    set autowrite               " Automatically :write before running commands
    set hidden                  " Allow new buffer without saving and closing other one
    set timeoutlen=500          " Wait only 0,5s for key combination to complete
    set encoding=utf-8
    set spelllang=en_gb
    set noeb vb t_vb=
    set synmaxcol=300           "stop syntax highlight"
    syntax sync minlines=256

    nmap <silent> <leader>z :set spell!<CR>     " Easily spell check
    nnoremap <leader>q <C-w>q
    nnoremap <silent> <Leader>) :exe "vertical resize " . (winwidth(0) * 3/2)<CR>
    nnoremap <silent> <Leader>- :exe "vertical resize " . (winwidth(0) * 2/3)<CR>
    nnoremap <leader>e :! npm run test <cr>
    nmap <silent> m "syiw<Esc>: let @/ = @s<CR>

    "
    nnoremap Y yy
    filetype plugin on
    set omnifunc=syntaxcomplete#Complete
    set rtp+=/usr/local/opt/fzf

" }}}
" Colors {{{
    if !exists("g:syntax_on")
        syntax enable       " enable syntax processing
    endif
    colorscheme vademo
    set background=dark
    set cursorline
    hi CursorLine term=bold cterm=bold ctermbg=24
    hi Visual term=bold cterm=bold ctermbg=208
    " Default Colors for CursorLine
    highlight  CursorLine ctermbg=Blue ctermfg=None

    " Change Color when entering Insert Mode
    autocmd InsertEnter * highlight  CursorLine ctermbg=25 ctermfg=None
    " Revert Color to default when leaving Insert Mode
    autocmd InsertLeave * highlight  CursorLine ctermbg=Blue  ctermfg=None
" }}}
" Autocomplete {{{
    set completeopt=longest,menuone
    autocmd FileType js setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType js setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=tern#Complete
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
" }}}
" Autogroups {{{
    augroup configgroup
        autocmd!
        autocmd VimEnter * highlight clear SignColumn
        autocmd FocusLost * :wa

        " remove trailing whitespaces on saving
        autocmd BufWritePre * :%s/\s\+$//e

        " When editing a file, always jump to the last known cursor position.
        " Don't do it for commit messages, when the position is invalid, or when
        " inside an event handler (happens when dropping a file on gvim).
        autocmd BufReadPost *
            \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
            \   exe "normal g`\"" |
            \ endif

        " Set syntax highlighting for specific file types
        autocmd BufRead,BufNewFile *.ejs set filetype=html
        autocmd BufRead,BufNewFile *.ejs set synmaxcol=120
        autocmd BufRead,BufNewFile *.html set synmaxcol=120
        autocmd BufRead,BufNewFile *.md set filetype=markdown

        " Enable spellchecking for Markdown
        autocmd FileType markdown setlocal spell
        autocmd FileType markdown set textwidth=500

        " Automatically wrap at 80 characters for Markdown
        " autocmd BufRead,BufNewFile *.md setlocal textwidth=80

        " Automatically wrap at 72 characters and spell check git commit messages
        autocmd FileType gitcommit setlocal textwidth=72
        autocmd FileType gitcommit setlocal spell

        " Allow stylesheets to autocomplete hyphenated words
        autocmd FileType css,scss,sass setlocal iskeyword+=-

        autocmd FileType javascript setl sw=4 sts=4 et
        autocmd FileType javascript set textwidth=100
    augroup END
" }}}
" Backups {{{
    " set backup
    " set backupdir=$HOME/.vim/tmp//
    " set backupskip=/tmp/*,/private/tmp/*
    " set directory^=$HOME/.vim/tmp//
    " set writebackup
    set nobackup nowritebackup

    " disable swap
    set noswapfile
    " check one time after 4s of inactivity in normal mode
    set autoread
    au CursorHold * checktime
" }}}
" Spaces & Tabs {{{
    set tabstop=4           " 4 space tab
    set expandtab           " use spaces for tabs
    set softtabstop=4       " 4 space tab
    set shiftwidth=2        " Number of spaces to use for each step of (auto)indent.
    set shiftround
    set modelines=1
    filetype indent on      " load filetype-specific indent files
    filetype plugin on
    set autoindent
    " }}}
    " UI Layout {{{
    set number              " show line numbers
    " set relativenumber
    set numberwidth=5
    set ruler               " show the cursor position all the time
    set showcmd             " show command in bottom bar
    " set nocursorline        " highlight current line
    set wildmenu            " visual autocomplete for command menu
    set lazyredraw          " redraw screen only when we need to.
    set showmatch           " higlight matching parenthesis
    set scrolloff=3         " When scrolling off-screen do so 3 lines at a time, not 1
    set textwidth=80
    set colorcolumn=+1
    set list
    set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
" }}}
" Searching {{{
    set ignorecase                      " ignore case when searching
    set incsearch                       " search as characters are entered
    set hlsearch                        " highlight all matches
    " No highlight after a search
    nnoremap <leader><space> :noh<cr>
    " search next/previous -- center in page
    nmap n nzz
    nmap N Nzz
" }}}
" Folding {{{
    set foldmethod=indent   " fold based on indent level
    set foldnestmax=10      " max 10 depth
    set foldenable          " don't fold files by default on open
    set foldlevelstart=10   " start with fold level of 1
    nnoremap <space> za
" }}}
" Navigation {{{
    set cursorline          " highlight the current line the cursor is on
    set suffixesadd+=.js    " add js when searching navigating files using gv
    set path+=,,            " paths to search with gv
    set splitbelow          " Open new split panes to right and bottom, which feels more natural
    set splitright
    nnoremap j gj
    nnoremap k gk
    nnoremap gV `[v`]           " highlight last inserted text
    nnoremap <leader>. <C-z>    " Switch into background mode
    nnoremap <S-Tab> <C-W>W     " Move left between splits
    nnoremap <Tab> <C-W><C-W>   " Move right between splits
    nnoremap <leader>w <C-w>v<C-w>1 " Create vertical split
    nnoremap <leader>q <C-w>q   " close split
" }}}
" Leader Shortcuts {{{
    nnoremap <leader>ev :vsp $MYVIMRC<CR>
    nnoremap <leader>ez :vsp ~/.zshrc<CR>
    nnoremap <leader>sv :source $MYVIMRC<CR>
    nnoremap <leader><space> :noh<CR>
    vnoremap <leader>y "+y      " yank to clipboard
    nnoremap <leader>S :mksession<CR>
" }}}
" PLUGINS {{{
    " CtrlP {{{
        let g:ctrlp_match_window = 'bottom,order:ttb'
        let g:ctrlp_switch_buffer = 0
        let g:ctrlp_working_path_mode = 0
        let g:ctrlp_extensions = ['tag']
        let g:ctrlp_show_hidden = 1
        let g:ctrlp_custom_ignore ='\.git$\|\.hg$\|\.svn$\|bower_components$\|dist$\|build$\|node_modules$\|project_files$\|build$\|coverage$\|coverage$\'
    " }}}
    " NERDTree {{{
        map <leader>b :NERDTree<CR>
        map <leader>n :NERDTreeToggle<CR>
        map <C-n> :NERDTreeToggle<CR>
        let g:NERDTreeWinSize=60
        let NERDTreeQuitOnOpen=1
        let NERDChristmasTree = 1       " colored NERD Tree
        let NERDTreeHighlightCursorline = 1
        let NERDTreeShowHidden = 1
        let NERDTreeMapActivateNode='<space>'
        let NERDTreeIgnore=['\.git$','\.DS_Store','\.pdf', '.beam']
    " }}}
    " Airline {{{
    let g:airline_theme='dark_minimal'

        let g:airline#extensions#tabline#enabled = 1
        let g:airline#extensions#tabline#fnamemod = ':t'
        let g:airline_powerline_fonts = 2

        function! AirlineInit()
            let g:airline_section_a = airline#section#create(['mode',' ', 'branch'])
            let g:airline_section_b = airline#section#create_left(['ffenc', '%f'])
            let g:airline_section_c = airline#section#create(['filetype'])
            let g:airline_section_x = airline#section#create(['%P'])
            let g:airline_section_y = airline#section#create(['%B'])
            let g:airline_section_z = airline#section#create(['%l', '%c'])
            let g:airline_section_error = airline#section#create(['%{ALEGetStatusLine()}'])

        endfunction
    " }}}
    " ALE Linting {{{
        nmap <silent> <C-k> <Plug>(ale_previous_wrap)
        nmap <silent> <C-j> <Plug>(ale_next_wrap)
        let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']
        let g:ale_completion_enabled = 1
        let g:ale_linters = { 'javascript': ['eslint'],'typescript': ['tslint', 'tsserver']}
    " }}}
    " Startify {{{
        let g:startify_change_to_dir = 0
    " }}}
    " HardTime {{{
        let g:hardtime_default_on = 0
    " }}}
    " GoldenRatio {{{
        let g:loaded_golden_ratio = 1
    " }}}
    " Vim-test {{{
        nmap <silent> <leader>s :TestNearest<CR>
        nmap <silent> <leader>t :TestFile<CR>
        nmap <silent> <leader>a :TestSuite<CR>
        nmap <silent> <leader>r :TestLast<CR>
        nmap <silent> <leader>g :TestVisit<CR>
    " }}}
" }}}
" Vim silversearch{{{
    let g:ackprg = 'ag --nogroup --nocolor --column --silent'
    let g:ags_winheight = '20'
" }}}
" Vim ultisnips{{{
        let g:UltiSnipsExpandTrigger="<tab>"
        let g:UltiSnipsJumpForwardTrigger="<c-b>"
        let g:UltiSnipsEditSplit="vertical"
    vertical
" }}}
" Vim Plug {{{
    call plug#begin('~/.vim/bundle')
    Plug 'StanAngeloff/php.vim'
    Plug 'cakebaker/scss-syntax.vim'
    Plug 'takac/vim-hardtime'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'editorconfig/editorconfig-vim'    " load .editorconfig file
    " Plug 'ctrlpvim/ctrlp.vim'
    Plug 'Raimondi/delimitMate'
    Plug 'roman/golden-ratio'
    Plug 'scrooloose/nerdtree'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'gabesoft/vim-ags'
    " Plug 'Chiel92/vim-autoformat'
    Plug 'sheerun/vim-polyglot'
    Plug 'mhinz/vim-startify'
    Plug 'w0rp/ale'
    Plug 'jiangmiao/auto-pairs'
    Plug 'janko-m/vim-test'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-surround'
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
    Plug 'ervandew/supertab'
    " Plug 'tpope/vim-dispatch'
    Plug 'SirVer/ultisnips'
    Plug 'airblade/vim-gitgutter'
    Plug 'djoshea/vim-autoread'
    Plug 'leafgarland/typescript-vim'
    Plug 'peitalin/vim-jsx-typescript'
    Plug 'godlygeek/tabular'
    Plug 'plasticboy/vim-markdown'
    Plug 'rust-lang/rust.vim'
    Plug 'ryanoasis/vim-devicons'
    call plug#end()
" }}}
    " Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
    let g:UltiSnipsExpandTrigger="<tab>"
    let g:UltiSnipsJumpForwardTrigger="<c-j>"
    let g:UltiSnipsJumpBackwardTrigger="<c-k>"

    source ~/.vim/bundle/vim-autoread/plugin/autoread.vim
" set filetypes as typescript.tsx
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescript.tsx
    let autoreadargs={'autoread':1}
        execute WatchForChanges("*", autoreadargs)
" set WatchForChanges=1
    " If you want :UltiSnipsEdit to split your window.
    let g:UltiSnipsEditSplit="vertical"
" Usefull predefined Macros {{{
        " Add single '' around current word
        let @n = "viws'\ep"
        let @l = 'viws"jjp'
        nmap pp @n
        nmap .. :edit .env<CR>
        nmap ppp @l
        nmap PP :%s/\"\([^"]*\)\"/'\1'/gc<CR>
" }}}
" let $FZF_DEFAULT_COMMAND = 'ag -g ""'
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g  ""'

nnoremap <silent> <C-p> :FZF -m<cr>
nnoremap <silent> <F8> :set paste! <cr>
nnoremap <silent> <F9> :! npm test <cr>
nnoremap <silent> <F10> :! npm run coverage <cr>
let g:myLang = 0
let g:myLangList = ['nospell', 'nl', 'en_gb']
function! MySpellLang()
  "loop through languages
  if g:myLang == 0 | setlocal nospell | endif
  if g:myLang == 1 | let &l:spelllang = g:myLangList[g:myLang] | setlocal spell | endif
  if g:myLang == 2 | let &l:spelllang = g:myLangList[g:myLang] | setlocal spell | endif
  echomsg '💡 Set lang to:' g:myLangList[g:myLang]
  let g:myLang = g:myLang + 1
  if g:myLang >= len(g:myLangList) | let g:myLang = 0 | endif
endfunction
nnoremap <silent> <F1> :call  MySpellLang()<CR>

hi VertSplit ctermfg=44
let g:fzf_layout = { 'down': '~40%' }

hi StatusLine ctermbg=31
