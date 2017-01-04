#!/usr/bin/env zsh

# load installation helpers
source ./install/helpers.sh
# find out which platform we're running on
_platform=`platform`

# update all submodules
git submodule update --init --recursive .

# install the powerline fonts
echo 'Installing Powerline fonts ...'
  if [[ "$_platform" == "cygwin" ]]; then
    # check if fonts are maybe already installed
    font_check_path=`cygpath --windows -a ./install/windows/fonts.ps1`
    powershell -ExecutionPolicy Bypass "$font_check_path"
    # exit code will be 1 if not installed yet
    if [[ $? == 1 ]]; then
      # if not installed yet, install now
      font_install_win_path=`cygpath --windows -a ./fonts/install.ps1`
      powershell -ExecutionPolicy Bypass "$font_install_win_path"
    fi
  else
    source ./fonts/install.sh
  fi

# Package Management
source ./install/package-management.sh

# now that we're certain we got a package manager installed, let's install GNU stow
# and use it to symlink all our important dotfiles!
source ./install/stow.sh

# symlink the preferences for sublime, to do so, remove all local settings first and create a symlink instead
source ./install/sublime.sh

if [[ "$_platform" == "macos" ]]; then
  echo "Do you wish to install sensible defaults for OSX (this might take some time)?"
    select yn in "Yes" "No"; do
        case $yn in
            Yes ) echo 'Tweaking OS X...'; source "$(pwd)/osx-defaults.sh" break;;
            No ) echo 'Not tweaking OS X. Just re-run install.sh if you change your mind'; break;;
        esac
    done
fi

echo 'Installing Applications with Package manager ...'

if [[ "$_platform" == "cygwin" ]]; then
  pact install stow
elif [[ "$_platform" == "macos" ]]; then
  cd ./install/macos/ && brew bundle
else
  echo 'Your current platform is unsupported. Please manually install GNU stow before proceeding'
fi
