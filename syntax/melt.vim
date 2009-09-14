" Vim syntax file
" Language:     Melt
" Filenames:    *.mlt
" Maintainers:  Vincent Aravantinos      <vincent.aravantinos@gmail.com>
" URL:          <http://www.vim.org/scripts/script.php?script_id=2787>
" Last Change:  2009 Sep 14 - Initial version: copy-paste of ocaml.vim + adaptation
" License:      Free domain

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax") && b:current_syntax == "ocaml"
  finish
endif

syn region meltText           contained contains=meltMath,meltCommand matchgroup=meltTextDelimiter start=+\\\@<!"+ skip=+\\"+ matchgroup=meltTextDelimiter end=+"+
syn region meltCommandGlobal contains=meltText,meltMath start="\%^" end="\%$"
syn region meltCommand contained contains=meltText,meltMath matchgroup=meltCmd start="\\\@<!{" matchgroup=meltCmd end="}"
syn region meltMath    contained contains=meltText,meltCommand matchgroup=Delimiter start=+\\\@<!\$+ skip=+\\\$+ matchgroup=Delimiter end=+\$+

syn match meltMail   containedin=meltText #\\\@<!"\@<=\(mailto:\)\?[a-z_A-Z0-9.]\+@[a-z_A-Z0-9.]\+"#me=e-1
syn match meltUrl    containedin=meltText #\\\@<!"\@<=http://[a-z_A-Z0-9.\-&/=~?]\+"#me=e-1
syn match meltNumber containedin=meltText #\\\@<!"\@<=\d\+\(\.\d*\)\?"#me=e-1
syn match meltFile   containedin=meltText #\\\@<!"\@<=[a-zA-Z_]\+\.[a-zA-Z0-9]\{,3\}"#me=e-1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" All the following roughly copy pasted from ocaml.vim "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" OCaml is case sensitive.
syn case match

" Script headers highlighted like comments
syn match    ocamlComment contained containedin=meltCommand,meltCommandGlobal   "^#!.*"

" Scripting directives
syn match    ocamlScript contained containedin=meltCommand,meltCommandGlobal "^#\<\(quit\|labels\|warnings\|directory\|cd\|load\|use\|install_printer\|remove_printer\|require\|thread\|trace\|untrace\|untrace_all\|print_depth\|print_length\)\>"

" Script headers highlighted like comments
syn match    ocamlComment contained containedin=meltCommand,meltCommandGlobal      "^#!.*"

" lowercase identifier - the standard way to match
syn match    ocamlLCIdentifier           contained containedin=meltCommand       /\<\(\l\|_\)\(\w\|'\)*\>/
syn match    ocamlLCIdentifierGlobalMelt contained containedin=meltCommandGlobalGlobal /\<\(\l\|_\)\(\w\|'\)*\>/

syn match    ocamlKeyChar contained containedin=meltCommand,meltCommandGlobal    "|"

" Errors
"syn match    ocamlBraceErr contained containedin=meltCommand,meltCommandGlobal   "}"
syn match    ocamlBrackErr contained containedin=meltCommand,meltCommandGlobal   "\]"
syn match    ocamlParenErr contained containedin=meltCommand,meltCommandGlobal   ")"
syn match    ocamlArrErr contained containedin=meltCommand,meltCommandGlobal     "|]"

syn match    ocamlCommentErr contained containedin=meltCommand,meltCommandGlobal "\*)"

syn match    ocamlCountErr contained containedin=meltCommand,meltCommandGlobal   "\<downto\>"
syn match    ocamlCountErr contained containedin=meltCommand,meltCommandGlobal   "\<to\>"

if !exists("ocaml_revised")
  syn match    ocamlDoErr contained containedin=meltCommand,meltCommandGlobal      "\<do\>"
endif

syn match    ocamlDoneErr contained containedin=meltCommand,meltCommandGlobal    "\<done\>"
syn match    ocamlThenErr contained containedin=meltCommand,meltCommandGlobal    "\<then\>"

" Error-highlighting of "end" without synchronization:
" as keyword or as error (default)
if exists("ocaml_noend_error")
  syn match    ocamlKeyword contained containedin=meltCommand,meltCommandGlobal    "\<end\>"
else
  syn match    ocamlEndErr contained containedin=meltCommand,meltCommandGlobal     "\<end\>"
endif

" Some convenient clusters
syn cluster  ocamlAllErrs contains=ocamlBraceErr,ocamlBrackErr,ocamlParenErr,ocamlCommentErr,ocamlCountErr,ocamlDoErr,ocamlDoneErr,ocamlEndErr,ocamlThenErr

syn cluster  ocamlAENoParen contains=ocamlBraceErr,ocamlBrackErr,ocamlCommentErr,ocamlCountErr,ocamlDoErr,ocamlDoneErr,ocamlEndErr,ocamlThenErr

syn cluster  ocamlContained contains=ocamlTodo,ocamlPreDef,ocamlModParam,ocamlModParam1,ocamlPreMPRestr,ocamlMPRestr,ocamlMPRestr1,ocamlMPRestr2,ocamlMPRestr3,ocamlModRHS,ocamlFuncWith,ocamlFuncStruct,ocamlModTypeRestr,ocamlModTRWith,ocamlWith,ocamlWithRest,ocamlModType,ocamlFullMod


" Enclosing delimiters
syn region   ocamlEncl contained containedin=meltCommand,meltCommandGlobal transparent matchgroup=ocamlKeyword start="(" matchgroup=ocamlKeyword end=")" contains=ALLBUT,@ocamlContained,ocamlParenErr
syn region   ocamlEncl contained containedin=meltCommand,meltCommandGlobal transparent matchgroup=ocamlKeyword start="{" matchgroup=ocamlKeyword end="}"  contains=ALLBUT,@ocamlContained,ocamlBraceErr
syn region   ocamlEncl contained containedin=meltCommand,meltCommandGlobal transparent matchgroup=ocamlKeyword start="\[" matchgroup=ocamlKeyword end="\]" contains=ALLBUT,@ocamlContained,ocamlBrackErr
syn region   ocamlEncl contained containedin=meltCommand,meltCommandGlobal transparent matchgroup=ocamlKeyword start="\[|" matchgroup=ocamlKeyword end="|\]" contains=ALLBUT,@ocamlContained,ocamlArrErr


" Comments
syn region   ocamlComment contained containedin=meltCommand,meltCommandGlobal start="(\*" end="\*)" contains=ocamlComment,ocamlTodo
syn keyword  ocamlTodo contained TODO FIXME XXX NOTE


" Objects
syn region   ocamlEnd contained containedin=meltCommand,meltCommandGlobal matchgroup=ocamlObject start="\<object\>" matchgroup=ocamlObject end="\<end\>" contains=ALLBUT,@ocamlContained,ocamlEndErr


" Blocks
if !exists("ocaml_revised")
  syn region   ocamlEnd contained containedin=meltCommand,meltCommandGlobal matchgroup=ocamlKeyword start="\<begin\>" matchgroup=ocamlKeyword end="\<end\>" contains=ALLBUT,@ocamlContained,ocamlEndErr
endif


" "for"
syn region   ocamlNone contained containedin=meltCommand,meltCommandGlobal matchgroup=ocamlKeyword start="\<for\>" matchgroup=ocamlKeyword end="\<\(to\|downto\)\>" contains=ALLBUT,@ocamlContained,ocamlCountErr


" "do"
if !exists("ocaml_revised")
  syn region   ocamlDo contained containedin=meltCommand,meltCommandGlobal matchgroup=ocamlKeyword start="\<do\>" matchgroup=ocamlKeyword end="\<done\>" contains=ALLBUT,@ocamlContained,ocamlDoneErr
endif

" "if"
syn region   ocamlNone contained containedin=meltCommand,meltCommandGlobal matchgroup=ocamlKeyword start="\<if\>" matchgroup=ocamlKeyword end="\<then\>" contains=ALLBUT,@ocamlContained,ocamlThenErr


"" Modules

" "struct"
syn region   ocamlStruct contained containedin=meltCommand,meltCommandGlobal matchgroup=ocamlModule start="\<struct\>" matchgroup=ocamlModule end="\<end\>" contains=ALLBUT,@ocamlContained,ocamlEndErr

" "sig"
syn region   ocamlSig contained containedin=meltCommand,meltCommandGlobal matchgroup=ocamlModule start="\<sig\>" matchgroup=ocamlModule end="\<end\>" contains=ALLBUT,@ocamlContained,ocamlEndErr,ocamlModule
syn region   ocamlModSpec matchgroup=ocamlKeyword start="\<module\>" matchgroup=ocamlModule end="\<\u\(\w\|'\)*\>" contained contains=@ocamlAllErrs,ocamlComment skipwhite skipempty nextgroup=ocamlModTRWith,ocamlMPRestr

" "open"
syn region   ocamlNone contained containedin=meltCommand,meltCommandGlobal matchgroup=ocamlKeyword start="\<open\>" matchgroup=ocamlModule end="\<\u\(\w\|'\)*\(\.\u\(\w\|'\)*\)*\>" contains=@ocamlAllErrs,ocamlComment

" "include"
syn match    ocamlKeyword contained containedin=meltCommand,meltCommandGlobal "\<include\>" skipwhite skipempty nextgroup=ocamlModParam,ocamlFullMod

" "module" - somewhat complicated stuff ;-)
syn region   ocamlModule contained containedin=meltCommand,meltCommandGlobal matchgroup=ocamlKeyword start="\<module\>" matchgroup=ocamlModule end="\<\u\(\w\|'\)*\>" contains=@ocamlAllErrs,ocamlComment skipwhite skipempty nextgroup=ocamlPreDef
syn region   ocamlPreDef start="."me=e-1 matchgroup=ocamlKeyword end="\l\|="me=e-1 contained contains=@ocamlAllErrs,ocamlComment,ocamlModParam,ocamlModTypeRestr,ocamlModTRWith nextgroup=ocamlModPreRHS
syn region   ocamlModParam start="([^*]" end=")" contained contains=@ocamlAENoParen,ocamlModParam1
syn match    ocamlModParam1 "\<\u\(\w\|'\)*\>" contained skipwhite skipempty nextgroup=ocamlPreMPRestr

syn region   ocamlPreMPRestr start="."me=e-1 end=")"me=e-1 contained contains=@ocamlAllErrs,ocamlComment,ocamlMPRestr,ocamlModTypeRestr

syn region   ocamlMPRestr start=":" end="."me=e-1 contained contains=@ocamlComment skipwhite skipempty nextgroup=ocamlMPRestr1,ocamlMPRestr2,ocamlMPRestr3
syn region   ocamlMPRestr1 matchgroup=ocamlModule start="\ssig\s\=" matchgroup=ocamlModule end="\<end\>" contained contains=ALLBUT,@ocamlContained,ocamlEndErr,ocamlModule
syn region   ocamlMPRestr2 start="\sfunctor\(\s\|(\)\="me=e-1 matchgroup=ocamlKeyword end="->" contained contains=@ocamlAllErrs,ocamlComment,ocamlModParam skipwhite skipempty nextgroup=ocamlFuncWith,ocamlMPRestr2
syn match    ocamlMPRestr3 "\w\(\w\|'\)*\(\.\w\(\w\|'\)*\)*" contained
syn match    ocamlModPreRHS "=" contained skipwhite skipempty nextgroup=ocamlModParam,ocamlFullMod
syn region   ocamlModRHS start="." end=".\w\|([^*]"me=e-2 contained contains=ocamlComment skipwhite skipempty nextgroup=ocamlModParam,ocamlFullMod
syn match    ocamlFullMod "\<\u\(\w\|'\)*\(\.\u\(\w\|'\)*\)*" contained skipwhite skipempty nextgroup=ocamlFuncWith

syn region   ocamlFuncWith start="([^*]"me=e-1 end=")" contained contains=ocamlComment,ocamlWith,ocamlFuncStruct skipwhite skipempty nextgroup=ocamlFuncWith
syn region   ocamlFuncStruct contained containedin=meltCommand,meltCommandGlobal matchgroup=ocamlModule start="[^a-zA-Z]struct\>"hs=s+1 matchgroup=ocamlModule end="\<end\>" contains=ALLBUT,@ocamlContained,ocamlEndErr

syn match    ocamlModTypeRestr "\<\w\(\w\|'\)*\(\.\w\(\w\|'\)*\)*\>" contained
syn region   ocamlModTRWith start=":\s*("hs=s+1 end=")" contained contains=@ocamlAENoParen,ocamlWith
syn match    ocamlWith "\<\(\u\(\w\|'\)*\.\)*\w\(\w\|'\)*\>" contained skipwhite skipempty nextgroup=ocamlWithRest
syn region   ocamlWithRest start="[^)]" end=")"me=e-1 contained contains=ALLBUT,@ocamlContained

" "module type"
syn region   ocamlKeyword contained containedin=meltCommand,meltCommandGlobal start="\<module\>\s*\<type\>" matchgroup=ocamlModule end="\<\w\(\w\|'\)*\>" contains=ocamlComment skipwhite skipempty nextgroup=ocamlMTDef
syn match    ocamlMTDef contained containedin=meltCommand,meltCommandGlobal "=\s*\w\(\w\|'\)*\>"hs=s+1,me=s

syn keyword  ocamlKeyword contained containedin=meltCommand,meltCommandGlobal  and as assert class
syn keyword  ocamlKeyword contained containedin=meltCommand,meltCommandGlobal  constraint else
syn keyword  ocamlKeyword contained containedin=meltCommand,meltCommandGlobal  exception external fun

syn keyword  ocamlKeyword contained containedin=meltCommand,meltCommandGlobal  in inherit initializer
syn keyword  ocamlKeyword contained containedin=meltCommand,meltCommandGlobal  land lazy let match
syn keyword  ocamlKeyword contained containedin=meltCommand,meltCommandGlobal  method mutable new of
syn keyword  ocamlKeyword contained containedin=meltCommand,meltCommandGlobal  parser private raise rec
syn keyword  ocamlKeyword contained containedin=meltCommand,meltCommandGlobal  try type
syn keyword  ocamlKeyword contained containedin=meltCommand,meltCommandGlobal  val virtual when while with

if exists("ocaml_revised")
  syn keyword  ocamlKeyword contained containedin=meltCommand,meltCommandGlobal  do value
  syn keyword  ocamlBoolean contained containedin=meltCommand,meltCommandGlobal  True False
else
  syn keyword  ocamlKeyword contained containedin=meltCommand,meltCommandGlobal  function
  syn keyword  ocamlBoolean contained containedin=meltCommand,meltCommandGlobal  true false
  syn match    ocamlKeyChar contained containedin=meltCommand,meltCommandGlobal  "!"
endif

syn keyword  ocamlType contained containedin=meltCommand,meltCommandGlobal     array bool char exn float format format4
syn keyword  ocamlType contained containedin=meltCommand,meltCommandGlobal     int int32 int64 lazy_t list nativeint option
syn keyword  ocamlType contained containedin=meltCommand,meltCommandGlobal     string unit

syn keyword  ocamlOperator contained containedin=meltCommand,meltCommandGlobal asr lor lsl lsr lxor mod not

syn match    ocamlConstructor contained containedin=meltCommand,meltCommandGlobal  "(\s*)"
syn match    ocamlConstructor contained containedin=meltCommand,meltCommandGlobal  "\[\s*\]"
syn match    ocamlConstructor contained containedin=meltCommand,meltCommandGlobal  "\[|\s*>|]"
syn match    ocamlConstructor contained containedin=meltCommand,meltCommandGlobal  "\[<\s*>\]"
syn match    ocamlConstructor contained containedin=meltCommand,meltCommandGlobal  "\u\(\w\|'\)*\>"

" Polymorphic variants
syn match    ocamlConstructor contained containedin=meltCommand,meltCommandGlobal  "`\w\(\w\|'\)*\>"

" Module prefix
syn match    ocamlModPath contained containedin=meltCommand,meltCommandGlobal      "\u\(\w\|'\)*\."he=e-1

syn match    ocamlCharacter contained containedin=meltCommand,meltCommandGlobal    "'\\\d\d\d'\|'\\[\'ntbr]'\|'.'"
syn match    ocamlCharErr contained containedin=meltCommand,meltCommandGlobal      "'\\\d\d'\|'\\\d'"
syn match    ocamlCharErr contained containedin=meltCommand,meltCommandGlobal      "'\\[^\'ntbr]'"
syn region   ocamlString contained containedin=meltCommand,meltCommandGlobal       start=+\\"+ skip=+\\\\+ end=+\\"+

syn match    ocamlFunDef contained containedin=meltCommand,meltCommandGlobal       "->"
syn match    ocamlRefAssign contained containedin=meltCommand,meltCommandGlobal    ":="
syn match    ocamlTopStop contained containedin=meltCommand,meltCommandGlobal      ";;"
syn match    ocamlOperator contained containedin=meltCommand,meltCommandGlobal     "\^"
syn match    ocamlOperator contained containedin=meltCommand,meltCommandGlobal     "::"

syn match    ocamlOperator contained containedin=meltCommand,meltCommandGlobal     "&&"
syn match    ocamlOperator contained containedin=meltCommand,meltCommandGlobal     "<"
syn match    ocamlOperator contained containedin=meltCommand,meltCommandGlobal     ">"
syn match    ocamlAnyVar contained containedin=meltCommand,meltCommandGlobal       "\<_\>"
syn match    ocamlKeyChar contained containedin=meltCommand,meltCommandGlobal      "|[^\]]"me=e-1
syn match    ocamlKeyChar contained containedin=meltCommand,meltCommandGlobal      ";"
syn match    ocamlKeyChar contained containedin=meltCommand,meltCommandGlobal      "\~"
syn match    ocamlKeyChar contained containedin=meltCommand,meltCommandGlobal      "?"
syn match    ocamlKeyChar contained containedin=meltCommand,meltCommandGlobal      "\*"
syn match    ocamlKeyChar contained containedin=meltCommand,meltCommandGlobal      "="

if exists("ocaml_revised")
  syn match    ocamlErr contained containedin=meltCommand,meltCommandGlobal        "<-"
else
  syn match    ocamlOperator contained containedin=meltCommand,meltCommandGlobal   "<-"
endif

syn match    ocamlNumber contained containedin=meltCommand,meltCommandGlobal        "\<-\=\d\(_\|\d\)*[l|L|n]\?\>"
syn match    ocamlNumber contained containedin=meltCommand,meltCommandGlobal        "\<-\=0[x|X]\(\x\|_\)\+[l|L|n]\?\>"
syn match    ocamlNumber contained containedin=meltCommand,meltCommandGlobal        "\<-\=0[o|O]\(\o\|_\)\+[l|L|n]\?\>"
syn match    ocamlNumber contained containedin=meltCommand,meltCommandGlobal        "\<-\=0[b|B]\([01]\|_\)\+[l|L|n]\?\>"
syn match    ocamlFloat contained containedin=meltCommand,meltCommandGlobal         "\<-\=\d\(_\|\d\)*\.\(_\|\d\)*\([eE][-+]\=\d\(_\|\d\)*\)\=\>"

" Labels
syn match    ocamlLabel contained containedin=meltCommand,meltCommandGlobal        "\~\(\l\|_\)\(\w\|'\)*"lc=1
syn match    ocamlLabel contained containedin=meltCommand,meltCommandGlobal        "?\(\l\|_\)\(\w\|'\)*"lc=1
syn region   ocamlLabel contained containedin=meltCommand,meltCommandGlobal transparent matchgroup=ocamlLabel start="?(\(\l\|_\)\(\w\|'\)*"lc=2 end=")"me=e-1 contains=ALLBUT,@ocamlContained,ocamlParenErr


" Synchronization
syn sync minlines=50
syn sync maxlines=500

if !exists("ocaml_revised")
  syn sync match ocamlDoSync      contained containedin=meltCommand,meltCommandGlobal grouphere  ocamlDo      "\<do\>"
  syn sync match ocamlDoSync      contained containedin=meltCommand,meltCommandGlobal groupthere ocamlDo      "\<done\>"
endif

if exists("ocaml_revised")
  syn sync match ocamlEndSync  contained containedin=meltCommand,meltCommandGlobal   grouphere  ocamlEnd     "\<\(object\)\>"
else
  syn sync match ocamlEndSync  contained containedin=meltCommand,meltCommandGlobal   grouphere  ocamlEnd     "\<\(begin\|object\)\>"
endif

syn sync match ocamlEndSync     contained containedin=meltCommand,meltCommandGlobal groupthere ocamlEnd     "\<end\>"
syn sync match ocamlStructSync  contained containedin=meltCommand,meltCommandGlobal grouphere  ocamlStruct  "\<struct\>"
syn sync match ocamlStructSync  contained containedin=meltCommand,meltCommandGlobal groupthere ocamlStruct  "\<end\>"
syn sync match ocamlSigSync     contained containedin=meltCommand,meltCommandGlobal grouphere  ocamlSig     "\<sig\>"
syn sync match ocamlSigSync     contained containedin=meltCommand,meltCommandGlobal groupthere ocamlSig     "\<end\>"

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_ocaml_syntax_inits")
  if version < 508
    let did_ocaml_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink ocamlBraceErr	   Error
  HiLink ocamlBrackErr	   Error
  HiLink ocamlParenErr	   Error
  HiLink ocamlArrErr	   Error

  HiLink ocamlCommentErr   Error

  HiLink ocamlCountErr	   Error
  HiLink ocamlDoErr	   Error
  HiLink ocamlDoneErr	   Error
  HiLink ocamlEndErr	   Error
  HiLink ocamlThenErr	   Error

  HiLink ocamlCharErr	   Error

  HiLink ocamlErr	   Error

  HiLink ocamlComment	   Comment

  HiLink ocamlModPath	   Include
  HiLink ocamlObject	   Include
  HiLink ocamlModule	   Include
  HiLink ocamlModParam1    Include
  HiLink ocamlModType	   Include
  HiLink ocamlMPRestr3	   Include
  HiLink ocamlFullMod	   Include
  HiLink ocamlModTypeRestr Include
  HiLink ocamlWith	   Include
  HiLink ocamlMTDef	   Include

  HiLink ocamlScript	   Include

  HiLink ocamlConstructor  Constant

  HiLink ocamlModPreRHS    Keyword
  HiLink ocamlMPRestr2	   Keyword
  HiLink ocamlKeyword	   Keyword
  HiLink ocamlMethod	   Include
  HiLink ocamlFunDef	   Keyword
  HiLink ocamlRefAssign    Keyword
  HiLink ocamlKeyChar	   Keyword
  HiLink ocamlAnyVar	   Keyword
  HiLink ocamlTopStop	   Keyword
  HiLink ocamlOperator	   Keyword

  HiLink ocamlBoolean	   Boolean
  HiLink ocamlCharacter    Character
  HiLink ocamlNumber	   Number
  HiLink ocamlFloat	   Float
  HiLink ocamlString	   String

  HiLink ocamlLabel	   Identifier

  HiLink ocamlType	   Type

  HiLink ocamlTodo	   Todo

  HiLink ocamlEncl	   Keyword
  HiLink ocamlLCIdentifier Identifier
  HiLink meltCmd  Identifier
  HiLink meltMath Special
  HiLink meltShortText String
  HiLink meltTextDelimiter String
  HiLink meltMail String
  HiLink meltUrl String
  HiLink meltNumber Number
  HiLink meltFile String

  delcommand HiLink
endif

let b:current_syntax = "ocaml"

" vim: ts=8
