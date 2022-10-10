" My own little personal Color Scheme
"
" Based on the Xcode dark scheme

highlight clear
if exists("syntax_on")
  syntax reset
endif

set background=dark
let g:colors_name = "nom"


" Functions {{{ 

" Returns an approximate grey index for the given grey level.
fun s:get_approximate_grey_idx(x)
    if a:x < 14
        return 0
    endif
    let l:n = (a:x - 8) / 10
    let l:m = (a:x - 8) % 10
    return l:m <5 ? l:n : l:n + 1
endfun

" Returns the actual grey level represented by the grey index.
fun s:get_grey_level(n)
    return a:n == 0 ? 0 : 8 + (a:n * 10)
endfun

" Returns the palette index for the given grey index.
fun s:get_grey_color_idx(n)
    let l:grey_map = {0: 16, 25: 231}
    let l:default = 231 + a:n
    return get(l:grey_map, a:n, l:default)
endfun

" Returns an approximate color index for the given color level.
fun s:get_approximate_rgb_idx(x)
    if a:x < 75
        return 0
    endif
    let l:n = (a:x - 55) / 40
    let l:m = (a:x - 55) % 40
    return l:m < 20 ? l:n : l:n + 1
endfun

" Returns the actual color level for the given color index.
fun s:get_rgb_level(n)
    return a:n == 0 ? 0 : 55 + (a:n * 40)
endfun

" Returns the palette index for the given R/G/B color indices.
fun s:get_rgb_idx(x, y, z)
    return 16 + (a:x * 36) + (a:y * 6) + a:z
endfun

" Returns the palette index to approximate the given R/G/B color levels.
fun s:get_color(r, g, b)
    " get the closest grey
    let l:gx = s:get_approximate_grey_idx(a:r)
    let l:gy = s:get_approximate_grey_idx(a:g)
    let l:gz = s:get_approximate_grey_idx(a:b)

    " get the closest color
    let l:x = s:get_approximate_rgb_idx(a:r)
    let l:y = s:get_approximate_rgb_idx(a:g)
    let l:z = s:get_approximate_rgb_idx(a:b)

    if l:gx == l:gy && l:gy == l:gz
        " there are two possibilities
        let l:dgr = s:get_grey_level(l:gx) - a:r
        let l:dgg = s:get_grey_level(l:gy) - a:g
        let l:dgb = s:get_grey_level(l:gz) - a:b
        let l:dgrey = (l:dgr * l:dgr) + (l:dgg * l:dgg) + (l:dgb * l:dgb)
        let l:dr = s:get_rgb_level(l:gx) - a:r
        let l:dg = s:get_rgb_level(l:gy) - a:g
        let l:db = s:get_rgb_level(l:gz) - a:b
        let l:drgb = (l:dr * l:dr) + (l:dg * l:dg) + (l:db * l:db)
        if l:dgrey < l:drgb
            " use the grey
            return s:get_grey_color_idx(l:gx)
        endif
        " use the color
        return s:get_rgb_idx(l:x, l:y, l:z)
    endif
    " only one possibility
    return s:get_rgb_idx(l:x, l:y, l:z)
endfun

" Returns the palette index to approximate the 'rrggbb' hex string.
fun s:get_rgb_as_index(rgb)
    let l:r = ("0x" . strpart(a:rgb, 1, 2)) + 0
    let l:g = ("0x" . strpart(a:rgb, 3, 2)) + 0
    let l:b = ("0x" . strpart(a:rgb, 5, 2)) + 0
    return s:get_color(l:r, l:g, l:b)
endfun

fun s:hi(group, fg, bg, attr)
  let l:cmd = "highlight " . a:group

  if a:fg != ""
    let l:cmd .= " guifg=" . a:fg . " ctermfg=" . s:get_rgb_as_index(a:fg)
  endif

  if a:bg != ""
    let l:cmd .= " guibg=" . a:bg . " ctermbg=" . s:get_rgb_as_index(a:bg)
  endif

  if a:attr != ""
    let l:cmd .= " gui=" . a:attr . " cterm=" . a:attr
  endif

  exec l:cmd
endfun

" }}}

"         Group,          FG,        BG,        Attr
call s:hi("Normal",       "#dddddd", "",        "")
call s:hi("NonText",      "#dddddd", "",        "")
call s:hi("Cursor",       "#222222", "#ececec", "")

call s:hi("MatchParen",   "#222222", "#fedc00", "")

call s:hi("Folded",       "#aaaaaa", "#222222", "italic")
call s:hi("VertSplit",    "#222222", "#222222", "")
call s:hi("StatusLine",   "#222222", "#cccccc", "")
call s:hi("StatusLineNC", "#222222", "#cccccc", "")
call s:hi("LineNr",       "#cccccc", "",        "")
call s:hi("LineNrBelow",  "#6c6966", "",        "")
call s:hi("LineNrAbove",  "#6c6966", "",        "")

" Syntax Highlighting
call s:hi("Comment",      "#6c7976", "",        "italic")
call s:hi("Constant",     "#5dd8ff", "",        "")
call s:hi("Identifier",   "#41a1c0", "",        "")
call s:hi("Statement",    "#fc5fa3", "",        "bold")
call s:hi("PreProc",      "#fd8f3f", "",        "")
call s:hi("Type",         "#d0a8ff", "",        "")
call s:hi("Special",      "#fcc8c4", "",        "")

call s:hi("Error",        "#bbbbbb", "#aa0000", "italic")
call s:hi("Function",     "#a167e6", "",        "")
call s:hi("SpecialComment","#cccccc","",        "")

call s:hi("Operator",     "#eeeeee", "",        "bold")

" Formating
call s:hi("Underlined",   "",        "",        "underline")
call s:hi("Italic",       "",        "",        "italic")

" Types
call s:hi("String",       "#fc6a5d", "",        "")
call s:hi("Number",       "#d0bf69", "",        "")

" Shell Scripting
hi! link shRedir Statement
hi! link shShellVariables Identifier

" vim
hi! link vimOption Constant

" HTML
hi! link htmlTag htmlTagN
hi! link htmlEndTag htmlTagN
hi! link htmlTagName Constant
hi! link htmlSpecialTagName Constant

" CSS
hi! link cssTagName htmlTagName
hi! link cssClassNameDot Normal

" delete functions {{{
delf s:hi
delf s:get_rgb_as_index
delf s:get_color
delf s:get_rgb_idx
delf s:get_rgb_level
delf s:get_approximate_rgb_idx
delf s:get_grey_color_idx
delf s:get_grey_level
delf s:get_approximate_grey_idx
" }}}
