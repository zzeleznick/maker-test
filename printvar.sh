#!/bin/bash

# Resources
# 0. https://blog.melski.net/2010/11/30/makefile-hacks-print-the-value-of-any-variable/
# 1. https://github.com/andreineculau/util.mk/blob/master/util.mk
# 2. http://wiki.bash-hackers.org/commands/classictest

# Get filename of Makefile
filename=""
if [ -f makefile ] ; then
  filename="makefile"
elif [ -f Makefile ] ; then
  filename="Makefile"
fi
if [ -n "$filename" ] ; then
  vars=""
  if [ -z "$@" ]; then
    echo "***** No variables to print *****"
    echo "Specify a variable like 'SHELL'"
    exit 1
  fi
  for n in $@ ; do
    vars="$vars print-$n"
  done
  make -f $filename -f printvar.mk $vars
else
  echo "No makefile found" 1>&2
  exit 1
fi