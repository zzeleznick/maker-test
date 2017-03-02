#!/bin/bash

if [ -z "$@" ]; then
    count=0
    search_term=""
    if [ -n "$term" ]; then
        search_term="$term"
    fi
    while read -r line; do
        count=$((count + 1))
        echo $line | python -c 'import sys; print(sys.stdin.read().replace(";", "\n ").strip())'
    done
    if [ $((0)) -eq $((count)) ]; then
        echo "**** No help found for $search_term ****"
    fi
else
    pcregrep -B 1 "^$*:" 'Makefile' 'printvar.mk' | \
    awk '{gsub("Makefile:?-?|--", ""); print}' | \
    awk '{gsub("printvar.mk:?-?", ""); print}' | \
    pcregrep -v -e '^[a-zA-Z0-9][^\$$#\t=]*:' | \
    pcregrep -v -e 'PHONY:' | \
    pcregrep -v -e '^$'
fi

