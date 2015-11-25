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

mkdir ~/.vim/backups
mkdir ~/.vim/undo
mkdir ~/.vim/swaps

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
