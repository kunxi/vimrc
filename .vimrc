" vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker spell:
"
" Environment {
    if has('vim_starting')
    set nocompatible               " Be iMproved
    set runtimepath+=~/.vim/bundle/neobundle.vim/
    endif

    call neobundle#rc(expand('~/.vim/bundle/'))
" }

" General {

    if !has('gui')
        "set term=$TERM          " Make arrow and other keys work
    endif
    filetype plugin indent on   " Automatically detect file types.
    syntax on                   " Syntax highlighting
    set mouse=a                 " Automatically enable mouse usage
    set mousehide               " Hide the mouse cursor while typing
    scriptencoding utf-8

    if has ('x') && has ('gui') " On Linux use + register for copy-paste
        set clipboard=unnamedplus
    elseif has ('gui')          " On mac and Windows, use * register for copy-paste
        set clipboard=unnamed
    endif

    set shortmess+=filmnrxoOtT          " Abbrev. of messages (avoids 'hit enter')
    set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
    set virtualedit=onemore             " Allow for cursor beyond last character
    set history=1000                    " Store a ton of history (default is 20)
    set spell                           " Spell checking on
    set hidden                          " Allow buffer switching without saving
    set lazyredraw                      " Don't redraw while executing macro
    set magic                           " regex in the magic mode


    " restore the cursor
    " undo 
" }

" Use bundles config {
    if filereadable(expand("~/.vimrc.bundles"))
        source ~/.vimrc.bundles
    endif
" }


" Vim UI {
    set background=dark                 " Assume a dark background
    colorscheme zenburn

    set tabpagemax=15               " Only show 15 tabs
    set showmode                    " Display the current mode

    set cursorline                  " Highlight current line

    highlight clear SignColumn      " SignColumn should match background for
                                    " things like vim-gitgutter

    "highlight clear LineNr         " leave the LineNr as-is.
                                    " Things like vim-gitgutter will match LineNr highlight
    "highlight clear CursorLineNr    " Remove highlight color from current line number

    if has('cmdline_info')
        set ruler                   " Show the ruler
        set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
        set showcmd                 " Show partial commands in status line and
                                    " Selected characters/lines in visual mode
    endif

    if has('statusline')
        set laststatus=2

        " Broken down into easily includeable segments
        set statusline=%<%f\                     " Filename
        set statusline+=%w%h%m%r                 " Options
        set statusline+=%{fugitive#statusline()} " Git Hotness
        set statusline+=\ [%{&ff}/%Y]            " Filetype
        set statusline+=\ [%{getcwd()}]          " Current dir
        set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
    endif

    set backspace=indent,eol,start  " Backspace for dummies
    set linespace=0                 " No extra spaces between rows
    set nu                          " Line numbers on
    set showmatch                   " Show matching brackets/parenthesis
    set incsearch                   " Find as you type search
    set hlsearch                    " Highlight search terms
    set winminheight=0              " Windows can be 0 line high
    set ignorecase                  " Case insensitive search
    set smartcase                   " Case sensitive when uc present
    set wildmenu                    " Show list instead of just completing
    set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
    set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
    set scrolljump=5                " Lines to scroll when cursor leaves screen
    set scrolloff=3                 " Minimum lines to keep above and below cursor
    set foldenable                  " Auto fold code
    set list
    set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace
 " }

" Formatting {

    set wrap                        " Wrap long lines
    set autoindent                  " Indent at the same level of the previous line
    set shiftwidth=4                " Use indents of 4 spaces
    set expandtab                   " Tabs are spaces, not tabs
    set tabstop=4                   " An indentation every four columns
    set softtabstop=4               " Let backspace delete indent
    set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
    set splitright                  " Puts new vsplit windows to the right of the current
    set splitbelow                  " Puts new split windows to the bottom of the current
    "set matchpairs+=<:>             " Match, to be used with %
    "set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks

    " Remove trailing whitespaces and ^M chars
    autocmd FileType c,cpp,java,go,php,javascript,python,twig,xml,yml autocmd BufWritePre <buffer> call StripTrailingWhitespace()
    autocmd FileType go autocmd BufWritePre <buffer> Fmt
    autocmd BufNewFile,BufRead *.html.twig set filetype=html.twig
    autocmd FileType haskell setlocal expandtab shiftwidth=2 softtabstop=2
    " preceding line best in a plugin but here for now.

    autocmd BufNewFile,BufRead *.coffee set filetype=coffee

    " Workaround vim-commentary for Haskell
    autocmd FileType haskell setlocal commentstring=--\ %s
    " Workaround broken colour highlighting in Haskell
    autocmd FileType haskell setlocal nospell
    " do not expandtab for makefile
    autocmd FileType make set noexpandtab
" }

" Key ReMapping {
    let mapleader = ','

    " Wrapped lines goes down/up to next row, rather than next line in file.
    noremap j gj
    noremap k gk

    " Same for 0, home, end, etc
    noremap $ g$
    noremap <End> g<End>
    noremap 0 g0
    noremap <Home> g<Home>
    noremap ^ g^

    " Yank from the cursor to the end of the line, to be consistent with C and D.
    nnoremap Y y$

    " Visual shifting (does not exit Visual mode)
    vnoremap < <gv
    vnoremap > >gv

    " Allow using the repeat operator with a visual selection (!)
    " http://stackoverflow.com/a/8064607/127816
    vnoremap . :normal .<CR>

" }

" Key Mapping {
    " toggle the hlsearch using ,/
    nmap <silent> <leader>/ :set invhlsearch<CR>

    " toggle the linenumber using F2
    nmap <F2> :set invnumber<CR>

    " toggle the spell check using F3
    map <F3> :call ToggleSpellCheck()<CR>

    " pastetoggle (sane indentation on pastes)
    set pastetoggle=<F12>

    " Change Working Directory to that of the current file
    cmap cwd lcd %:p:h
    cmap cd. lcd %:p:h

    " For when you forget to sudo.. Really Write the file.
    cmap w!! w !sudo tee % >/dev/null

    " Move window with h, j, k l
    map <C-j> <C-W>j
    map <C-k> <C-W>k
    map <C-h> <C-W>h
    map <C-l> <C-W>l
" }

" GUI Settings {

    " GVIM- (here instead of .gvimrc)
    if has('gui_running')
        set guioptions-=T           " Remove the toolbar
        if has('gui_macvim')
            set transparency=1      " Make the window slightly transparent
        endif
    else
        if &term == 'xterm' || &term == 'screen'
            set t_Co=256            " Enable 256 colors to stop the CSApprox warning and make xterm vim shine
        endif
        "set term=builtin_ansi       " Make arrow and other keys work
    endif

" }

" Functions {
    " Strip whitespace
    function StripTrailingWhitespace()
        " Preparation: save last search, and cursor position.
        let _s=@/
        let l = line(".")
        let c = col(".")
        " do the business:
        %s/\s\+$//e
        " clean up: restore previous search history, and cursor position
        let @/=_s
        call cursor(l, c)
    endfunction

    " Toggle spellcheck
    function ToggleSpellCheck()
        if &spell
            exe "setlocal nospell"
        else
            exe "setlocal spell"
        endif
    endfunction
" }

" Plugins {
    " OmniComplete {
        if has("autocmd") && exists("+omnifunc")
            autocmd Filetype *
                \if &omnifunc == "" |
                \setlocal omnifunc=syntaxcomplete#Complete |
                \endif
        endif

        hi Pmenu  guifg=#000000 guibg=#F8F8F8 ctermfg=black ctermbg=Lightgray
        hi PmenuSbar  guifg=#8A95A7 guibg=#F8F8F8 gui=NONE ctermfg=darkcyan ctermbg=lightgray cterm=NONE
        hi PmenuThumb  guifg=#F8F8F8 guibg=#8A95A7 gui=NONE ctermfg=lightgray ctermbg=darkcyan cterm=NONE

        " Some convenient mappings, otherwise, you have to use C-N, C-P to
        " navigate.
        inoremap <expr> <Esc>      pumvisible() ? "\<C-e>" : "\<Esc>"
        inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
        inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
        inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
        inoremap <expr> <C-d>      pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
        inoremap <expr> <C-u>      pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"

        " Automatically open and close the popup menu / preview window
        au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
        set completeopt=menu,preview,longest
    " }

    " vim-airline {
        let g:airline_theme = 'powerlineish'
        if has('gui_running')
            if has("gui_macvim")
                set guifont=Inconsolata\ for\ Powerline:h14
            else
                set guifont=Inconsolata\ for\ Powerline\ 12
            endif
            let g:airline_powerline_fonts = 1
        else
            let g:airline_powerline_fonts = 0
            let g:airline_left_sep='›'  " Slightly fancier than '>'
            let g:airline_right_sep='‹' " Slightly fancier than '<'
        endif
    " }
    " vim-css3-syntax {
        highlight VendorPrefix guifg=#00ffff gui=bold
        match VendorPrefix /-\(moz\|webkit\|o\|ms\)-[a-zA-Z-]\+/
    " }
    " UltiSnips {
        let g:UltiSnipsSnippetsDir = "~/.vim/bundle/vim-snippets/UltiSnips"
    " }
    " Unite {

        nnoremap    [unite]   <Nop>
        nmap    f [unite]

        autocmd FileType unite call s:unite_my_settings()
        function! s:unite_my_settings()"{{{
          " Overwrite settings.

          nmap <buffer> <ESC>      <Plug>(unite_exit)
          imap <buffer> jj      <Plug>(unite_insert_leave)
          imap <buffer><expr> j unite#smart_map('j', '')
          imap <buffer> <TAB>   <Plug>(unite_select_next_line)
          imap <buffer> <C-w>     <Plug>(unite_delete_backward_path)
          imap <buffer><expr> x
                  \ unite#smart_map('x', "\<Plug>(unite_quick_match_choose_action)")
          nmap <buffer> x     <Plug>(unite_quick_match_choose_action)
          nmap <buffer> <C-z>     <Plug>(unite_toggle_transpose_window)
          imap <buffer> <C-z>     <Plug>(unite_toggle_transpose_window)
          imap <buffer> <C-y>     <Plug>(unite_narrowing_path)
          nmap <buffer> <C-y>     <Plug>(unite_narrowing_path)
          nmap <buffer> <C-r>     <Plug>(unite_narrowing_input_history)
          imap <buffer> <C-r>     <Plug>(unite_narrowing_input_history)

          let unite = unite#get_current_unite()
          if unite.buffer_name =~# '^search'
            nnoremap <silent><buffer><expr> r     unite#do_action('replace')
          else
            nnoremap <silent><buffer><expr> r     unite#do_action('rename')
          endif

          nnoremap <silent><buffer><expr> cd     unite#do_action('lcd')
          nnoremap <buffer><expr> S      unite#mappings#set_current_filters(
                  \ empty(unite#mappings#get_current_filters()) ?
                  \ ['sorter_reverse'] : [])

          " Runs "split" action by <C-s>.
          imap <silent><buffer><expr> <C-s>     unite#do_action('split')
          nnoremap <silent><buffer><expr> <C-s>     unite#do_action('split')
        endfunction"}}}

        " Key mapping for unite:
        " fr: Recursively search current directory
        " fc: list all files in Current directory with bookmarks
        " fb: target the current file, aka Buffer's directory
        " fd: change to mru directories
        " fma: list all mappings

        nnoremap <silent> [unite]r :<C-u>Unite -start-insert file_rec/async:!<CR>

        nnoremap <silent> [unite]c  :<C-u>UniteWithCurrentDir
                    \ -buffer-name=files buffer file_mru bookmark file<CR>
        nnoremap <silent> [unite]b  :<C-u>UniteWithBufferDir
                \ -buffer-name=files -prompt=%\  buffer file_mru bookmark file<CR>
        nnoremap <silent> [unite]d
                \ :<C-u>Unite -buffer-name=files -default-action=lcd directory_mru<CR>
        nnoremap <silent> [unite]ma
                \ :<C-u>Unite mapping<CR>

        " Start insert.
        let g:unite_enable_short_source_names = 1
        let g:unite_split_rule = 'botright'
    " }
" }

