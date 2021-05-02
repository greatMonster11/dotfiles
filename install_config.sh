#!/usr/bin/env bash

set -x
set -e

mkdir -p ~/config/nvim
mkdir -p ~/config/nvim/plugin

# This is just a comment
for f in `find . -regex ".*\.vim$\|.*\.lua$"`; do
    rm -rf ~/.config/nvim/$f
    if [[ $f = "./init.vim" ]]; then
        cp ./init.vim ~/.config/nvim/$f
    else  
        cp $f ~/.config/nvim/plugin/
    fi
done

nvim --headless +PlugInstall +qa
