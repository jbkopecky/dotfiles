#
# ~/.bashrc
#

# export
export EDITOR="vim"
export HISTCONTROL=ignoredups
export HISTIGNORE="cd *:ls:ls *:history*:cat *:clear:pwd:..:..."
export PATH="${PATH}:/home/jb/.scripts"

# aliases
alias tmux="tmux -2"
alias tml="tmux list-sessions"
alias tma="tmux attach-session"
alias tmc="clear && tmux clear-history"
alias tmk="tmux kill-session"
alias tm="tmux new-session"
<<<<<<< HEAD
=======
alias urxvt="urxvtc"
alias rg="ranger"

# Vim aliases
>>>>>>> 07e6addfaf14818858ce236fc7b9a89611083241
alias vi="vim"
alias v="vim"
alias l='ls --color=auto --group-directories-first -h'
alias ll='l -la'
alias la='l -a'
alias grep='grep --color=auto'
alias ..='cd ..'
alias ...='cd ../..'
alias clean='sudo pacman -Rns $(pacman -Qtdq)'
alias mp3="youtube-dl --extract-audio --audio-format mp3"
alias album="youtube-dl --extract-audio --audio-format mp3 \
    -o '%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s'"


# PS1 with error, and git info
export PROMPT_CHAR=✿
__set_ps1 (){
    # {{{
    local err="\[\033[0;31m\]"   # error -- red
    local nor="\[\033[1;30m\]"   # normal -- white
    local por="\[\033[0;35m\]"   # prompt char
    local dirty="\[\033[0;33m\]" # dirty git
    local rst="\[\033[0m\]"      # Text Reset

    # git info
    local gitinfo=
    local branch=$(git symbolic-ref HEAD --short 2> /dev/null)
    if [[ $branch ]]; then
        local x=$(git status --porcelain)
        if [[ $x ]]; then
            gitinfo="${nor}(${dirty}${branch}${nor})"
        else
            gitinfo="${nor}(${branch})"
        fi
    fi
    local venv=
    if [[ $VIRTUAL_ENV != "" ]]; then
        venv="${nor}(${dirty}${VIRTUAL_ENV##*/}${nor})${rst}"
    fi
    #
    # generate prompt »
    PS1="\n $nor\W ${venv}${gitinfo}\$([[ \$? != 0 ]] && echo \"$err\" || echo \"$por\") $PROMPT_CHAR $rst"
}
#}}}

PROMPT_COMMAND="__set_ps1"


[ -f ~/.fzf.bash ] && source ~/.fzf.bash
[ -f ~/.local.bashrc ] && source ~/.local.bashrc
[ -f ~/.scripts/fzfrc ] && source ~/.scripts/fzfrc
[ -f ~/.scripts/hyperjump ] && source ~/.scripts/hyperjump
[ -f $HOME/.dircolors ] && eval $(dircolors -b $HOME/.dircolors)

