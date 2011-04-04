"========================================================================
" pexec.vim - Run shell command and open output as preview window.
"========================================================================
" Author:  Yuki <paselan at Gmail.com>
" Version: 1.0
" Date:    Jun 3, 2008
" License: MIT License
" URL:     http://eureka.pasela.org/
"------------------------------------------------------------------------
" Description:
"   Run shell command and open output as preview window.
"
" Installation:
"   Put this file in your plugin directory.
"
" Usage:
"   Call Pexecute vim-command with shell-command as args.
"   Then the output is displayed in the preview window.
"
"   ex.
"     :Pexecute ls -la                            (Unix)
"     :Pexecute dir                               (Win)
"
" Thanks:
"   vimtip #1244
"
" Changelog:
"   1.0:
"     - First release.
"========================================================================


" preview interpreter's output(Tip #1244)
function! PreviewExec(args)
    let dst = 'ExecOutput'

    " open the preview window
    silent execute ':pedit! ' . dst
    " change to preview window
    wincmd P
    " set options
    setlocal buftype=nofile
    setlocal noswapfile
    setlocal syntax=none
    setlocal bufhidden=delete

    " replace current buffer with php's output
    silent execute ':%!' . a:args . ' 2>&1 '

    " change back to the source buffer
    wincmd p
endfunction

command! -nargs=* Pexecute call PreviewExec(<q-args>)


" vim:set ft=vim ts=4 sw=4 sts=4 et:
