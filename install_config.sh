#!/usr/bin/env bash

set -x
set -e

mkdir -p ~/config/nvim

for f in `find . -regex ".*\.vim$\|.*\.lua$"`; do
    rm -rf ~/.config/nvim/$f
    cp ./init.vim ~/.config/nvim/$f
done

nvim --headless +PlugInstall +qa
