" This file does not work with shellcmdflag=-ic

if exists("current_compiler")
  finish
endif

if exists(":CompilerSet") != 2    " older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

" If makefile exists and we are not asked to ignore it, we use standard make
" (do not redefine makeprg)
if exists('b:melt_ignore_makefile') || exists('g:melt_ignore_makefile') ||
  \(!filereadable('Makefile') && !filereadable('makefile'))
  " Similar with myocamlbuild.ml and ocamlbuild
  if exists('b:melt_ignore_ocamlbuild') || exists('g:melt_ignore_makefile') ||
    \(!filereadable('myocamlbuild.ml'))
  " If buffer-local variable 'melt_flavor' exists, it defines melt flavor,
  " otherwize the same for global variable with same name, else it will be
  " Lamelt
    if exists("b:melt_flavor")
      let current_compiler = b:melt_flavor
    elseif exists("g:melt_flavor")
      let current_compiler = g:melt_flavor
    else
      let current_compiler = "melt"
    endif
    "let &l:makeprg='{ : && '. current_compiler.' -pdf % && open %:r.pdf;}'
  else
    let current_compiler = 'ocamlbuild'
    let &l:makeprg ='ocamlbuild -j 0 all'
  endif
else
  let current_compiler = 'make'
  let &l:makeprg='make'
endif

" Value errorformat are taken from vim help, see :help errorformat-LaTeX, with
" addition from Srinath Avadhanula <srinath@fastmail.fm>
let s:cpo_save = &cpo
set cpo-=C
CompilerSet errorformat=
  \%E!\ LaTeX\ %trror:\ %m,
	\%E!\ %m,
	\%+W%.%#\ at\ lines\ %l--%*\\d,
	\%Cl.%l\ %m,
	\%+C\ \ %m.,
	\%+C%.%#-%.%#,
	\%+C%.%#[]%.%#,
	\%+C[]%.%#,
	\%+C%.%#%[{}\\]%.%#,
	\%+C<%.%#>%.%#,
	\%C\ \ %m,
	\%-GSee\ the\ LaTeX%m,
	\%-GType\ \ H\ <return>%m,
	\%-G\ ...%.%#,
	\%-G%.%#\ (C)\ %.%#,
	\%-G(see\ the\ transcript%.%#),
	\%-G\\s%#,
	\%+O(%*[^()])%r,
	\%+O%*[^()](%*[^()])%r,
	\%+P(%f%r,
	\%+P\ %\\=(%f%r,
	\%+P%*[^()](%f%r,
	\%+P[%\\d%[^()]%#(%f%r,
	\%+Q)%r,
	\%+Q%*[^()])%r,
	\%+Q[%\\d%*[^()])%r,
  \%EFile\ \"%f\"\\,\ line\ %l\\,\ characters\ %c-%*\\d:,
  \%EFile\ \"%f\"\\,\ line\ %l\\,\ character\ %c:%m,
  \%+EReference\ to\ unbound\ regexp\ name\ %m,
  \%Eocamlyacc:\ e\ -\ line\ %l\ of\ \"%f\"\\,\ %m,
  \%Wocamlyacc:\ w\ -\ %m,
  \%-Zmake%.%#,
  \%C%m,
  \%D%*\\a[%*\\d]:\ Entering\ directory\ `%f',
  \%X%*\\a[%*\\d]:\ Leaving\ directory\ `%f',
  \%D%*\\a:\ Entering\ directory\ `%f',
  \%X%*\\a:\ Leaving\ directory\ `%f',
  \%DMaking\ %*\\a\ in\ %f
	"\%+WLaTeX\ %.%#Warning:\ %.%#line\ %l%.%#,
	"\%WLaTeX\ %.%#Warning:\ %m

let &cpo = s:cpo_save
unlet s:cpo_save
