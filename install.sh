#!/bin/bash
#
# Symlinks all hidden files to ~
#

if [[ -d "$1" ]]; then
    INSTALL_DIR="$1"
else
    INSTALL_DIR=~
fi

for f in .[^.]*; do
    if [[ ! -d "$f" ]]; then
        if [[ -e $INSTALL_DIR/"$f" ]]; then
            rm -i $INSTALL_DIR/"$f"
        fi

        ln "$f" $INSTALL_DIR/"$f"
    fi
done
