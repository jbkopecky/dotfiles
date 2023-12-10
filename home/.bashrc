#
# ~/.bashrc
#

# export
export PLATFORM=$(uname -s)
export EDITOR="vim"
export HISTCONTROL=ignoredups
export HISTIGNORE="cd *:ls:ls *:history*:cat *:clear:pwd:..:..."

# Better TAB completion.
bind 'TAB: menu-complete'
bind 'set show-all-if-ambiguous on'
bind 'set completion-ignore-case on'
bind 'set completion-map-case on'
bind 'set page-completions off'
bind 'set menu-complete-display-prefix on'
bind 'set completion-query-items 0'

# History completion.
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# aliases
alias tmux="tmux -2"
alias tml="tmux list-sessions"
alias tma="tmux attach-session"
alias tmc="clear && tmux clear-history"
alias tmk="tmux kill-session"
alias tm="tmux new-session"
alias urxvt="urxvtc"
alias vi="vim"
alias v="vim"
alias l='ls'
alias ll='l -lha'
alias la='l -a'
alias grep='grep --color=auto'
alias ..='cd ..'
alias ...='cd ../..'
alias met='curl wttr.in/paris?0'
alias meteo='curl wttr.in/paris'

# PS1 with error, and git info
export PROMPT_CHAR=➜ 
__set_ps1() {
    # {{{
    local nor="\[\033[m\]"   # normal -- white
    local err="\[\033[0;31m\]"   # error -- red
    local por="\[\033[0;35m\]"   # prompt char
    local clean="\[\033[0;32m\]" # clean git
    local average="\[\033[0;33m\]" # neutral
    local dirty="\[\033[0;31m\]" # dirty git
    local rst="\[\033[0m\]"      # Text Reset

    # git info
    local gitinfo=
    local branch=$(git symbolic-ref HEAD --short 2> /dev/null)
    if [[ $branch ]]; then
        local x=$(git status --porcelain | grep -v '^??')
        if [[ $x ]]; then
            gitinfo="${nor}(${dirty}${branch}${nor})"
        else
            gitinfo="${nor}(${clean}${branch}${nor})"
        fi
    fi
    local venv=
    if [[ $VIRTUAL_ENV != "" ]]; then
        venv="${nor}(${average}${VIRTUAL_ENV##*/}${nor})${rst}"
    fi

    local cenv=
    if [[ $CONDA_DEFAULT_ENV != "" ]]; then
        cenv="${nor}(${average}${CONDA_DEFAULT_ENV##*/}${nor})${rst}"
    fi
    #
    # generate prompt »
    PS1="\n $nor\W ${venv}${cenv}${gitinfo}\$([[ \$? != 0 ]] && echo \"$err\" || echo \"$por\") $PROMPT_CHAR $rst"
}
#}}}

PROMPT_COMMAND="__set_ps1"

[ -f ~/.local.bashrc ] && source ~/.local.bashrc

[ -d ~/.scripts ] && PATH="$PATH:$HOME/.scripts"
