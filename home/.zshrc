setopt PROMPT_SUBST
export LSCOLORS="Gxfxcxdxbxegedabagacad"

bindkey "^[[H" beginning-of-line

# .zshrc
[ -f ~/.prompt ] && source .prompt
[ -f ~/.aliases ] && source .aliases
[ -f ~/.fzfrc ] && source .fzfrc

(cat ~/.cache/wal/sequences &)
