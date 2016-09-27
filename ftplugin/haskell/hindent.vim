if !exists("g:hindent_style")
    let g:hindent_style = "fundamental"
endif

function! s:Hindent()
    exec "norm mz"
    if !executable("hindent")
        echom "hindent not found in PATH"
        return
    endif

    silent! silent exec "!cat % | hindent --style " . g:hindent_style
    exec ':redraw!'

    if v:shell_error
        echom v:shell_error
    else
        silent! exec "%!hindent --style " . g:hindent_style
        write
    endif
    exec "norm `z"
endfunction

augroup hindent
    autocmd!
    autocmd BufWritePost *.hs,*.lhs call s:Hindent()
augroup END
