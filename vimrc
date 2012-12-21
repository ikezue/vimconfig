"" Use Vim defaults, not Vi's.  Note that this is the default when a user vimrc
"" exists, but made explicit here to be absolutely certain:
"" http://vimdoc.sourceforge.net/htmldoc/options.html#'compatible'
set nocompatible
filetype off

"" Vundle settings
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

"" Let Vundle manage Vundle
Bundle 'gmarik/vundle'

"" Bundles
Bundle 'LaTeX-Box-Team/LaTeX-Box'

"" Allow backspacing over auto indents, line breaks, and the start of an insert
set backspace=indent,eol,start

"" Turn on syntax highlighing
syntax on

"" Enable file type detection, and load plugins and indent files for known file
"" types. This enforces language-specific behavior and indentation.
filetype plugin indent on

"" Defining tab behavior
"" tabstop defines tab width
"" expandstop enables the use of spaces instead of tab characters
"" softtabstop defines # of whitespace characters to use
"" shiftwidth defines amount of whitespace to insert/remove with indentation commands
"" Indent with four whitespace characters
set ts=4 sts=4 sw=4 expandtab
