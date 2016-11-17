#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# source my own .dircolors file
if [ -f $HOME/.dircolors ]; then
    eval $(dircolors -b $HOME/.dircolors)
fi

# aliases
alias tmux="tmux -2"
alias tml="tmux list-sessions"
alias tma="tmux attach-session"
alias tmc="clear && tmux clear-history"
alias tmk="tmux kill-session"
alias tm="tmux new-session"

# Vim aliases
alias vi="vim"
alias v="vim"

alias l='ls'
alias ls='ls --color=auto --group-directories-first -h'
alias ll='ls -la'
alias la='ls -a'
alias grep='grep --color=auto'
alias ..='cd ..'
alias ...='cd ../..'


# PS1 with error, and git info
__set_ps1 (){
    local err="\[\033[0;31m\]"   # error -- red
    local nor="\[\033[1;36m\]"   # normal -- white
    local por="\[\033[0;35m\]"   # prompt char
    local dirty="\[\033[0;33m\]" # dirty git
    local rst="\[\033[0m\]"      # Text Reset

    # git info
    local gitinfo=
    local branch=$(git symbolic-ref HEAD --short 2> /dev/null)
    if [[ $branch ]]; then
        local x=$(git status --porcelain)
        if [[ $x ]]; then
            gitinfo="${nor}(${dirty}${branch}${nor}) "
        else
            gitinfo="${nor}(${branch}) "
        fi
    fi
    #
    # generate prompt »
    PS1="\n $nor\W ${gitinfo}\$([[ \$? != 0 ]] && echo \"$err\" || echo \"$por\")✿ $rst"
}
# set PS1
PROMPT_COMMAND="__set_ps1"

# history settings
export HISTSIZE=2000
export HISTFILESIZE=2000
export HISTCONTROL=ignoreboth:erasedups
export HISTIGNORE="cd *:ls:ls *:history*:cat *:clear:pwd:..:..."

# disable flow control
stty -ixon
set bell-style none

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
[ -f ~/.local.bashrc ] && source ~/.local.bashrc
