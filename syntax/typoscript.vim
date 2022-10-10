" Vim Syntax File
" Language: Typoscript
" Maintainer: Noam Schleutermann
" Latest Revision: 01 April 2021

if exists("b:current_syntax")
	finish
endif

" Comments
syn match typoscriptComment "\s*#.*$"
syn match typoscriptComment "\s*\/\/.*$"

" Type
"syn match typoscriptType /[A-Z_]\+/

" Value
syn match typoscriptValue /[a-zA-Z.\d]*@=\ /
syn match typoscriptExt /EXT\:.*/
syn match typoscriptConstant /{\$[a-zA-Z.\d\-_]*}/
syn match typoscriptFieldQuote /{\#[a-zA-Z.\d]*}/
syn match typoscriptFieldQuote /{[a-zA-Z.\d]*}/

" Structure
syn match typoscriptStructure "\."
syn match typoscriptStructure "{\s*$"
syn match typoscriptStructure "^\s*}"

" Operators
syn match typoscriptOperator "="
syn match typoscriptOperator ":="
syn match typoscriptOperator ": ="
syn match typoscriptOperator "=<"
syn match typoscriptOperator "<"
syn match typoscriptOperator ">"
syn match typoscriptOperator "(\s*$"
syn match typoscriptOperator "^\s*)"

" Colors
let b:current_syntax = "typoscript"

hi def link typoscriptComment Comment
hi def link typoscriptValue String
hi def link typoscriptExt Constant
hi def link typoscriptConstant Constant
hi def link typoscriptFieldQuote Identifier
hi def link typoscriptType Type
hi def link typoscriptStructure PreProc
hi def link typoscriptOperator Statement
