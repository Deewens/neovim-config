set tabstop=4 " Number of column taken by the \t char (TAB)
set shiftwidth=4 " Governs indentation via >> (whatever this is? Seems related to Normal Mode indentation but I don't know)
set expandtab " Replace indentation (made with tabstop or shiftwidth) with space characters

" NERDTree
" Start NERDTree when Neovim starts
autocmd VimEnter * NERDTree | wincmd p
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" Open the existing NERDTree on each new tab.
autocmd BufWinEnter * if getcmdwintype() == '' | silent NERDTreeMirror | endif
