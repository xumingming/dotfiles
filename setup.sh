#!/bin/bash
# This script is used to setup the nessisary soft links for the dotfiles

# Setup the specified soft link
setup_link() {
    path=$1
    from_path=~/Code/dotfiles/$path
    to_path=~/$path
    if [ ! -d $to_path -a ! -f $to_path ]; then
        /bin/ln -s $from_path $to_path
        echo "Link $from_path to $to_path"
    else
        echo "WARNNING: $to_path already exists, so will not copy."
    fi
}

setup_link ".bashrc"
setup_link ".zshrc"

setup_link ".ssh/config"
setup_link ".tmux.conf"

mkdir -vp ~/.zsh


