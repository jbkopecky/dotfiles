#! /bin/bash

export PATH="/Users/jean-baptiste_kopecky/Bin/miniconda3/bin:$PATH"
export PATH="/Users/jean-baptiste_kopecky/.scripts:$PATH"
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export NOTES_DIR='/Users/jean-baptiste_kopecky/Notes'

alias ls='ls -G'

man() {
    env \
    LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
    man "$@"
}

(cat ~/.cache/wal/sequences &)
