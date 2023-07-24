" Author: Carl Smedstad <carl.smedstad at protonmail dot com>
" Description: shellcheck linter for PKGBUILD files

call ale#handlers#shellcheck#DefineLinter('PKGBUILD')
