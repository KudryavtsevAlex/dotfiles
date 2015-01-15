" vim: fdm=marker:
" main setup parameters
set nocompatible
filetype plugin on
syntax enable
silent! set modeline
silent! set modelines

" define <leader> key
let mapleader = "\\"
let maplocalleader = "_"

" search related and highlighting {{{
set hlsearch
set incsearch
nnoremap <leader>hs :nohlsearch<cr>
inoremap <leader>hs <esc>:nohlsearch<cr>a
"}}}

set history=1500
set smartcase
set shiftwidth=4
set splitbelow
set number
set magic
set backspace=2

" set statusline --- {{{
set laststatus=2
set statusline=
set statusline+=%-3.3n[
set statusline+=%f]
set statusline+=%h%m%r%w
set statusline+=\[%{strlen(&ft)?&ft:'none'}]
set statusline+=%=

"display a warning if &et is wrong, or we have mixed-indenting
set statusline+=%#error#
set statusline+=%{StatuslineTabWarning()}
set statusline+=%#error#
set statusline+=%{StatuslineTrailingSpaceWarning()}
set statusline+=%-5(%*%)

" display a language keymap
"set statusline+=%-8(%{b:keymap_name}%)

set statusline+=0x%-8B
set statusline+=%-14(%c,%l/%L%)
set statusline+=%<%P
" }}}

" Expand tab to spaces
set tabstop=4
set expandtab

" display/hide end-of-lines --- {{{
nnoremap <Leader>l :set list!<cr>
inoremap <Leader>l <esc>:set list!<cr>a
" }}}

" vsplit opens new window at the right
set splitright
set eadirection=ver

" Show cursor position all the time
set ruler
set cursorcolumn
set cursorline
set showcmd

" colorscheme {{{
" set colorscheme
"set background=dark
"colorscheme solarized
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
    "colorscheme xoria256
    colo wombat256mod
elseif $TERM == 'xterm-256color'
    set t_Co=256
    colo wombat256mod
elseif $TERM == 'xterm-color'
    set t_Co=256
    colo wombat256mod
elseif $TERM == 'screen-256color'
    set t_Co=256
    colo wombat256mod
else
    let xterm16_brightness = 'default'
    let xterm16_colormap = 'allblue'
    colorscheme xterm16
endif
" }}}
" set autoindentation, smartindent is on automatically
set autoindent

" use copy to clipboard issuing * register (unnamed)
set clipboard=unnamed

" go to the same column when moving rapidly (gg,shift-g,ctrl-d ...etc.)
set nostartofline

" ***** functions ******* {{{
" ***********************
" Used for changing the abbreviations: {{{
" e.g.:
" :iabbrev <expr> addr <SIG>AbbrAsk('add', "your full address here")
" function! s:AbbrAsk(abbr,expansion)
"     let answer = confirm("Use the abbreviation '" . a:abbr . "'?", "&Yes\n&No", 1)
"     return answer == 1 ? a:expansion : a:abbr
" endfunction
" }}}
"Smart tab function for speed up printing under vim {{{
function! CleverTab()
    " check if at beginning of line or after a space
    if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
        return "\<Tab>"
    else
        " do we have omni completion available
        if &omnifunc != ''
            "use omni-completion 1st priority
            return "\<C-X>\<C-O>"
        elseif &dictionary != ''
            " no omni completion, try dictionary completion
            return "\<C-K>"
        else
            " use omni completion or dictionary completion
            " use known-word completion
            return "\<C-N>"
        endif
    endif
endfunction
" }}}
" if 'tab' symbols used as indenting {{{
" return '[&et]' if &et is set wrong
" return '[mixed-indenting]' if spaces and tabs are used to indent
" return an empty string if everything is fine
function! StatuslineTabWarning()
    if !exists("b:statusline_tab_warning")
        let b:statusline_tab_warning = ''

        if !&modifiable
            return b:statusline_tab_warning
        endif

        let tabs = search('^\t', 'nw') != 0

"find spaces that arent used as alignment in the first indent column
        let spaces = search('^ \{' . &ts . ',}[^\t]', 'nw') != 0

        if tabs && spaces
            let b:statusline_tab_warning = '[mixed-indenting]'
        elseif (spaces && !&et) || (tabs && &et)
            let b:statusline_tab_warning = '[&et]'
        endif
    endif
    return b:statusline_tab_warning
endfunction
" }}}
" function to signalize about whitespaces at the end of lines {{{
" return '[\s]' if trailing white space is detected
" return '' otherwise
function! StatuslineTrailingSpaceWarning()
    if !exists("b:statusline_trailing_space_warning")

        if !&modifiable
            let b:statusline_trailing_space_warning = ''
            return b:statusline_trailing_space_warning
        endif

        if search('\s\+$', 'nw') != 0
            let b:statusline_trailing_space_warning = '[\s]'
        else
            let b:statusline_trailing_space_warning = ''
        endif
    endif
    return b:statusline_trailing_space_warning
endfunction
" }}}
" }}}
" ***** mappings ******** {{{
" ***********************
" command line editing mappings {{{
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
cnoremap <C-d> <Del>
cnoremap <Esc>b <S-Left>
cnoremap <Esc>f <S-Right>
"}}}
" save every step when deleting by <c-w>/<c-u> {{{
inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>
" }}}
" Shortcuts for moving between tabs. {{{
" C-p to go to the tab to the left
" C-n to go to the tab to the right
nnoremap <leader>p gT
nnoremap <leader>n gt
" }}}
" bind function CleverTab to the tab key
inoremap <Tab> <C-R>=CleverTab()<cr>
" Time to get in serious stuff and stop using arrow keys ------- {{{
nnoremap <left> <nop>
nnoremap <right> <nop>
nnoremap <up> <nop>
nnoremap <down> <nop>
cnoremap <left> <nop>
cnoremap <right> <nop>
cnoremap <up> <nop>
cnoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
" }}}
" editing $MYVIMRC file 'on-the-fly' --------- {{{
nnoremap <leader>ev :tabe $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
" }}}
" }}}

" ***********************
" ******* folding *******
" ***********************
" close all opened folds automatically
" when leave folded area
set foldclose=all


autocmd BufWinLeave * silent! mkview
autocmd BufWinEnter * silent! loadview

" recalculate the tab warning flag when idle and after writing
" used for statusline, as could be known from name
autocmd CursorHold,BufWritePost * unlet! b:statusline_tab_warning
" recalculate the trailing whitespace warning when idle, and after saving
" used for statusline, as could be known from name
autocmd CursorHold,BufWritePost * unlet! b:statusline_trailing_space_warning


" Display all the leading whitespace(s) as errors
" TODO: make this available for 'tabs' at the start of the lines
" TODO: this would be under specific files (bash, python ...etc)
"+      cause usual text can have leading spaces and tabs instead few spaces
" It is important for most cases
"match Error /\s\+$/
"match Error /^\s*	\+/

" File templates
"----work WEEK ACCOUNT template file------- {{{
augroup skel_group
    if filereadable("/home/kudryav_v/.vim/skeleton/account.skel")
        autocmd!
        autocmd BufNewFile *.account 0r /home/kudryav_a/.vim/skeleton/account.skel
    endif
augroup END
" }}}
" Vimscript file settings -------------------------- {{{
augroup filetype_vim
    autocmd!
    "autocmd Filetype vim set foldmethod=marker
    autocmd Filetype vim set foldclose=all
augroup END
" }}}
" Setting keymap if possible --------- {{{
if has("keymap")
    set keymap=russian-jcukenwin
    " cause we really located at russia and consorted in russian language
    inoremap  <C-^>
    cnoremap  <C-^>
    silent nnoremap  a<C-^><C-c>
endif
" }}}
"set backup (dir and other stuff {{{
set backup
set backupdir=~/.vim/backups
set directory=~/.vim/backups
" }}}
