Vim Comment
===========

#### Usage

Press <kbd>&lt;leader&gt;x</kbd> to toggle comment.

#### Install

* Just put the files into ~/.vim/ or &lt;HOMEDIR&gt;\vimfiles\ (for Windows).

* Use vundle:

        Plugin 'alvan/vim-comment'

* Use other package manager.

#### Options

Set in your vimrc (optional):

    let g:comment_define = {'vim': '" %s'}
    " OR
    autocmd FileType html setlocal cms=<!--%s-->

    let g:comment_keymap = {'n': '<leader>x', 'v': '<leader>x'}

