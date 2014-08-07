#!/bin/bash
#
# (The MIT License)
#
# Copyright (c) 2014 Aaron Lampros
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the 'Software'), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#

# ---------------------

# ABOUT:
#
# bash completion script for kmc (https://github.com/kmc/kmc).
#
# USAGE:
# 
# For use with bash_completion.
# Copy or alias this script to your bash_completion.d directory.
# or simply source it from your bashrc.

_kmc() {
  cur="${COMP_WORDS[COMP_CWORD]}"
  prev="${COMP_WORDS[COMP_CWORD-1]}"
  commands="init refresh install uninstall list search changelog help"	
  

  if [ $COMP_CWORD == 1 ]
  then
    COMPREPLY=($(compgen -W "${commands}" -- ${cur}))
    return 0
  fi

  if [ $COMP_CWORD -gt 1 ]
  then
    case "${COMP_WORDS[1]}" in
      "install"|"uninstall")
        local mod_list=$(kmc _listallpackages)
        COMPREPLY=($(compgen -W "${mod_list}" -- ${cur}))
        return 0
        ;;
      *)
        ;;
    esac
  fi

}
complete -F _kmc kmc
