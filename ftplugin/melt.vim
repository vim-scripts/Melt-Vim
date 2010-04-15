se iskeyword+=_,'
se cms=(*%s*)

se imi=1
se ims=-1

let b:melt_flavor='melt'
compiler melt

let b:mw = ''
let b:mw = b:mw.',\<let\>:\<and\>:\(\<in\>\|;;\)'
let b:mw = b:mw.',\<if\>:\<then\>:\<else\>'
let b:mw = b:mw.',\<\(for\|while\)\>:\<do\>:\<done\>,'
let b:mw = b:mw.',\<\(object\|sig\|struct\|begin\)\>:\<end\>'
let b:mw = b:mw.',\<\(match\|try\)\>:\<with\>'
let b:match_words = b:mw

let b:match_ignorecase=0

if !exists("*MeltInsert")
  fun Move(s,sense)
    let move = ""
    for i in range(len(a:s))
      let move .= a:sense
    endfor
    return move
  endfun

  fun MoveLeft(s)
    return Move(a:s,"\<Left>")
  endfun

  " unused
  fun MoveRight(s)
    return Move(a:s,"\<Right>")
  endfun

  " unused (does not work well when unicode text is involved)
  fun InsertStringInLine(lnum,col,str)
    let line = getline(a:lnum)
    if a:col <= 1
      throw "null or negative column in InsertStringInLine, ftplugin/melt.vim"
    endif
    if a:col-1 == 1
      let first_part = ""
    else
      let first_part = line[0:(a:col-2)]
    endif
    if a:col == len(line)-1
      let last_part = ""
    else
      let last_part = line[(a:col-1):len(line)-1]
    endif
    let newline = first_part.a:str.last_part
    call setline(a:lnum,newline)
  endfun

  " to forbid mappings
  fun Char2StrNb(c)
    let s = char2nr(a:c)
    if len(s) == 1
      return '00'.s
    elseif len(s) == 2
      return '0'.s
    else
      return s
    endif
  endfun

  fun MapEscapedString(s)
    let res = ""
    for i in range(len(a:s))
      let res .= "".Char2StrNb(a:s[i])
    endfor
    return res
  endfun

  " unused
  fun NormalNTimes(cmd,n)
    for i in range(a:n)
      exe "normal ".a:cmd
    endfor
  endfun

  " unused
  fun RealCursor(lnum,col)
    call cursor(a:lnum,1)
    call NormalNTimes('l',a:col-1)
  endfun

  fun MeltInsert(c1,c2)
    call cursor(line("'<"),col("'<"))
    exe "normal i".MapEscapedString(a:c1)
    if line("'<") == line("'>")
      let move = len(a:c1)
    else
      let move = 0
    endif
    call cursor(line("'>"),col("'>")+move)
    exe "normal a".MapEscapedString(a:c2)
  endfun

  fun MeltMapInserts(cs)
    for c in a:cs
      if len(c) == 1
        let l = c[0]
        let r = c[0]
      elseif len(c) == 2
        let l = c[0]
        let r = c[1]
      elseif len(c) == 3
        let l = c[1]
        let r = c[2]
      endif
      exe "vnoremap <buffer> <LocalLeader>".c[0]." :<C-U>call MeltInsert('".l."','".r."')<CR>"
    endfor
  endfun

  fun MeltMapDelimiters(cs)
    for c in a:cs
      if len(c) == 1
        let c2 = c[0]
      else
        let c2 = c[1]
      endif
      exe "inoremap <buffer> ".c[0]." ".c[0].c2.MoveLeft(c2)
    endfor
  endfun

  fun MeltInsertFunction()
    let f = input("Function to insert? ")
    if f != ""
      call MeltInsert('{'.f.' "','"}')
    endif
  endfun
endif

call MeltMapInserts([ ['"'], ['$'], ['{', '}'], ['(', ')'], ['[', ']'], ['cc', '(*', '*)'], ['e', '{emph "', '"}']])

vnoremap <buffer> <LocalLeader><LocalLeader> :<C-U>call MeltInsertFunction()<CR>

let g:MeltCloseDelimiters = 0
if !exists("g:MeltCloseDelimiters") || g:MeltCloseDelimiters
  call MeltMapDelimiters([['"'], ['{', '}'], ['[', ']'], ['$']])
endif

se isfname-=.
se include=open\ 
se includeexpr=tolower(v:fname[0]).v:fname[1:].\".ml\"
se suffixesadd+=.ml,.mlt
se define=let\ 

setlocal spell spelllang=en
"set thesaurus +=~/.vim/dicos/mthesaur.txt
