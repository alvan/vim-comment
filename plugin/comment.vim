if exists("g:loaded_comment")
    finish
en
let g:loaded_comment = "2.1"

let g:comment_define = extend(exists('g:comment_define') ? g:comment_define : {},
            \ {'vim': '"%s'}, "keep")

let g:comment_keymap = extend(exists('g:comment_keymap') ? g:comment_keymap : {},
            \ {'n': '<leader>x', 'v': '<leader>x'}, "keep")

if has_key(g:comment_keymap, 'n') && g:comment_keymap['n'] != ''
    exec 'nnoremap <silent> ' . g:comment_keymap['n'] . ' :call <SID>Comment()<Cr>'
en
if has_key(g:comment_keymap, 'v') && g:comment_keymap['v'] != ''
    exec 'vnoremap <silent> ' . g:comment_keymap['v'] . " <Esc>:'<,'>call <SID>Comment()<Cr>"
en

fun! s:Comment() range
    let comm = substitute(s:CommStr(exists('&filetype') ? &filetype : ''), '^\s*\(.\{-1,}\)\s*$', '\1', '')
    if comm =~ '^\s*$'
        return
    en
    let coms = split(substitute(substitute(comm, '\S\zs%s',' %s',''), '%s\ze\S', '%s ', ''), '%s', 1)

    let lino = a:firstline - 1
    while lino < a:lastline
        let lino += 1
        let line = getline(lino)

        if line =~ '^\s*$'
            continue
        en

        let lins = matchlist(line, '^\(\s*\)\(.\{-1,}\)\(\s*\)$')
        if len(lins) < 4
            continue
        en

        let body = lins[2]
        if stridx(body, coms[0]) == 0 &&
                    \ (len(coms) < 2 || strridx(body, coms[1]) == strlen(body) - strlen(coms[1]))
            let body = strpart(body, strlen(coms[0]))
            if len(coms) > 1
                let body = strpart(body, 0, strlen(body) - strlen(coms[1]))
            en

            let body = substitute(body, '^\s*\(.\{-1,}\)\s*$', '\1', '')
        else
            let body = coms[0] . body . (len(coms) > 1 ? coms[1] : '')
        en

        call setline(lino, lins[1] . body . lins[3])
    endw
endf

fun! s:CommStr(...)
    return a:0 > 0 && exists('g:comment_define') && has_key(g:comment_define, a:1)
                \? g:comment_define[a:1]
                \: (exists('&cms') ? &cms : '')
endf
