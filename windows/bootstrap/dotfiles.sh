#!/usr/bin/env bash

# symlink all required files
link_dotfiles() {
  local overwrite_all=false backup_all=false skip_all=false
  # git
  link_dotfiles_from_folder $DOTFILES_ROOT/windows/git
  # bash
  link_dotfiles_from_folder $DOTFILES_ROOT/windows/bash
  # cross-platform dotfiles
  link_dotfiles_from_folder $DOTFILES_ROOT/cross-platform
}
# go ahead
link_dotfiles
success "All dotfiles for platform windows successfully synced"
