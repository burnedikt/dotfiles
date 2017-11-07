#!/usr/bin/env bash

# symlink all required files
link_dotfiles() {
  local overwrite_all=false backup_all=false skip_all=false
  # git
  link_dotfiles_from_folder $DOTFILES_ROOT/linux/git
  # cross-platform dotfiles
  link_dotfiles_from_folder $DOTFILES_ROOT/cross-platform
  # (git-)bash
  link_dotfiles_from_folder $DOTFILES_ROOT/linux/bash
  # zsh cygwin-platform
  link_dotfiles_from_folder $DOTFILES_ROOT/linux/zsh
}
# make sure zsh is installed
sudo apt-get install zsh
# install zplug for zsh plugin management, see https://github.com/zplug/zplug#the-best-way
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh
# go ahead
link_dotfiles
success "All dotfiles for platform linux successfully synced"
