#!/usr/bin/env bash

# symlink all required files
link_dotfiles() {
  DOTFILES_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd ../.. && pwd )"
  local overwrite_all=false backup_all=false skip_all=false
  # git
  link_dotfiles_from_folder $DOTFILES_ROOT/macos/git
  # zsh osx-specific
  link_dotfiles_from_folder $DOTFILES_ROOT/macos/zsh
  # cross-platform dotfiles
  link_dotfiles_from_folder $DOTFILES_ROOT/cross-platform
  # sandboxd script
  symlink $DOTFILES_ROOT/sandboxd/sandboxd $HOME/.sandboxd
}
# install zplug for dotfile management
curl -sL zplug.sh/installer | zsh
# go ahead
link_dotfiles
success "All dotfiles for platform macos successfully linked"
