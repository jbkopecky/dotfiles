# Variables ****************************************************************{{{

export EDITOR=vim
export LANG=en_US.UTF-8

EXTRA=$HOME/.local.bashrc
PLUGGINS=$HOME/Bin

DEFAULT_BG="dark"
DEFAULT_COLOR="gruvbox"

# }}}

# Aliases ******************************************************************{{{
# TMUX aliases
alias tmux="tmux -2"
alias tml="tmux list-sessions"
alias tma="tmux attach-session"
alias tmc="clear && tmux clear-history"
alias tmk="tmux kill-session"
alias tm="tmux new-session"

# Vim aliases
alias vim="vim --servername VIM"
alias vi="vim"
alias v="vim"

# Aliases
alias cd.='cd ..'
alias cd..='cd ..'
alias l='ls -CF'
alias ll='ls -alF'
alias la='ls -a'

alias how="howdoi -c"

#}}}

# Functions ****************************************************************{{{

# Useful .. func
..() {
    for i in $(seq $1); do cd ..; done;
}

# The Fuck
alias fuck='eval $(thefuck $(fc -ln -1)); history -r'

# Remove all *.pyc recursively
alias clean='find . -name "*.pyc" -exec rm -rf {} \;'

# }}}

# Misc *********************************************************************{{{

HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s histappend
shopt -s checkwinsize

# Colored ls
if [ -x /usr/bin/dircolors ]; then
  eval "`dircolors -b`"
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
fi

# Colored GCC
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# friendly less
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

#}}}

# Color Management *********************************************************{{{

# Must be in XTerm and have installed xtermcontrol to use this hack
cl=$PLUGGINS/color_manager.sh
[ -f "$cl" ] && source "$cl"

# }}}

# Responsive Prompt ********************************************************{{{

prpt=$PLUGGINS/my_prompt.sh
[ -f "$prpt" ] && source "$prpt"

PROMPT_COMMAND=prompt

# }}}

# Hyperjump ****************************************************************{{{
hyp=$PLUGGINS/hyperjump
[ -f "$hyp" ] && source "$hyp"
# }}}

# Browse *******************************************************************{{{
bro=$PLUGGINS/browse.sh
Browse(){
    if [ -f "$bro" ]; then
        exec "$bro" "$@"
    fi
}
# }}}

# Extra Bashrc: to set some paths / variables ******************************{{{
[ -f "$EXTRA" ] && source "$EXTRA"
# }}}
