#!/usr/bin/env bash

# symlink all required files
link_dotfiles() {
  local overwrite_all=false backup_all=false skip_all=false
  # git
  link_dotfiles_from_folder "$DOTFILES_ROOT/windows/git"
  # cross-platform dotfiles
  link_dotfiles_from_folder "$DOTFILES_ROOT/cross-platform"
  # (git-)bash
  link_dotfiles_from_folder "$DOTFILES_ROOT/windows/bash"
  # windows specific aliases
  symlink "$DOTFILES_ROOT/cygwin/.win-aliases" "$HOME/.win-aliases"
}
# go ahead
link_dotfiles
success "All dotfiles for platform windows successfully synced"
