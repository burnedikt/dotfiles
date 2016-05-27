#!/usr/bin/env bash

# This install script is based on [PaulMillr's](https://github.com/paulmillr) excellent install script

# check if brew is installed already, if it isn't prompt the user to do so
# If we on OS X, install homebrew and tweak system a bit.
if [[ `uname` == 'Darwin' ]]; then
  which -s brew
  if [[ $? != 0 ]]; then
    echo 'Installing Homebrew...'
      ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
      brew update
  fi

  # install the powerline fonts
  echo 'Installing Powerline fonts ...'
    source ./fonts/install.sh

  # now that we're certain we got brew installed, let's install GNU stow
  # GNU stow is a symlink manager and can help us
  which -s stow
  if [[ $? != 0 ]]; then
    echo 'Installing GNU Stow'
      brew install stow
  fi

  # now symlink the configuration files / dotfiles for zsh to our home folder
  echo 'Symlinking global dotfiles'
    stow -v -t ~ -d system .
  echo 'Symlinking zsh dotfiles'
    stow -v -t ~ -d zsh .

  # setup zsh with all kinds of plugins using zgen
   source ~/.zgen-setup

  # symlink the preferences for sublime, to do so, remove all local settings first and create a symlink instead
  echo "Updating Sublime Text 3 Configuration"

  SUBLIMEPATH=~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User
  CONFIGPATH=$(pwd)/sublime/Packages/User
  FILES="$CONFIGPATH/*.sublime-settings"
  for file in $FILES
  do
    filename=$(basename "$file")
    # take action on each file. $f store current file name
    # check whether the file already exists in the sublime text folder.
    if [ -L "$SUBLIMEPATH/$filename" ]; then
      # if it is a symlink, overwrite it
      echo "Symlink to config file $filename already exists. Overwriting ..."
    elif [ -f "$SUBLIMEPATH/$filename" ]; then
      # if it is a file, back it up
      echo "Config File $filename already exists. Backing up ..."
      cp "$SUBLIMEPATH/$filename" "$SUBLIMEPATH/$filename.bak"
    fi
    # now replace the file / symlink with a symlink into our repo
    ln -sf "$file" "$SUBLIMEPATH"
  done

  echo 'Tweaking OS X...'
    source "$(pwd)/osx-defaults.sh"

  # http://github.com/sindresorhus/quick-look-plugins
  echo 'Installing Applications with Homebrew ...'
    brew bundle
fi
