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

syn region meltText           contained contains=meltMath,meltCommand,@Spell matchgroup=meltTextDelimiter start=+\\\@<!"+ skip=+\\"+ matchgroup=meltTextDelimiter end=+"+
syn region meltCommand contains=meltText,meltMath start="\%^" end="\%$"
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
syn match    ocamlComment contained containedin=meltCommand   "^#!.*"

" Scripting directives
syn match    ocamlScript contained containedin=meltCommand "^#\<\(quit\|labels\|warnings\|directory\|cd\|load\|use\|install_printer\|remove_printer\|require\|thread\|trace\|untrace\|untrace_all\|print_depth\|print_length\)\>"

" Script headers highlighted like comments
syn match    ocamlComment contained containedin=meltCommand      "^#!.*"

" lowercase identifier - the standard way to match
syn match    ocamlLCIdentifier           contained containedin=meltCommand       /\<\(\l\|_\)\(\w\|'\)*\>/
"syn match    ocamlLCIdentifierGlobalMelt contained containedin=meltCommandGlobal /\<\(\l\|_\)\(\w\|'\)*\>/

syn match    ocamlKeyChar contained containedin=meltCommand    "|"

" Errors
"syn match    ocamlBraceErr contained containedin=meltCommand   "}"
syn match    ocamlBrackErr contained containedin=meltCommand   "\]"
syn match    ocamlParenErr contained containedin=meltCommand   ")"
syn match    ocamlArrErr contained containedin=meltCommand     "|]"

syn match    ocamlCommentErr contained containedin=meltCommand "\*)"

syn match    ocamlCountErr contained containedin=meltCommand   "\<downto\>"
syn match    ocamlCountErr contained containedin=meltCommand   "\<to\>"

if !exists("ocaml_revised")
  syn match    ocamlDoErr contained containedin=meltCommand      "\<do\>"
endif

syn match    ocamlDoneErr contained containedin=meltCommand    "\<done\>"
syn match    ocamlThenErr contained containedin=meltCommand    "\<then\>"

" Error-highlighting of "end" without synchronization:
" as keyword or as error (default)
if exists("ocaml_noend_error")
  syn match    ocamlKeyword contained containedin=meltCommand    "\<end\>"
else
  syn match    ocamlEndErr contained containedin=meltCommand     "\<end\>"
endif

" Some convenient clusters
syn cluster  ocamlAllErrs contains=ocamlBraceErr,ocamlBrackErr,ocamlParenErr,ocamlCommentErr,ocamlCountErr,ocamlDoErr,ocamlDoneErr,ocamlEndErr,ocamlThenErr

syn cluster  ocamlAENoParen contains=ocamlBraceErr,ocamlBrackErr,ocamlCommentErr,ocamlCountErr,ocamlDoErr,ocamlDoneErr,ocamlEndErr,ocamlThenErr

syn cluster  ocamlContained contains=ocamlTodo,ocamlPreDef,ocamlModParam,ocamlModParam1,ocamlPreMPRestr,ocamlMPRestr,ocamlMPRestr1,ocamlMPRestr2,ocamlMPRestr3,ocamlModRHS,ocamlFuncWith,ocamlFuncStruct,ocamlModTypeRestr,ocamlModTRWith,ocamlWith,ocamlWithRest,ocamlModType,ocamlFullMod


" Enclosing delimiters
syn region   ocamlEncl contained containedin=meltCommand transparent matchgroup=ocamlKeyword start="(" matchgroup=ocamlKeyword end=")" contains=ALLBUT,@ocamlContained,ocamlParenErr
syn region   ocamlEncl contained containedin=meltCommand transparent matchgroup=ocamlKeyword start="{" matchgroup=ocamlKeyword end="}"  contains=ALLBUT,@ocamlContained,ocamlBraceErr
syn region   ocamlEncl contained containedin=meltCommand transparent matchgroup=ocamlKeyword start="\[" matchgroup=ocamlKeyword end="\]" contains=ALLBUT,@ocamlContained,ocamlBrackErr
syn region   ocamlEncl contained containedin=meltCommand transparent matchgroup=ocamlKeyword start="\[|" matchgroup=ocamlKeyword end="|\]" contains=ALLBUT,@ocamlContained,ocamlArrErr


" Comments
syn region   ocamlComment contained containedin=meltCommand,meltText,meltMath start="(\*" end="\*)" contains=ocamlComment,ocamlTodo
"syn region   ocamlComment contained containedin=meltCommand start="(\*" end="\*)" contains=ocamlComment,ocamlTodo
syn keyword  ocamlTodo contained TODO FIXME XXX NOTE


" Objects
syn region   ocamlEnd contained containedin=meltCommand matchgroup=ocamlObject start="\<object\>" matchgroup=ocamlObject end="\<end\>" contains=ALLBUT,@ocamlContained,ocamlEndErr


" Blocks
if !exists("ocaml_revised")
  syn region   ocamlEnd contained containedin=meltCommand matchgroup=ocamlKeyword start="\<begin\>" matchgroup=ocamlKeyword end="\<end\>" contains=ALLBUT,@ocamlContained,ocamlEndErr
endif


" "for"
syn region   ocamlNone contained containedin=meltCommand matchgroup=ocamlKeyword start="\<for\>" matchgroup=ocamlKeyword end="\<\(to\|downto\)\>" contains=ALLBUT,@ocamlContained,ocamlCountErr


" "do"
if !exists("ocaml_revised")
  syn region   ocamlDo contained containedin=meltCommand matchgroup=ocamlKeyword start="\<do\>" matchgroup=ocamlKeyword end="\<done\>" contains=ALLBUT,@ocamlContained,ocamlDoneErr
endif

" "if"
syn region   ocamlNone contained containedin=meltCommand matchgroup=ocamlKeyword start="\<if\>" matchgroup=ocamlKeyword end="\<then\>" contains=ALLBUT,@ocamlContained,ocamlThenErr


"" Modules

" "struct"
syn region   ocamlStruct contained containedin=meltCommand matchgroup=ocamlModule start="\<struct\>" matchgroup=ocamlModule end="\<end\>" contains=ALLBUT,@ocamlContained,ocamlEndErr

" "sig"
syn region   ocamlSig contained containedin=meltCommand matchgroup=ocamlModule start="\<sig\>" matchgroup=ocamlModule end="\<end\>" contains=ALLBUT,@ocamlContained,ocamlEndErr,ocamlModule
syn region   ocamlModSpec matchgroup=ocamlKeyword start="\<module\>" matchgroup=ocamlModule end="\<\u\(\w\|'\)*\>" contained contains=@ocamlAllErrs,ocamlComment skipwhite skipempty nextgroup=ocamlModTRWith,ocamlMPRestr

" "open"
syn region   ocamlNone contained containedin=meltCommand matchgroup=ocamlKeyword start="\<open\>" matchgroup=ocamlModule end="\<\u\(\w\|'\)*\(\.\u\(\w\|'\)*\)*\>" contains=@ocamlAllErrs,ocamlComment

" "include"
syn match    ocamlKeyword contained containedin=meltCommand "\<include\>" skipwhite skipempty nextgroup=ocamlModParam,ocamlFullMod

" "module" - somewhat complicated stuff ;-)
syn region   ocamlModule contained containedin=meltCommand matchgroup=ocamlKeyword start="\<module\>" matchgroup=ocamlModule end="\<\u\(\w\|'\)*\>" contains=@ocamlAllErrs,ocamlComment skipwhite skipempty nextgroup=ocamlPreDef
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
syn region   ocamlFuncStruct contained containedin=meltCommand matchgroup=ocamlModule start="[^a-zA-Z]struct\>"hs=s+1 matchgroup=ocamlModule end="\<end\>" contains=ALLBUT,@ocamlContained,ocamlEndErr

syn match    ocamlModTypeRestr "\<\w\(\w\|'\)*\(\.\w\(\w\|'\)*\)*\>" contained
syn region   ocamlModTRWith start=":\s*("hs=s+1 end=")" contained contains=@ocamlAENoParen,ocamlWith
syn match    ocamlWith "\<\(\u\(\w\|'\)*\.\)*\w\(\w\|'\)*\>" contained skipwhite skipempty nextgroup=ocamlWithRest
syn region   ocamlWithRest start="[^)]" end=")"me=e-1 contained contains=ALLBUT,@ocamlContained

" "module type"
syn region   ocamlKeyword contained containedin=meltCommand start="\<module\>\s*\<type\>" matchgroup=ocamlModule end="\<\w\(\w\|'\)*\>" contains=ocamlComment skipwhite skipempty nextgroup=ocamlMTDef
syn match    ocamlMTDef contained containedin=meltCommand "=\s*\w\(\w\|'\)*\>"hs=s+1,me=s

syn keyword  ocamlKeyword contained containedin=meltCommand  and as assert class
syn keyword  ocamlKeyword contained containedin=meltCommand  constraint else
syn keyword  ocamlKeyword contained containedin=meltCommand  exception external fun

syn keyword  ocamlKeyword contained containedin=meltCommand  in inherit initializer
syn keyword  ocamlKeyword contained containedin=meltCommand  land lazy let match
syn keyword  ocamlKeyword contained containedin=meltCommand  method mutable new of
syn keyword  ocamlKeyword contained containedin=meltCommand  parser private raise rec
syn keyword  ocamlKeyword contained containedin=meltCommand  try type
syn keyword  ocamlKeyword contained containedin=meltCommand  val virtual when while with

if exists("ocaml_revised")
  syn keyword  ocamlKeyword contained containedin=meltCommand  do value
  syn keyword  ocamlBoolean contained containedin=meltCommand  True False
else
  syn keyword  ocamlKeyword contained containedin=meltCommand  function
  syn keyword  ocamlBoolean contained containedin=meltCommand  true false
  syn match    ocamlKeyChar contained containedin=meltCommand  "!"
endif

syn keyword  ocamlType contained containedin=meltCommand     array bool char exn float format format4
syn keyword  ocamlType contained containedin=meltCommand     int int32 int64 lazy_t list nativeint option
syn keyword  ocamlType contained containedin=meltCommand     string unit

syn keyword  ocamlOperator contained containedin=meltCommand asr lor lsl lsr lxor mod not

syn match    ocamlConstructor contained containedin=meltCommand  "(\s*)"
syn match    ocamlConstructor contained containedin=meltCommand  "\[\s*\]"
syn match    ocamlConstructor contained containedin=meltCommand  "\[|\s*>|]"
syn match    ocamlConstructor contained containedin=meltCommand  "\[<\s*>\]"
syn match    ocamlConstructor contained containedin=meltCommand  "\u\(\w\|'\)*\>"

" Polymorphic variants
syn match    ocamlConstructor contained containedin=meltCommand  "`\w\(\w\|'\)*\>"

" Module prefix
syn match    ocamlModPath contained containedin=meltCommand      "\u\(\w\|'\)*\."he=e-1

syn match    ocamlCharacter contained containedin=meltCommand    "'\\\d\d\d'\|'\\[\'ntbr]'\|'.'"
syn match    ocamlCharErr contained containedin=meltCommand      "'\\\d\d'\|'\\\d'"
syn match    ocamlCharErr contained containedin=meltCommand      "'\\[^\'ntbr]'"
syn region   ocamlString contained containedin=meltCommand       start=+\\"+ skip=+\\\\+ end=+\\"+

syn match    ocamlFunDef contained containedin=meltCommand       "->"
syn match    ocamlRefAssign contained containedin=meltCommand    ":="
syn match    ocamlTopStop contained containedin=meltCommand      ";;"
syn match    ocamlOperator contained containedin=meltCommand     "\^"
syn match    ocamlOperator contained containedin=meltCommand     "@"
syn match    ocamlOperator contained containedin=meltCommand     "::"

syn match    ocamlOperator contained containedin=meltCommand     "&&"
syn match    ocamlOperator contained containedin=meltCommand     "<"
syn match    ocamlOperator contained containedin=meltCommand     ">"
syn match    ocamlAnyVar contained containedin=meltCommand       "\<_\>"
syn match    ocamlKeyChar contained containedin=meltCommand      "|[^\]]"me=e-1
syn match    ocamlKeyChar contained containedin=meltCommand      ";"
syn match    ocamlKeyChar contained containedin=meltCommand      ","
syn match    ocamlKeyChar contained containedin=meltCommand      "\~"
syn match    ocamlKeyChar contained containedin=meltCommand      "&"
syn match    ocamlKeyChar contained containedin=meltCommand      "+"
syn match    ocamlKeyChar contained containedin=meltCommand      "/"
syn match    ocamlKeyChar contained containedin=meltCommand      "-"
syn match    ocamlKeyChar contained containedin=meltCommand      ":"
syn match    ocamlKeyChar contained containedin=meltCommand      "\."
syn match    ocamlKeyChar contained containedin=meltCommand      "?"
syn match    ocamlKeyChar contained containedin=meltCommand      "\*"
syn match    ocamlKeyChar contained containedin=meltCommand      "="

if exists("ocaml_revised")
  syn match    ocamlErr contained containedin=meltCommand        "<-"
else
  syn match    ocamlOperator contained containedin=meltCommand   "<-"
endif

syn match    ocamlNumber contained containedin=meltCommand        "\<-\=\d\(_\|\d\)*[l|L|n]\?\>"
syn match    ocamlNumber contained containedin=meltCommand        "\<-\=0[x|X]\(\x\|_\)\+[l|L|n]\?\>"
syn match    ocamlNumber contained containedin=meltCommand        "\<-\=0[o|O]\(\o\|_\)\+[l|L|n]\?\>"
syn match    ocamlNumber contained containedin=meltCommand        "\<-\=0[b|B]\([01]\|_\)\+[l|L|n]\?\>"
syn match    ocamlFloat contained containedin=meltCommand         "\<-\=\d\(_\|\d\)*\.\(_\|\d\)*\([eE][-+]\=\d\(_\|\d\)*\)\=\>"

" Labels
syn match    ocamlLabel contained containedin=meltCommand        "\~\(\l\|_\)\(\w\|'\)*"lc=1
syn match    ocamlLabel contained containedin=meltCommand        "?\(\l\|_\)\(\w\|'\)*"lc=1
syn region   ocamlLabel contained containedin=meltCommand transparent matchgroup=ocamlLabel start="?(\(\l\|_\)\(\w\|'\)*"lc=2 end=")"me=e-1 contains=ALLBUT,@ocamlContained,ocamlParenErr


" Synchronization
syn sync minlines=50
syn sync maxlines=500

if !exists("ocaml_revised")
  syn sync match ocamlDoSync      contained containedin=meltCommand grouphere  ocamlDo      "\<do\>"
  syn sync match ocamlDoSync      contained containedin=meltCommand groupthere ocamlDo      "\<done\>"
endif

if exists("ocaml_revised")
  syn sync match ocamlEndSync  contained containedin=meltCommand   grouphere  ocamlEnd     "\<\(object\)\>"
else
  syn sync match ocamlEndSync  contained containedin=meltCommand   grouphere  ocamlEnd     "\<\(begin\|object\)\>"
endif

syn sync match ocamlEndSync     contained containedin=meltCommand groupthere ocamlEnd     "\<end\>"
syn sync match ocamlStructSync  contained containedin=meltCommand grouphere  ocamlStruct  "\<struct\>"
syn sync match ocamlStructSync  contained containedin=meltCommand groupthere ocamlStruct  "\<end\>"
syn sync match ocamlSigSync     contained containedin=meltCommand grouphere  ocamlSig     "\<sig\>"
syn sync match ocamlSigSync     contained containedin=meltCommand groupthere ocamlSig     "\<end\>"

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
