#!/usr/bin/env bash

# symlink all required files
link_dotfiles() {
  local overwrite_all=false backup_all=false skip_all=false
  # git
  link_dotfiles_from_folder $DOTFILES_ROOT/cygwin/git
  # cross-platform dotfiles
  link_dotfiles_from_folder $DOTFILES_ROOT/cross-platform
  # (git-)bash
  link_dotfiles_from_folder $DOTFILES_ROOT/cygwin/bash
  # zsh (1) cross-platform
  link_dotfiles_from_folder $DOTFILES_ROOT/zsh
  # zsh (2) cygwin-platform
  link_dotfiles_from_folder $DOTFILES_ROOT/cygwin/zsh
  # zgen
  symlink $DOTFILES_ROOT/zsh/zgen $HOME/.zgen
}
# go ahead
link_dotfiles
success "All dotfiles for platform windows successfully synced"
