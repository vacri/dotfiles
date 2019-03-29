
syntax enable

" highlight trailing whitespace, remove with '\rtw'
match ErrorMsg '\s\+$'
nnoremap <Leader>rtw :%s/\s\+$//e<CR>

if &term!="xterm" " needs a friendly stanza in .bashrc
    set t_Co=256            " use 265 colors in vim
    set background=dark "syntax enable might have to be BEFORE this line
    let g:solarized_termcolors=256
    colorscheme solarized
"   colorscheme desert256   " an appropriate color scheme
endif
"colorscheme darkblue

"set mouse=a

set tabstop=4
"use spaces instead of TAB
set expandtab
set shiftwidth=4
set softtabstop=4

set scrolloff=4

set smarttab
set smartindent
set pastetoggle=<F10> "'paste' mode prevents 'smartindent' dumbly indenting pasted text

"get puppet files looking nice using formatting rules for ruby (reformat: gg=G)
autocmd BufEnter *.pp :setf ruby

"cwd to working directory of current buffer, allows opening new files relative
"to current buffer
autocmd BufEnter * :cd %:p:h

" don't expand tabs to spaces for makefiles
autocmd FileType make setlocal noexpandtab

map <F2> :call ToggleLayout()<CR>

" Toggle 2 or 1 pane layout, bound to <F2>
" Added support for Tlist

fun CheckInVerticalSplit()
    let current = winnr()
    :wincmd j
    if winnr() != current
        :wincmd p
        return 1
    endif
    :wincmd p
    :wincmd k
    if winnr() != current
        :wincmd p
        return 1
    endif
    :wincmd p
    return 0
endfun

fun ExpandIfSplitVertical()
    if CheckInVerticalSplit() == 1
        :resize 40
    endif
endfun

let g:layout = 0
fun ToggleLayout()
    let extraSize = 0
    if g:layout == 0
        :exec "winsize " 161 + extraSize " 45"
        :vs
        let g:layout = 1
    else
        :exec "winsize " 80 + extraSize " 45"
        if winnr('$') > 1
            :q
        endif
        let g:layout = 0
    endif
endfun
