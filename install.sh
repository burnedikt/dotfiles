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
info "$(printf "Taking care of dotfiles through %b%s%b" $light_green "symlinking" $reset_color)"
if [[ -f "./${pf}/bootstrap/dotfiles.sh" ]]; then
  info "$(printf "Installing dotfiles to %b\$HOME%b=%b%s%b for %b\$OSTYPE%b=%b%s%b" \
      $light_red $reset_color \
      $green "$HOME" $reset_color \
      $light_red $reset_color \
      $light_yellow "$pf" $reset_color)"
  source "./${pf}/bootstrap/dotfiles.sh"
fi

# symlink the preferences for sublime, to do so, remove all local settings first and create a symlink instead
if [[ -f "./${pf}/bootstrap/sublime.sh" ]]; then
  info "$(printf "Synchronizing %b%s%b specific settings" $light_green "Sublime Text 3" $reset_color)"
  source ./install/sublime.sh
fi

# run any platform specific bootstrap scripts (e.g. osx-defaults on macos)
if [[ -f "./${pf}/bootstrap/platform.sh" ]]; then
  info "$(printf "Running platform-specific scripts for %b%s%b" $light_green $pf $reset_color)"
  source "./${pf}/bootstrap/platform.sh"
fi

info "Updating bash / zsh configuration"
if [[ "$pf" == 'windows' ]]; then
  source $HOME/.bashrc
elif [[ "$pf" == 'macos' ]]; then
  source $HOME/.zshrc
else
  fail "Platform $pf not supported"
fi

success "All done"
