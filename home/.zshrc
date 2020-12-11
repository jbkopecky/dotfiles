setopt PROMPT_SUBST
export LSCOLORS="Gxfxcxdxbxegedabagacad"

# .zshrc
[ -f ~/.prompt ] && source .prompt
[ -f ~/.aliases ] && source .aliases
[ -f ~/.fzfrc ] && source .fzfrc

(cat ~/.cache/wal/sequences &)
wal --preview
