" Plugins
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Required
Plugin 'VundleVim/Vundle.vim'

Plugin 'preservim/nerdtree'
Plugin 'xuhdev/vim-latex-live-preview'
Plugin 'iamcco/markdown-preview.nvim'
Plugin 'mattn/emmet-vim'
Plugin 'SirVer/ultisnips'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

Plugin 'ap/vim-css-color'
Plugin 'rubixninja314/vim-mcfunction'

Plugin 'frenzyexists/aquarium-vim'
Plugin 'ayu-theme/ayu-vim'
Plugin 'gosukiwi/vim-atom-dark'
Plugin 'nickaroot/vim-xcode-dark-theme'
Plugin 'aonemd/kuroi.vim'

call vundle#end()
filetype off
filetype plugin on

" General Settings
set nu rnu
syntax on

set cursorline
set scrolloff=5
set cc=80

set tabstop=2
set shiftwidth=2
set noexpandtab

set smartindent
set wrap
set linebreak

set nocompatible

set noshowmode
set showcmd

set belloff=all

set modeline
set modelineexpr
set modelines=4

set termguicolors
colo ayu

" Custom Keys
nnoremap <C-k> ddkP
nnoremap <C-j> ddp
nnoremap <Space><Space> /<++><Return>ca<
vnoremap <Space><Space> <Esc>/<++><Return>ca<


" Plugin Settings
let g:airline_section_z = '%#__accent_bold#%l%#__restore__#/%L : %#__accent_bold#%c%#__restore__#%V (%#__accent_bold#%p%%%#__restore__#)'
" call airline#parts#define('linenr', {'raw': '%l', 'accents': 'bold'})
" call airline#parts#define('colnr', {'text': '%c%V', 'accents': 'bold'})
" let g:airline_section_z = airline#section#create(['linenr', '/%L:'])

let g:user_emmet_expandabbr_key = '<c-e>'
let g:user_emmet_settings = {
	\ 	'variables': {'lang': 'de'},
	\ 	'html': {
	\ 		'empty_element_suffix': ' />',
	\ 		'default_attributes': {
	\ 			'option': {'value': v:null},
	\ 			'textarea': {'id': v:null, 'name': v:null, 'cols': 10, 'rows': 10},
	\ 		},
	\ 		'snippets': {
	\ 			'html:5': "<!DOCTYPE html>\n"
	\   	           ."<html lang=\"${lang}\">\n"
	\   	           ."<head>\n"
	\   	           ."\t<meta charset=\"${charset}\" />\n"
	\   	           ."\t<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\" />\n"
	\   	           ."\t<title></title>\n"
	\   	           ."</head>\n"
	\   	           ."<body>\n\t${child}|\n</body>\n"
	\   	           ."</html>",
	\ 		},
	\ 	},
	\ }

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsSnippetDirectories=["snips"]

let g:livepreview_engine = 'xelatex' . ' --shell-escape -halt-on-error '

let g:NERDTreeWinSize=24
autocmd VimEnter * NERDTree | wincmd p
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
	\ quit | endif
autocmd BufWinEnter * silent NERDTreeMirror

" Filetypes
autocmd BufRead,BufNewFile *.cls,*.sty   :set filetype=tex
autocmd BufRead,BufNewFile *.tex         :set filetype=tex
autocmd BufRead,BufNewFile *.typoscript  :set filetype=typoscript
autocmd BufRead,BufNewFile *.tsconfig    :set filetype=typoscript
autocmd BufRead,BufNewFile *.mcmeta      :set filetype=json
autocmd BufRead,BufNewFile *.mcfunction  :set filetype=mcfunction

autocmd BufRead,BufNewFile README        :set filetype=markdown
