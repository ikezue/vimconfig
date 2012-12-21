#!/bin/bash -i

# Adapted from github.com/moshen/vimconfig/blob/master/setup.sh

# This script does the following:
# . clones the Vim config repo at github.com/ikezue/vimconfig into $HOME/.vim
# . clones Vundle, the Vim bundler, into $HOME/.vim/bundle/vundle
# . creates the symbolic link $HOME/.vimrc -> $HOME/.vim/vimrc
# . installs the bundles listed in github.com/ikezue/vimconfig/blob/master/vimrc

# Moves a file from src to dst and prints message upon completion
# Usage: move_file(src, dst, message)
move_file() {
  if [ -e "$1" ]; then
    mv $1 $2
    echo "$3"
  fi
}

# Start from the home directory
cd $HOME

# Make a timestamped copy of $HOME/.vim, if it already exists
timestamp=$(date "+%Y%m%d_%H%M%S")
move_file ".vim" ".vim.$timestamp" "$HOME/.vim was moved to $HOME/.vim.$timestamp"

# Clone github.com/ikezue/vimconfig into $HOME/.vim
git clone https://github.com/ikezue/vimconfig.git .vim
if [ $? -ne 0 ]; then
  echo "Git clone of ikezue/vimconfig failed, exiting..."
  move_file ".vim.$timestamp" ".vim" "$HOME/.vim.$timestamp has been restored to $HOME/.vim"
  exit 1
fi

# Clone github.com/gmarik/vundle into $HOME/.vim/bundle/vundle
cd .vim
git clone https://github.com/gmarik/vundle.git bundle/vundle
if [ $? -ne 0 ]; then
  echo "Git clone of gmarik/vundle failed, exiting..."
  exit 1
fi

# Create symbolic link $HOME/.vimrc -> $HOME/.vim/vimrc
cd $HOME
files=(vimrc) # replace with 'files=(vimrc gvimrc)' in Windows-enabled version
for f in "${files[@]}"; do
  if [ -f ".$f" ]; then
    timestamp=$(date "+%Y%m%d_%H%M%S")
    if [ "$(readlink -n .$f)" == ".vim/$f" ]; then
      echo "$HOME/.$f already links to the right file"
    else
      move_file ".$f" ".$f.$timestamp" "$HOME/.$f was moved to $HOME/.$f.$timestamp"
      ln -s .vim/$f .$f
    fi
  else
    ln -s .vim/$f .$f
  fi
done

# Install bundles
vim +BundleInstall +qall 2>/dev/null

# Rename Git remote
cd .vim
git remote rename origin github

echo "Done!  Vim is fully configured."
exit 0
