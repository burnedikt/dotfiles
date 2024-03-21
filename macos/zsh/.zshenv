#!/usr/bin/env zsh

# Used for setting user's environment variables; it should not contain commands that produce output or assume
# the shell is attached to a tty. This file will always be sourced.
# see https://wiki.archlinux.org/index.php/zsh

# Make Python use UTF-8 encoding for output to stdin, stdout, and stderr.
export PYTHONIOENCODING='UTF-8';

# Don’t clear the screen after quitting a manual page.
export MANPAGER='less -X';

# use VS Code as default editor
export EDITOR='code -w'

# include nvm
NVM_DIR="$HOME/.nvm"

# Set GNU-sed as the default sed
GNU_SED_DIR="/usr/local/opt/gnu-sed/libexec/gnubin"

# Conditional PATH additions
for path_candidate in /opt/local/sbin \
  /Applications/Xcode.app/Contents/Developer/usr/bin \
  /opt/local/bin \
  $HOME/bin \
  $NVM_DIR \
  $GNU_SED_DIR \
  $HOME/.pyenv/bin \
  /usr/local/bin
do
  if [ -d ${path_candidate} ]; then
    export PATH=${PATH}:${path_candidate}
  fi
done

# Pyenv (Python version manager)
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# enable agent forwarding for oh-my-zsh ssh-agent plugin, https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/ssh-agent#instructions
zstyle :omz:plugins:ssh-agent agent-forwarding on

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
