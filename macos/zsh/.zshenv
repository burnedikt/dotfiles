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

# path for Go lang packages
export GOPATH=/usr/local/lib/gocode

# JAVA Home
export JAVA_HOME=`/usr/libexec/java_home -v 1.8`

# Ruby / RVM
export GEM_HOME=$HOME/.gem
export GEM_PATH=$HOME/.gem

# Open ssl stuff
export DYLD_LIBRARY_PATH=/usr/local/opt/openssl/lib

export LOCATE_PATH=/var/db/locate.database

# include nvm
NVM_DIR="$HOME/.nvm"

# include anaconda (assuming its installed inthe correct path)
ANACONDA_DIR="$HOME/anaconda2/bin"

# Add ICU4C to path (required by node and installed via brew)
# do the same for ruby, gmes
ICU4C_DIR="/usr/local/opt/icu4c/bin:/usr/local/opt/icu4c/sbin"

# Set GNU-sed as the default sed
GNU_SED_DIR="/usr/local/opt/gnu-sed/libexec/gnubin"

# Use homebrew's sqlite installation
SQLITE_DIR="/usr/local/opt/sqlite/bin"

# Mono
MONO_DIR=/Library/Frameworks/Mono.framework/Versions/Current/Commands

# Conditional PATH additions
for path_candidate in /opt/local/sbin \
  /Applications/Xcode.app/Contents/Developer/usr/bin \
  /opt/local/bin \
  /usr/local/share/npm/bin \
  $HOME/.cabal/bin \
  $HOME/.rbenv/bin \
  $HOME/bin \
  $HOME/src/gocode/bin \
  $NVM_DIR \
  $ANACONDA_DIR \
  $ICU4C_DIR \
  $GNU_SED_DIR \
  $SQLITE_DIR \
  $MONO_DIR \
  $GOPATH/bin \
  /usr/local/opt/go/libexec/bin \
  $HOME/.rvm/bin
do
  if [ -d ${path_candidate} ]; then
    export PATH=${PATH}:${path_candidate}
  fi
done

# enable agent forwarding for oh-my-zsh ssh-agent plugin, https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/ssh-agent#instructions
zstyle :omz:plugins:ssh-agent agent-forwarding on
