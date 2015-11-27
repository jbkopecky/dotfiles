#!/bin/bash

# RC files
cd $(dirname $BASH_SOURCE)
BASE=$(pwd)
touch bashrc-extra
for rc in *rc *profile tmux.conf gitconfig; do
  mkdir -pv bak
  [ -e ~/.$rc ] && mv -v ~/.$rc bak/.$rc
  ln -sfv $BASE/$rc ~/.$rc
done

ln -sfv $BASE/vim ~/.vim
ln -sfv $BASE/tmux ~/.tmux
ln -sfv $BASE/bin ~/.bin

mkdir ~/.vim/backups
mkdir ~/.vim/undo
mkdir ~/.vim/swaps
mkdir ~/.vim/info

# git-prompt
if [ ! -e ~/.git-prompt.sh ]; then
  wget https://raw.github.com/git/git/master/contrib/completion/git-prompt.sh \
      -O ~/.git-prompt.sh
fi

# tpm
if [ ! -e ~/.tmux/plugins/tpm ]; then
  echo "Installing Tmux Plugin Manager"
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# git profile
git config --global user.email "jb.kopecky@gmail.com"
git config --global user.name "jbkopecky"

# XTerm
if ! command_exists xterm; then
  sudo apt-get install xterm -y
fi

if [ ! -f ~/.Xresources ]; then
  echo "   Creating Xresources!"
  ln -sf $BASE/Xresources ~/.Xresources
  xrdb -merge  ~/.Xresources
else 
  echo "   Deleting old Xresources!"
  rm ~/.Xresources
  ln -sf $BASE/Xresources ~/.Xresources
  xrdb -merge  ~/.Xresources
fi

