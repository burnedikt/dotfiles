#!/usr/bin/env bash

# symlink all required files
link_dotfiles() {
  local overwrite_all=false backup_all=false skip_all=false
  # git
  link_dotfiles_from_folder "$DOTFILES_ROOT/cygwin/git"
  # cross-platform dotfiles
  link_dotfiles_from_folder "$DOTFILES_ROOT/cross-platform"
  # (git-)bash
  link_dotfiles_from_folder "$DOTFILES_ROOT/windows/bash"
  # zsh cygwin-platform
  link_dotfiles_from_folder "$DOTFILES_ROOT/cygwin/zsh"
}
# install zplug for zsh plugin management, see https://github.com/zplug/zplug#the-best-way
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
# go ahead
link_dotfiles
success "All dotfiles for platform cygwin successfully synced"
