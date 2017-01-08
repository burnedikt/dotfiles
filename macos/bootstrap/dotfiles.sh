#!/usr/bin/env bash

# symlink all required files
link_dotfiles() {
  local overwrite_all=false backup_all=false skip_all=false
  # git
  link_dotfiles_from_folder $DOTFILES_ROOT/macos/git
  # zsh
  link_dotfiles_from_folder $DOTFILES_ROOT/macos/zsh
  # cross-platform dotfiles
  link_dotfiles_from_folder $DOTFILES_ROOT/cross-platform
  # sandboxd script
  DOTFILES_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd ../.. && pwd )"
  symlink $DOTFILES_ROOT/sandboxd/sandboxd $HOME/.sandboxd
   # zgen
  symlink $DOTFILES_ROOT/macos/zsh/zgen $HOME/.zgen
}
# go ahead
link_dotfiles
success "All dotfiles for platform macos successfully linked"
