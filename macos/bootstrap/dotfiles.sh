#!/usr/bin/env bash

# symlink all required files
link_dotfiles() {
  DOTFILES_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd ../.. && pwd )"
  local overwrite_all=false backup_all=false skip_all=false
  # git
  link_dotfiles_from_folder $DOTFILES_ROOT/macos/git
  # zsh cross-platform
  link_dotfiles_from_folder $DOTFILES_ROOT/cross-platform/zsh
  # zsh osx-specific
  link_dotfiles_from_folder $DOTFILES_ROOT/macos/zsh
  # cross-platform dotfiles
  link_dotfiles_from_folder $DOTFILES_ROOT/cross-platform
  # starship prompt configuration
  symlink $DOTFILES_ROOT/cross-platform/starship.toml $HOME/.config/starship.toml
}

# install zi as a plugin manager for zsh, see https://wiki.zshell.dev/docs
if [[ ! -f $HOME/.zi/bin/zi.zsh ]]; then
  print -P "%F{33}▓▒░ %F{160}Installing (%F{33}z-shell/zi%F{160})…%f"
  command mkdir -p "$HOME/.zi" && command chmod go-rwX "$HOME/.zi"
  command git clone -q --depth=1 --branch "main" https://github.com/z-shell/zi "$HOME/.zi/bin" && \
    print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
    print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

# go ahead
link_dotfiles
success "All dotfiles for platform macos successfully linked"
