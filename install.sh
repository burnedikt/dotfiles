#!/usr/bin/env bash

# load installation helpers
source ./install/helpers.sh
# find out which platform we're running on
pf=`platforms`

# update all submodules
info "$(printf "Updating %b%s%b" $light_green "Git Submodules" $reset_color)"
git submodule update --init --recursive .
success "$(printf "%b%s%b successfully updated" $light_green "Git Submodules" $reset_color)"

# install the powerline fonts
info "$(printf "Installing / Checking %b%s%b" $light_green "Powerline Fonts" $reset_color)"
if [[ "$pf" == 'windows' ]]; then
  # check if fonts are maybe already installed
  source "./windows/bootstrap/fonts.sh"
else
  source ./fonts/install.sh
fi
success "$(printf "%b%s%b correctly installed" $light_green "Powerline Fonts" $reset_color)"

# Package Management
# run any platform specific package management tasks
if [[ -f "./${pf}/bootstrap/packages.sh" ]]; then
  info "$(printf "Installing / Updating Packages using %b%s%b" $light_green "Package Manager" $reset_color)"
  source "./${pf}/bootstrap/packages.sh"
fi

# Symlink / Dotfile Management
# see https://thelocehiliosan.github.io/yadm/docs/install
info "$(printf "Taking care of dotfiles / symlinking using %b%s%b" $light_green "yadm" $reset_color)"
which_yadm=`which yadm &>/dev/null`
if [[ $? != 0 ]]; then
  info "$(printf "Installing %b%s%b since it couldn\'t be found" $light_green "yadm" $reset_color)"
  if [[ "$pf" == 'windows' ]]; then
    mkdir -p ~/bin
    curl -fLo ~/bin/yadm https://github.com/TheLocehiliosan/yadm/raw/master/yadm && chmod a+x ~/bin/yadm
  elif [[ "$pf" == 'macos' ]]; then
    brew install yadm
  else
    fail "$(printf "Installation of %b%s%b not supported on platform %s" $light_red "yadm" $reset_color $light_green $pf $reset_color)"
  fi
else
  info "$(printf "%b%s%b already installed" $light_green "yadm" $reset_color)"
fi
success "$(printf "%b%s%b correctly installed" $light_green "yadm symlink manager" $reset_color)"


exit
# now that we're certain we got a package manager installed, let's install GNU stow
# and use it to symlink all our important dotfiles!
source ./install/stow.sh

# symlink the preferences for sublime, to do so, remove all local settings first and create a symlink instead
source ./install/sublime.sh

# run any platform specific bootstrap scripts (e.g. osx-defaults on macos)
if [[ -f "./${pf}/bootstrap/platform.sh" ]]; then
  info "$(printf "Running platform-specific scripts for %b%s%b" $light_green $pf $reset_color)"
  source "./${pf}/bootstrap/packages.sh"
fi
